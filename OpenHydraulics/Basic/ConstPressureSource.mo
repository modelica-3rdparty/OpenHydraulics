within OpenHydraulics.Basic;
model ConstPressureSource "Boundary pressure and temperature source"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  OpenHydraulics.Interfaces.FluidPort port
    annotation (Placement(transformation(extent={{-10,90},{10,110}},
          rotation=0)));

  parameter SI.AbsolutePressure p_const = environment.p_ambient "Tank pressure";
equation
  port.p = p_const;
  annotation (defaultComponentName = "source",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{0,-32},{0,-66}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="p=%p_const"),
        Line(points={{0,54},{0,100}}, color={255,0,0}),
        Ellipse(
          extent={{-40,54},{40,-26}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,30},{16,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{0,90},{0,54}}, textString="%name")}),
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
        Ellipse(extent={{-40,54},{40,-26}}, lineColor={0,0,0}),
        Line(points={{0,54},{0,100}}, color={255,0,0}),
        Ellipse(
          extent={{-16,30},{16,-2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end ConstPressureSource;
