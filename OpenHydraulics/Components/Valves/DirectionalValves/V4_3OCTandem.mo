within OpenHydraulics.Components.Valves.DirectionalValves;
model V4_3OCTandem "4-port 3-position valve with open center"
  extends OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.PartialValve4_3pos(
    A2T(max_contr=1, table=[-1,1; 0,0; 1,0]),
    P2A(min_contr=-1, table=[-1,0; 0,0; 1,1]),
    P2B(max_contr=1, table=[-1,1; 0,0; 1,0]),
    B2T(min_contr=-1, table=[-1,0; 0,0; 1,1]),
    j1(n_ports=4),
    j4(n_ports=4));

  // a regular 4-way 3-position valve with an open center tandem

    //components
  Basic.VariableRestriction P2T(
    D_nom=0.01,
    dp_nom=2e5,
    p_init=p_init,
    min_contr=-1,
    max_contr=1,
    table=[-1,0; 0,1; 1,0])
    annotation (
    Dialog(tab="Sizing",group="Metering"), Placement(transformation(
          extent={{-8,-32},{8,-48}})));

    //equations and connect
equation
  connect(control, P2T.control) annotation (Line(points={{110,0},{50,0},{
          50,-20},{0,-20},{0,-33.6}}, color={0,0,127}));
  connect(P2T.port_b, j4.port[4]) annotation (Line(points={{8,-40},{40,
          -40},{40,-60}}, color={255,0,0}));
  connect(j1.port[4], P2T.port_a) annotation (Line(points={{-40,-60},{-40,
          -40},{-8,-40}}, color={255,0,0}));

annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(points={{18,30},{18,12}}, color={0,0,0}),
        Line(points={{-18,30},{-18,12}}, color={0,0,0}),
        Line(points={{-12,12},{-24,12}}, color={0,0,0}),
        Line(points={{24,12},{12,12}}, color={0,0,0}),
        Line(points={{-78,-30},{-78,30}}, color={0,0,0}),
        Line(points={{-44,-30},{-44,30}}, color={0,0,0}),
        Polygon(
          points={{-78,30},{-84,10},{-72,10},{-78,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44,-30},{-50,-10},{-38,-10},{-44,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-18,-30},{-18,-6},{18,-6},{18,-30},{18,-24}}, color=
             {0,0,0}),
        Line(points={{78,-30},{42,30}}, color={0,0,0}),
        Line(points={{42,-30},{78,30}}, color={0,0,0}),
        Polygon(
          points={{78,30},{72,8},{62,14},{78,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{78,-30},{62,-14},{72,-8},{78,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-18,30},{-18,60},{-40,60},{-40,80}}, color={255,0,0}),
        Line(points={{18,30},{18,60},{40,60},{40,80}}, color={255,0,0}),
        Line(points={{-18,-30},{-18,-60},{-40,-60},{-40,-82}}, color={255,
              0,0}),
        Line(points={{18,-30},{18,-60},{40,-60},{40,-76}}, color={255,0,0}),
        Text(
          extent={{-80,92},{80,112}},
          lineColor={0,0,255},
          textString="%name")}));
end V4_3OCTandem;
