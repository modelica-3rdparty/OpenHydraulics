within OpenHydraulics.Basic;
model VarVolumeSource "Boundary volume flow and temperature source"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  OpenHydraulics.Interfaces.FluidPort port
    annotation (Placement(transformation(extent={{-10,90},{10,110}},
          rotation=0)));

  Modelica.Blocks.Interfaces.RealInput control annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}, rotation=0)));
equation
  port.m_flow = -oil.density(port.p)*control;

  annotation (defaultComponentName = "source",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,40},{0,100}}, color={255,0,0}),
        Text(
          extent={{0,36},{0,-38}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Line(points={{-40,0},{-80,0}}, color={0,0,127}),
        Polygon(
          points={{48,48},{30,40},{40,30},{48,48}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,-40},{40,40}}, color={0,0,0}),
        Text(extent={{0,-46},{0,-82}}, textString="%name")}),
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
        Text(
          extent={{0,36},{0,-38}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Q"),
        Line(points={{-40,0},{-80,0}}, color={0,0,127}),
        Polygon(
          points={{48,48},{30,40},{40,30},{48,48}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,-40},{40,40}}, color={0,0,0})}));
end VarVolumeSource;
