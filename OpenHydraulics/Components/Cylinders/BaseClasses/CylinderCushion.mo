within OpenHydraulics.Components.Cylinders.BaseClasses;
model CylinderCushion

  // the parameters
  parameter Real cushionTable[:, :]=[0,0.001;0.029,0.01;0.03,1]
    "Cushion flow rate (1st col = s_rel; 2nd col = fraction of q_nom)"
    annotation(Dialog(tab="Sizing",group="Cushion Table"));
  parameter Modelica.Blocks.Types.Smoothness smoothness=
    Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation"
    annotation(Dialog(tab="Sizing",group="Cushion Table"));

  parameter SI.VolumeFlowRate q_nom = 0.01 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing",group="Nominal Values"));
  parameter SI.AbsolutePressure dp_nom = 1e4 "Nominal pressure drop at q_nom"
    annotation(Dialog(tab="Sizing",group="Nominal Values"));

  parameter SI.Diameter D_nom = 0.05 "Nominal diameter when fully open"
    annotation(Dialog(tab="Sizing",group="Nominal Values"));
  parameter SI.Density d_nom = 850 "Nominal fluid density for metering curve"
    annotation(Dialog(tab="Sizing",group="Nominal Values"));
  parameter Real zeta_nom = 2 "Loss factor when fully open"
    annotation(Dialog(tab="Sizing",group="Nominal Values"));

  parameter SI.Pressure dp_relief(final min=0) = 1e20 "Relief pressure"
    annotation (Dialog(tab="Advanced"));

  // main variables
  SI.Distance s_rel = flange_b.s - flange_a.s "distance until end-of-travel";
  SI.Velocity v_rel = der(s_rel) "relative velocity";
  SI.Pressure dp(start=0,fixed=true) = port_a.p - port_b.p
    "Pressure drop from port_a to port_b";

  // internal component
  OpenHydraulics.Basic.VariableRestriction cushionRestriction(
    q_nom=q_nom,
    dp_nom=dp_nom,
    D_nom=D_nom,
    d_nom=d_nom,
    zeta_nom=zeta_nom,
    final min_contr=0,
    final max_contr=1,
    p_init=p_init)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270)));
  Valves.ReliefValve reliefValve(
    p_init=p_init,
    q_nom=q_nom,
    dp_relief=dp_relief)
    annotation (Placement(transformation(
        origin={60,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Tables.CombiTable1Dv cushionTableBlock(
    table=cushionTable,
    columns=2:2,
    smoothness=smoothness) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
    "(right) driven flange (flange axis directed OUT OF cut plane)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
    "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)"
     annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

protected
  Real flowFraction "fraction of flow allowed by cushion";
  Real flowFractionSteadyState "desired steady state flow fraction";
  Real flowFractionCushion "flow fraction as specified in cushion table";

equation
  cushionTableBlock.u[1] = s_rel;
  cushionTableBlock.y[1] = flowFractionCushion;
  cushionRestriction.control = flowFraction;

  if flowFractionCushion<1 and s_rel>0 and v_rel<0 then
    flowFractionSteadyState = flowFractionCushion;
  else
    flowFractionSteadyState = 1;
  end if;

  der(flowFraction) = (flowFractionSteadyState - flowFraction)/0.001;

  // pure sensor without forces
  flange_a.f = 0;
  flange_b.f = 0;
  connect(port_a, cushionRestriction.port_b) annotation (Line(points={{0,100},
          {0,10},{1.83697e-015,10}},       color={255,0,0}));

  connect(port_b, cushionRestriction.port_a) annotation (Line(points={{0,-100},
          {0,-10},{-1.83697e-015,-10}},      color={255,0,0}));
  connect(reliefValve.port_b, port_b) annotation (Line(points={{60,-40},{
          60,-80},{0,-80},{0,-100}}, color={255,0,0}));
  connect(port_a, reliefValve.port_a) annotation (Line(points={{0,100},{0,
          80},{60,80},{60,-20}}, color={255,0,0}));
  annotation (
    Diagram(graphics={
        Text(
          extent={{-98,-30},{-4,-42}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "restriction relationship"),
        Text(
          extent={{-98,-18},{-4,-30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "see equations section"),
        Rectangle(extent={{-98,-14},{-4,-46}}, lineColor={0,0,255})}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-80,92},{80,-88}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,0},{90,0}},
          color={0,127,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{20,56},{60,-56}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,56},{-40,-56}}, color={0,0,0}),
        Line(points={{-28,-44},{-28,-44},{-32,-30},{-34,-20},{-36,-6},{-36,
              6},{-34,20},{-32,30},{-28,44},{-28,44}}, color={0,0,0}),
        Line(points={{-10,-16},{-78,20}}, color={0,0,0}),
        Text(
          extent={{-44,-74},{-6,-114}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-48,120},{0,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{100,90},{-100,60}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="cushion"),
        Line(points={{56,-4},{40,-24},{24,-4}}, color={0,0,0}),
        Line(points={{34,24},{34,24},{34,24},{46,20},{34,16},{46,12},{34,
              8},{46,4},{34,0}}, color={0,0,0}),
        Line(points={{-52,-44},{-52,-44},{-48,-30},{-46,-20},{-44,-6},{-44,
              6},{-46,20},{-48,30},{-52,44},{-52,44}}, color={0,0,0}),
        Polygon(
          points={{-78,20},{-62,4},{-56,16},{-78,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{40,56},{40,-56}}, color={0,0,0}),
        Line(points={{0,100},{0,56}}, color={0,0,0}),
        Line(points={{0,-56},{0,-100}}, color={0,0,0}),
        Line(points={{-40,-56},{40,-56}}, color={0,0,0}),
        Line(points={{-40,56},{40,56}}, color={0,0,0}),
        Ellipse(
          extent={{30,2},{50,-18}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end CylinderCushion;
