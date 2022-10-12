within OpenHydraulics.Components.Valves.DirectionalValves;
model V4_3CC "4-port 3-position closed center valve"
  extends OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.PartialValve4_3pos;

  // include just the arrows for each position
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics={
        Line(points={{-74,-30},{-74,30}}, color={0,0,0}),
        Line(points={{-46,-30},{-46,30}}, color={0,0,0}),
        Polygon(
          points={{-74,30},{-80,10},{-68,10},{-74,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-46,-30},{-52,-10},{-40,-10},{-46,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{74,-30},{46,30}}, color={0,0,0}),
        Line(points={{46,-30},{74,30}}, color={0,0,0}),
        Polygon(
          points={{74,-30},{58,-14},{70,-8},{74,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{74,30},{70,6},{58,12},{74,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-14,-30},{-14,-12}}, color={0,0,0}),
        Line(points={{-20,-12},{-8,-12}}, color={0,0,0}),
        Line(points={{-20,12},{-8,12}}, color={0,0,0}),
        Line(points={{8,12},{20,12}}, color={0,0,0}),
        Line(points={{8,-12},{20,-12}}, color={0,0,0}),
        Line(points={{-14,12},{-14,30}}, color={0,0,0}),
        Line(points={{14,12},{14,30}}, color={0,0,0}),
        Line(points={{14,-30},{14,-12}}, color={0,0,0}),
        Line(points={{-14,30},{-14,60},{-40,60},{-40,80}}, color={255,0,0}),
        Line(points={{14,30},{14,60},{40,60},{40,80}}, color={255,0,0}),
        Line(points={{-14,-30},{-14,-60},{-40,-60},{-40,-80}}, color={255,
              0,0}),
        Line(points={{14,-30},{14,-60},{40,-60},{40,-80}}, color={255,0,0})}));

end V4_3CC;
