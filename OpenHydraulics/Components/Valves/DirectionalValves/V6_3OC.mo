within OpenHydraulics.Components.Valves.DirectionalValves;
model V6_3OC
  extends
    OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.PartialV6_3;
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,-30},{-80,30}}, color={0,0,0}),
        Line(points={{0,-30},{0,30}}, color={0,0,0}),
        Line(points={{-40,-30},{-40,30}}, color={0,0,0}),
        Line(points={{-60,-30},{-60,-18}}, color={0,0,0}),
        Line(points={{-66,-18},{-54,-18}}, color={0,0,0}),
        Line(points={{-20,-30},{-20,-18}}, color={0,0,0}),
        Line(points={{-60,18},{-60,30}}, color={0,0,0}),
        Line(points={{-20,18},{-20,30}}, color={0,0,0}),
        Line(points={{20,18},{20,30}}, color={0,0,0}),
        Line(points={{20,-30},{20,-18}}, color={0,0,0}),
        Line(points={{60,-30},{60,-18}}, color={0,0,0}),
        Line(points={{60,18},{60,30}}, color={0,0,0}),
        Line(points={{-66,18},{-54,18}}, color={0,0,0}),
        Line(points={{-26,18},{-14,18}}, color={0,0,0}),
        Line(points={{-26,-18},{-14,-18}}, color={0,0,0}),
        Line(points={{14,18},{26,18}}, color={0,0,0}),
        Line(points={{14,-18},{26,-18}}, color={0,0,0}),
        Line(points={{54,18},{66,18}}, color={0,0,0}),
        Line(points={{54,-18},{66,-18}}, color={0,0,0}),
        Line(points={{40,30},{80,-30}}, color={0,0,0}),
        Line(points={{80,30},{40,-30}}, color={0,0,0}),
        Polygon(
          points={{-80,30},{-86,10},{-74,10},{-80,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,30},{-6,10},{6,10},{0,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-34,-10},{-46,-10},{-40,-30},{-34,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{76,-14},{68,-20},{80,-30},{76,-14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,30},{68,20},{76,14},{80,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,92},{80,112}},
          lineColor={0,0,255},
          textString="%name")}));

end V6_3OC;
