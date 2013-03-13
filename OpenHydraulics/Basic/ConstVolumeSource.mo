within OpenHydraulics.Basic;
model ConstVolumeSource "Boundary pressure source"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  OpenHydraulics.Interfaces.FluidPort port
    annotation (Placement(transformation(extent={{-10,90},{10,110}},
          rotation=0)));

  parameter SI.VolumeFlowRate q = 0.01 "Source Volume Rate" annotation(Evaluate=true);

equation
  port.m_flow = -q*oil.density(port.p);

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
          textString="q=%q"),
        Line(points={{0,54},{0,100}}, color={255,0,0}),
        Ellipse(
          extent={{-40,54},{40,-26}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{0,90},{0,54}}, textString="%name"),
        Text(
          extent={{0,48},{0,-26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="Q")}),
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
        Text(
          extent={{0,50},{0,-24}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "Q")}));
end ConstVolumeSource;
