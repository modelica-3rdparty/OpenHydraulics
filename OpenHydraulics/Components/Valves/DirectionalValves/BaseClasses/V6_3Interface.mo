within OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses;
partial model V6_3Interface "Interface for 6-port 3-position valve"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // the ports
  OpenHydraulics.Interfaces.FluidPort portP1
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portA
    annotation (Placement(transformation(extent={{-90,70},{-70,90}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portT2
    annotation (Placement(transformation(extent={{70,-90},{90,-70}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portT1
    annotation (Placement(transformation(extent={{-10,70},{10,90}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portP
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portB
    annotation (Placement(transformation(extent={{70,70},{90,90}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput control
    annotation (Placement(transformation(
        origin={106,0},
        extent={{-16,-20},{16,20}},
        rotation=180)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={
            {-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{90,20},{130,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{48,96},{72,62}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-74,96},{-46,62}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{38,-60},{72,-102}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T2"),
        Text(
          extent={{-70,-58},{-34,-102}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="P1"),
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
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,-46},{4,-80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="P"),
        Text(
          extent={{-20,76},{14,38}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T1"),
        Line(points={{-80,70},{-80,40},{-20,40},{-20,30}}, color={255,0,
              0}),
        Line(points={{0,80},{0,60},{0,60},{0,30}}, color={255,0,0}),
        Line(points={{80,80},{80,40},{20,40},{20,30}}, color={255,0,0}),
        Line(points={{-80,-70},{-80,-40},{-20,-40},{-20,-30}}, color={
              255,0,0}),
        Line(points={{0,-30},{0,-60},{0,-60},{0,-60},{0,-60},{0,-60},{0,
              -78}}, color={255,0,0}),
        Line(points={{80,-78},{80,-40},{20,-40},{20,-30}}, color={255,0,
              0})}),        Diagram(graphics));

end V6_3Interface;
