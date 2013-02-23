within OpenHydraulics.Components.Valves;
model PostPCValve "Simple equation model for a post PC valve"
  // sizing parameters
  parameter Modelica.SIunits.Pressure p_margin=100000;
  parameter Modelica.SIunits.Density d_nom=850 "Nominal density"
    annotation (Dialog(tab="Sizing"));
  extends OpenHydraulics.Interfaces.PartialFluidComponent;
public
  parameter Real time_constant=0;
  // advanced parameters
  parameter Boolean from_dp = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean use_Re = false
    "= true, if turbulent region is defined by Re, otherwise by dp_small or m_flow_small"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.AbsolutePressure dp_small=1
    "Turbulent flow if |dp| >= dp_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
  parameter Modelica.SIunits.MassFlowRate m_flow_small=0.01
    "Turbulent flow if |m_flow| >= m_flow_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and not from_dp));

  // main variables
  Modelica.SIunits.Pressure dp=port_a.p - port_b.p
    "Pressure drop from port_a to port_b";
  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort port_LS
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}},
          rotation=0)));

  OpenHydraulics.Basic.VariableRestriction variableRestriction(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    use_Re=use_Re,
    from_dp=from_dp,
    dp_small=dp_small,
    m_flow_small=m_flow_small,
    D_nom=0.01,
    min_contr=0,
    max_contr=1,
    table=[0.0,0.0; 1,1])
    annotation (Placement(transformation(extent={{0,-10},{20,10}}, rotation=
           0)));
protected
  Real valvePosition(start=0) "Input for controller"
                                                annotation (Dialog(tab="Sizing"));

algorithm
  variableRestriction.control := valvePosition;

equation
 valvePosition =max(0, min((port_b.p - port_LS.p)/(p_margin), 1));
 port_LS.m_flow=0;
  connect(port_a, variableRestriction.port_a)  annotation (Line(points={{
          -100,0},{0,0}}, color={255,0,0}));
  connect(variableRestriction.port_b, port_b)  annotation (Line(points={{20,
          0},{100,0}}, color={255,0,0}));
annotation (
    Diagram(graphics={
        Text(
          extent={{-90,60},{-60,20}},
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
          extent={{10,-60},{10,-72}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "for valve dynamics"),
        Text(
          extent={{10,-48},{10,-60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "see equations section"),
        Rectangle(extent={{-40,-44},{64,-76}}, lineColor={0,0,255}),
        Line(points={{10,-8},{10,-44}}, color={0,0,255})}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-84,86},{88,-88}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,72},{48,-32}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-18,0},{-102,0}}, color={0,0,0}),
        Line(points={{96,0},{46,0}}, color={0,0,0}),
        Polygon(
          points={{48,48},{32,52},{32,44},{48,48}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-60},{0,-32},{0,-80},{-2,-80}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(points={{32,-52},{12,-48},{32,-44},{12,-40},{32,-36},{12,-32},
              {42,-32}}, color={0,0,0}),
        Line(points={{-30,48},{48,48}}, color={0,0,0}),
        Text(
          extent={{72,38},{94,4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-90,32},{-62,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{0,106},{0,76}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(points={{-30,0},{-20,0},{-18,0},{-16,0}}, color={0,0,0}),
        Line(points={{-16,8},{-16,-8}}, color={0,0,0}),
        Line(points={{32,8},{32,-8}}, color={0,0,0}),
        Line(points={{32,0},{48,0}}, color={0,0,0}),
        Line(
          points={{8,72},{8,80},{64,80},{64,0}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(points={{-30,22},{48,22}}, color={0,0,0})}),
    DymolaStoredErrors);
end PostPCValve;
