within OpenHydraulics.Basic;
model VarPressureSource "Boundary pressure and temperature source"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  OpenHydraulics.Interfaces.FluidPort port
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  Modelica.Blocks.Interfaces.RealInput control annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}})));
equation
  port.p   = control;

  annotation (defaultComponentName = "source",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,40},{0,100}}, color={255,0,0}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{0,-46},{0,-82}}, textString="%name"),
        Polygon(
          points={{44,44},{30,36},{36,30},{44,44}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,-40},{40,40}}, color={0,0,0}),
        Line(points={{-40,0},{-80,0}}, color={0,0,127}),
        Ellipse(
          extent={{-16,16},{16,-16}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Defines constant values for boundary conditions:
</p>
<ul>
<li> Tank pressure.</li>
<li> Tank temperature.</li>
</ul>
<p>
Note, that boundary temperature only has an effect if the mass flow
is out of the tank. If mass is flowing into the tank, the temperature is free.
</p>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(extent={{-40,40},{40,-40}}, lineColor={0,0,0}),
        Line(points={{0,40},{0,100}}, color={255,0,0}),
        Line(points={{-40,-40},{40,40}}, color={0,0,0}),
        Polygon(
          points={{48,48},{30,40},{40,30},{48,48}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-80,0}}, color={0,0,127}),
        Ellipse(
          extent={{-16,16},{16,-16}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end VarPressureSource;
