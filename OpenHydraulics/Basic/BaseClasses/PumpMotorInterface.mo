within OpenHydraulics.Basic.BaseClasses;
partial model PumpMotorInterface "Interface for displacement pumps or motors"

  extends OpenHydraulics.Interfaces.VerticalTwoPort;
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

  SI.Angle phi "Angle of rotation of pump";

equation
  flange_a.phi = phi;
  flange_b.phi = phi;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-54,54},{54,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-54},{0,-100}}, color={255,0,0}),
        Line(points={{0,100},{0,54}}, color={255,0,0}),
        Rectangle(
          extent={{-90,8},{-54,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,8},{90,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{100,-54},{-100,-90}}, textString="%name"),
        Text(
          extent={{10,-80},{40,-120}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Text(
          extent={{10,120},{40,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="P")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-54,54},{54,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,8},{-54,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,8},{90,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,100},{0,54}}, color={255,0,0}),
        Line(points={{0,-54},{0,-100}}, color={255,0,0})}));
end PumpMotorInterface;
