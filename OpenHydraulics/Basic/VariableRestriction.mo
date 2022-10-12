within OpenHydraulics.Basic;
model VariableRestriction "Flow loss due to controllable restriction"
  import Modelica.Constants.pi;

  // sizing parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 1e6 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing"));

  // the metering curve parameters
  parameter Real table[:, :]=[0,0; 1,1]
    "Metering curve (control = 1st col; fraction of q_nom = 2nd col)"
       annotation(Dialog(tab="Metering Curve",group="Table"));
  parameter Modelica.Blocks.Types.Smoothness smoothness=
    Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation"
    annotation(Dialog(tab="Metering Curve",group="Table"));
  parameter SI.Diameter D_nom = 0.005 "Nominal diameter when fully open"
    annotation(Dialog(tab="Metering Curve",group="Nominal values"));

  parameter SI.Density d_nom = 850 "Nominal fluid density for metering curve"
    annotation(Dialog(tab="Metering Curve",group="Nominal values"));
  parameter Real zeta_nom = 2 "Loss factor when fully open"
    annotation(Dialog(tab="Metering Curve",group="Nominal values"));

  // advanced parameters
  parameter Real min_contr = 0 "Lower bound on control input"
    annotation(Dialog(tab="Metering Curve",group="Control"));
  parameter Real max_contr = 1 "Upper bound on control input"
    annotation(Dialog(tab="Metering Curve",group="Control"));
  parameter SI.ReynoldsNumber Re_turbulent = 3000
    "Reynolds number at transition to tubulent flow"
    annotation(Dialog(tab="Advanced"));

  extends BaseClasses.RestrictionInterface;

  parameter Boolean from_dp = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean use_Re = false
    "= true, if turbulent region is defined by Re, otherwise by dp_small or m_flow_small"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter SI.AbsolutePressure dp_small = 1
    "Turbulent flow if |dp| >= dp_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
  parameter SI.MassFlowRate m_flow_small = 0.01
    "Turbulent flow if |m_flow| >= m_flow_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and not from_dp));

  SI.ReynoldsNumber Re = BaseClasses.ReynoldsNumber_m_flow(
        port_a.m_flow,
        (oil.dynamicViscosity(p_a) + oil.dynamicViscosity(p_b))/2,
        data.D_Re) if use_Re "Reynolds number at diameter D_Re";

  // the ports
  Modelica.Blocks.Interfaces.RealInput control
    "control inside [min_contr,max_contr]"
    annotation (Placement(transformation(
        origin={0,-80},
        extent={{-20,20},{20,-20}},
        rotation=90)));

  // internal blocks
  Modelica.Blocks.Tables.CombiTable1Ds MeteringTable(
    tableOnFile=false,table=table,smoothness=smoothness)
    annotation (Placement(transformation(extent={{18,-32},{-2,-12}})));

protected
  BaseClasses.LossFactorData data(
      D_a=D_nom,
      D_b=D_nom,
      kinv1=kinv,
      kinv2=kinv,
      Re_turbulent=Re_turbulent,
      D_Re=(8*kinv*zeta_nom/(pi*pi))^(1/4),
      zetaLaminarKnown=false,
      c0=0) "Data used when metering";
  Real openFraction "Fraction of Restriction that is open";
  Real kinv "Loss factor (function of control input)";
  SI.Density d_a = oil.density(p_a) "Density at port a";
  SI.Density d_b = oil.density(p_b) "Density at port b";
initial equation
  assert(data.D_Re>0 or not use_Re,"If D_Re==0 then Re evaluates to infinity");

equation
  MeteringTable.u =  max(min(control,max_contr),min_contr);
  openFraction = max(min(MeteringTable.y[1], 1), 0);
  kinv = d_nom*openFraction*openFraction*q_nom*q_nom/dp_nom;

  // NOTE: the smooth and noEvent avoid events being generated.  This is important to
  // avoid going through re-initialization of the solver which sometimes take a significant
  // amount of time.
  if from_dp then
     port_a.m_flow = smooth(1,if noEvent(data.kinv1<=0) or noEvent(data.kinv2<=0) then 0 else
          if use_Re then
                 BaseClasses.massFlowRate_dp_and_Re(
                    dp, d_a, d_b,
                    oil.dynamicViscosity(p_a),
                    oil.dynamicViscosity(p_b),
                    data) else
                 BaseClasses.massFlowRate_dp(dp, d_a, d_b, data, dp_small));
  else
     assert(not (data.kinv1<=0 or data.kinv2<=0),
       "Pressure drop cannot be determined when restriction is completely closed;  set from_dp=true");
     dp = if use_Re then
             BaseClasses.pressureLoss_m_flow_and_Re(
                 port_a.m_flow, d_a, d_b,
                 oil.dynamicViscosity(p_a),
                 oil.dynamicViscosity(p_b),
                 data) else
             BaseClasses.pressureLoss_m_flow(port_a.m_flow, d_a, d_b, data, m_flow_small);
  end if;

  // mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

  annotation (Diagram(graphics={
        Line(points={{-20,-40},{20,40}}, color={0,0,0}),
        Polygon(
          points={{20,40},{4,24},{16,18},{20,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{20,-22},{40,-22},{40,-60},{0,-60}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{-20,-40},{-8,-40},{-8,-22},{-2,-22}},
          color={0,0,0},
          pattern=LinePattern.Dash)}),
                            Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Line(points={{-20,-40},
              {20,40}}, color={0,0,0}), Polygon(
          points={{20,40},{4,24},{16,18},{20,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end VariableRestriction;
