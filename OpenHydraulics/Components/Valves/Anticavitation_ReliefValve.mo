within OpenHydraulics.Components.Valves;
model Anticavitation_ReliefValve

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  OpenHydraulics.Components.Valves.CheckValve checkValve(q_nom=0.1)
              annotation (Placement(transformation(
          extent={{0,-30},{20,-10}})));
  OpenHydraulics.Components.Valves.ReliefValve reliefValve(q_nom=0.01)
                 annotation (Placement(transformation(
          extent={{0,10},{20,30}})));
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  OpenHydraulics.Components.Lines.NJunction j2(n_ports=3)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

  OpenHydraulics.Components.Lines.NJunction j1(n_ports=3)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
equation
  connect(j2.port[1], port_a) annotation (Line(points={{-40,-0.666667},{-40,
          0},{-80,0}}, color={255,0,0}));
  connect(j2.port[2], reliefValve.port_a) annotation (Line(points={{-40,5.55112e-017},
          {-40,20},{0,20}},               color={255,0,0}));
  connect(j2.port[3], checkValve.port_a) annotation (Line(points={{-40,0.666667},
          {-40,-20},{0,-20}},           color={255,0,0}));
  connect(j1.port[3], port_b) annotation (Line(points={{60,0.666667},{60,0},
          {80,0}}, color={255,0,0}));
  connect(checkValve.port_b, j1.port[1]) annotation (Line(points={{20,-20},
          {60,-20},{60,-0.666667}}, color={255,0,0}));
  connect(reliefValve.port_b, j1.port[2]) annotation (Line(points={{20,20},
          {60,20},{60,5.55112e-017}}, color={255,0,0}));

annotation (         Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{2,-60},{22,-40},{2,-20}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-20,60},{20,20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-32,40},{-32,74},{2,74},{2,60}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(points={{-4,20},{8,20},{-4,18},{8,18},{-4,16},{8,16},{-4,14},{
              8,14},{-4,12},{8,12},{-4,10},{8,10}}, color={0,0,0}),
        Line(points={{-60,0},{-60,-40},{60,-40},{60,0}}, color={0,0,0}),
        Ellipse(
          extent={{12,-60},{-26,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,48},{16,50},{16,50},{16,46},{20,48}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-78,0},{-60,0}}, color={0,0,0}),
        Line(points={{-60,0},{-60,40},{-20,40}}, color={0,0,0}),
        Line(points={{20,42},{46,42},{60,42},{60,2},{80,2}}, color={0,0,0}),
        Line(points={{18,48},{-20,48}}, color={0,0,0}),
        Text(
          extent={{-84,108},{76,68}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-100,60},{-60,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{60,60},{100,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B")}));
end Anticavitation_ReliefValve;
