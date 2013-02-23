within OpenHydraulics.Circuits;
model Environment
  "models the atmospheric conditions in which the fluid power components are used"

  parameter SI.Temperature T_ambient = 288.15 "Ambient Temperature"
    annotation(Dialog(group="Ambient"));
  parameter SI.AbsolutePressure p_ambient = 101325 "Atmosperic Pressure"
    annotation(Dialog(group="Ambient"));
  annotation (
    defaultComponentName="environment",
    defaultComponentPrefixes="inner",
    missingInnerMessage="No \"environment\" component is defined. A default environment
component with 15degC and 101325Pa will be used. If this is not desired,
drag FluidPower.Environment into the top level of your model.",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,86},{0,54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=" %name"),
        Text(
          extent={{0,2},{0,-20}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="p_amb = %p_ambient"),
        Text(
          extent={{0,-36},{0,-58}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T_amb = %T_ambient")}),
    Diagram(graphics={
        Text(
          extent={{0,86},{0,54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               " %name"),
        Text(
          extent={{0,2},{0,-20}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "p_amb = %p_ambient"),
        Text(
          extent={{0,-36},{0,-58}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "T_amb = %T_ambient")}));
end Environment;
