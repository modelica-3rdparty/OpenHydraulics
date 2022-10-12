within OpenHydraulics.Components.Valves.DirectionalValves;
model V4_3OC "4-port 3-position valve with open center"
  extends OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.PartialValve4_3pos(
    A2T(max_contr=1, table=[-1,1; 0,1; 1,0]),
    P2A(min_contr=-1, table=[-1,0; 0,1; 1,1]),
    P2B(max_contr=1, table=[-1,1; 0,1; 1,0]),
    B2T(min_contr=-1, table=[-1,0; 0,1; 1,1]),
    j1(n_ports=3),
    j4(n_ports=3));

  // a regular 4-way 3-position valve to which a load sensor is attached

    annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-80,92},{80,112}},
          lineColor={0,0,255},
          textString="%name"),
        Line(points={{-78,-30},{-78,30}}, color={0,0,0}),
        Polygon(
          points={{-78,30},{-84,10},{-72,10},{-78,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-44,-30},{-44,30}}, color={0,0,0}),
        Polygon(
          points={{-44,-30},{-50,-10},{-38,-10},{-44,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{42,-30},{78,30}}, color={0,0,0}),
        Line(points={{78,-30},{42,30}}, color={0,0,0}),
        Polygon(
          points={{78,-30},{62,-14},{72,-8},{78,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{78,30},{72,8},{62,14},{78,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{18,30},{18,60},{40,60},{40,80}}, color={255,0,0}),
        Line(points={{-18,30},{-18,60},{-40,60},{-40,80}}, color={255,0,0}),
        Line(points={{-18,-30},{-18,-60},{-40,-60},{-40,-82}}, color={255,
              0,0}),
        Line(points={{18,-30},{18,-60},{40,-60},{40,-76}}, color={255,0,0}),
        Line(points={{-18,-30},{-18,0},{18,0},{18,-30},{18,-24}}, color={
              0,0,0}),
        Line(points={{-18,30},{-18,0}}, color={0,0,0}),
        Line(points={{18,30},{18,0}}, color={0,0,0})}));
end V4_3OC;
