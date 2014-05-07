within OpenHydraulics.Components.Sensors;
model FlowSensor
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // the parameters
  parameter SI.Diameter D = 1 "Diameter at the ports"
    annotation (Dialog(tab="Advanced"));
  parameter Real zeta = 2 "Loss factor for flow of port_a -> port_b"
    annotation (Dialog(tab="Advanced"));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a(p(start=p_init))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  OpenHydraulics.Interfaces.FluidPort port_b(p(start=p_init))
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));

  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(
        origin={0,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Basic.GenericPressureLoss genericPressureLoss(
    D_a=D,
    D_b=D,
    zeta1=zeta,
    zeta2=zeta,
    use_Re=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  y = genericPressureLoss.q_flow_a;

  connect(port_a, genericPressureLoss.port_a) annotation (Line(points={{
          -100,0},{-10,0}}, color={255,0,0}));
  connect(genericPressureLoss.port_b, port_b) annotation (Line(points={{10,
          0},{100,0}}, color={255,0,0}));

  annotation (Diagram(graphics={Line(
          points={{0,-8},{0,-38},{0,-38},{0,-60}},
          color={0,0,127},
          pattern=LinePattern.Dash)}),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{0,56},{0,82}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Ellipse(extent={{-54,54},{54,-54}}, lineColor={0,0,0}),
        Line(points={{-52,-16},{-44,-14},{-30,-10},{-20,-8},{-6,-6},{6,-6},
              {20,-8},{30,-10},{44,-14},{52,-16}}, color={0,0,0}),
        Line(points={{-52,16},{-44,14},{-30,10},{-20,8},{-6,6},{6,6},{20,8},
              {30,10},{44,14},{52,16}}, color={0,0,0}),
        Line(points={{-100,0},{-54,0}}, color={255,0,0}),
        Line(points={{54,0},{100,0}}, color={255,0,0}),
        Line(points={{0,-54},{0,-60}}, color={0,0,127}),
        Text(
          extent={{-90,40},{-60,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{60,40},{90,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B")}));
end FlowSensor;
