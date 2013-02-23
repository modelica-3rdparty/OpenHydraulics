within OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses;
partial model Valve4_3posInterface "Interface for 4-port 3-position valve"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // the ports
  OpenHydraulics.Interfaces.FluidPort portP
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portA
    annotation (Placement(transformation(extent={{-50,70},{-30,90}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portT
    annotation (Placement(transformation(extent={{30,-90},{50,-70}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portB
    annotation (Placement(transformation(extent={{30,70},{50,90}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput control
    annotation (Placement(transformation(extent={{130,-20},{90,20}},
          rotation=0)));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{90,20},{130,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-82,100},{-52,60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{52,100},{82,60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{50,-60},{80,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Text(
          extent={{-80,-60},{-50,-100}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="P"),
        Rectangle(
          extent={{-90,30},{-30,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,30},{30,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,30},{90,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                            Diagram(graphics));
  // the connection junctions (with small volumes)
end Valve4_3posInterface;
