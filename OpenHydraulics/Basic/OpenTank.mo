within OpenHydraulics.Basic;
model OpenTank "Boundary pressure, temperature and mass fraction source"

  OpenHydraulics.Interfaces.FluidPort port
    annotation (Placement(transformation(extent={{-10,90},{10,110}},
          rotation=0)));

  parameter SI.AbsolutePressure p_const = environment.p_ambient "Tank pressure";

  extends OpenHydraulics.Interfaces.PartialFluidComponent;
equation
  port.p = p_const;

  annotation (defaultComponentName = "tank",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-100,20},{100,-20}}, textString="%name"),
        Line(points={{0,100},{0,20}}, color={255,0,0}),
        Line(points={{-80,20},{-80,-20},{80,-20},{80,20}}, color={0,0,0}),
        Text(
          extent={{-80,-20},{80,-60}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="p=%p_const"),
        Text(
          extent={{-80,-60},{80,-100}},
          lineColor={255,0,0},
          fillColor={255,0,0},
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
        grid={2,2}), graphics));
end OpenTank;
