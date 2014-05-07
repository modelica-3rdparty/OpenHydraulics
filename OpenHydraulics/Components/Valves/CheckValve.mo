within OpenHydraulics.Components.Valves;
model CheckValve "Simple equation model for a check valve"
  // sizing parameters
  parameter SI.Pressure dp_open(final min=0) = 6000 "Fully open pressure"
    annotation (Dialog(tab="Sizing"));
  parameter SI.VolumeFlowRate q_nom(final min=0) = 0.01
    "Nominal flow rate when fully open"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Density d_nom = 850 "Nominal density"
    annotation (Dialog(tab="Sizing"));

  parameter Boolean use_Re = false
    "= true, if turbulent region is defined by Re, otherwise by dp_small or m_flow_small"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter SI.AbsolutePressure dp_small = 1
    "Turbulent flow if |dp| >= dp_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re));

  // main variables
  SI.Pressure dp = port_a.p - port_b.p "Pressure drop from port_a to port_b";
  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));

  // internal component
  OpenHydraulics.Basic.VariableRestrictionSeriesValve variableRestriction(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final use_Re=use_Re,
    final dp_small=dp_small,
    D_nom=0.01,
    final q_nom=q_nom,
    final dp_nom=dp_open,
    d_nom=d_nom,
    p_init=p_init)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

equation
  variableRestriction.control = max(0,min(-dp/dp_open,1));
  connect(variableRestriction.port_a, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={255,0,0}));
  connect(variableRestriction.port_b, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={255,0,0}));
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
          extent={{-88,44},{88,-48}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-12,0},{-100,0}}, color={0,0,0}),
        Line(points={{100,0},{29,0}}, color={0,0,0}),
        Ellipse(
          extent={{-11,16},{21,-16}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-4,30},{29,0},{-4,-30}}, color={0,0,0}),
        Text(
          extent={{56,40},{94,0}},
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
          extent={{-100,80},{100,52}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(points={{-42,10},{-38,-10},{-34,10},{-30,-10},{-26,10},{-22,-10},
              {-18,10},{-14,-10},{-10,10}}, color={0,0,0})}));
end CheckValve;
