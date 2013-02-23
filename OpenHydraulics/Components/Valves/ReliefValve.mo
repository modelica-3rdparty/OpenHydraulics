within OpenHydraulics.Components.Valves;
model ReliefValve "Simple equation model for a relief valve"
  // sizing parameters
  parameter SI.Pressure dp_relief(final min=0) = 1e7 "Relief pressure"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Pressure dp_open(final min=0) = dp_relief*1.05
    "Fully open pressure"
    annotation (Dialog(tab="Sizing"));
  parameter SI.VolumeFlowRate q_nom(final min=0) = 0.01
    "Nominal flow rate when fully open"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Density d_nom = 850 "Nominal density"
    annotation (Dialog(tab="Sizing"));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // advanced parameters
  parameter Real timeConstant(final min=0)=0.01
    annotation (Dialog(tab="Advanced"));
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

  // main variables
  SI.Pressure dp = port_a.p - port_b.p "Pressure drop from port_a to port_b";

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}},
          rotation=0)));

  // internal component
  OpenHydraulics.Basic.VariableRestriction variableRestriction(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final use_Re=use_Re,
    final from_dp=from_dp,
    final dp_small=dp_small,
    m_flow_small=m_flow_small,
    D_nom=0.01,
    final q_nom=q_nom,
    final dp_nom=dp_open)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0)));

  Real valvePosition(start=0) "Normalized valve position (between 0 and 1)";
  Real valvePositionSteadyState "Steady state position of valve)";

algorithm
  variableRestriction.control := valvePosition;
initial equation
  assert(dp_relief<dp_open,"The relief pressure must be smaller than the fully open pressure");
equation
  // THIS IS THE ONLY DIFFERENCE WITH A CHECK VALVE
  // valve should open when p_a>p_b+dp_relief or dp>dp_relief
  valvePositionSteadyState = max(0,min((dp-dp_relief)/(dp_open - dp_relief),1));

  // add valve dynamics if necessary
  if timeConstant > 0 then
    der(valvePosition) = (valvePositionSteadyState - valvePosition)/timeConstant;
  else
    valvePosition = valvePositionSteadyState;
  end if;

  connect(variableRestriction.port_a, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={255,0,0}));
  connect(variableRestriction.port_b, port_b) annotation (Line(points={{10,
          0},{52,0},{52,0},{100,0}}, color={255,0,0}));
  annotation (
    Diagram(graphics={
        Text(
          extent={{-90,40},{-60,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "A"),
        Text(
          extent={{60,40},{90,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "B"),
        Text(
          extent={{0,-40},{0,-52}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "for valve dynamics"),
        Text(
          extent={{0,-28},{0,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "see equations section"),
        Rectangle(extent={{-52,-24},{52,-56}}, lineColor={0,0,255}),
        Line(points={{0,-8},{0,-24}}, color={0,0,255})}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,-60}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-100,0}}, color={0,0,0}),
        Line(points={{100,0},{40,0}}, color={0,0,0}),
        Line(points={{-40,-20},{40,-20}}, color={0,0,0}),
        Polygon(
          points={{40,-20},{24,-16},{24,-24},{40,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-40},{0,-60},{-70,-60},{-70,0}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(points={{20,40},{-20,48},{20,56},{-20,64},{20,72},{-20,80},{20,
              80}}, color={0,0,0}),
        Line(points={{-42,74},{36,48}}, color={0,0,0}),
        Polygon(
          points={{-42,74},{-30,74},{-32,68},{-42,74}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{60,40},{90,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-98,40},{-50,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{0,-60},{0,-90}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    DymolaStoredErrors);
end ReliefValve;
