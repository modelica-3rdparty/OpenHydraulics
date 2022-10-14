within OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses;
partial model PartialV6_3LS "Interface for 6-port 3-position valve"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

   // dynamic response parameters
  parameter SI.Frequency bandwidth = 10 "Bandwidth of 2nd order response"
    annotation(Dialog(tab="Dynamics"));
  parameter Real dampCoeff = 1 "Damping coefficient of 2nd order response"
    annotation(Dialog(tab="Dynamics"));

  // the ports
  OpenHydraulics.Interfaces.FluidPort portP1
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  OpenHydraulics.Interfaces.FluidPort portA
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  OpenHydraulics.Interfaces.FluidPort portT2
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  OpenHydraulics.Interfaces.FluidPort portT1
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Interfaces.RealInput control
    annotation (Placement(transformation(extent={{130,-20},{90,20}})));
  OpenHydraulics.Interfaces.FluidPort portP2
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  OpenHydraulics.Interfaces.FluidPort portB
    annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
  OpenHydraulics.Interfaces.FluidPort portLS
    annotation (Placement(transformation(extent={{10,70},{30,90}})));

  // the components
  Modelica.Blocks.Continuous.SecondOrder dynamicResponse(
    w=bandwidth*2*Modelica.Constants.pi,
    D=dampCoeff,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));

  // equation and connect

equation
  connect(dynamicResponse.u, control) annotation (Line(points={{102,-30},
          {106,-30},{106,0},{110,0}}, color={0,0,127}));

annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{90,20},{130,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{40,-54},{80,-88}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-10,-42},{30,-76}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{-70,-48},{-34,-94}},
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
          extent={{-40,80},{-4,36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="P2"),
        Text(
          extent={{-100,72},{-66,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T1"),
        Line(points={{-80,70},{-80,40},{-20,40},{-20,30}}, color={255,0,
              0}),
        Line(points={{-20,78},{-20,46},{-8,46},{-8,30}}, color={255,0,0}),
        Line(points={{20,72},{20,46},{8,46},{8,30}}, color={255,0,0}),
        Line(points={{-80,-70},{-80,-46},{-20,-46},{-20,-30}}, color={
              255,0,0}),
        Line(points={{0,-30},{0,-30},{0,-60},{0,-76},{0,-80},{0,-78},{0,
              -80}}, color={255,0,0}),
        Line(points={{80,-72},{80,-46},{20,-46},{20,-30}}, color={255,0,
              0}),
        Line(points={{80,76},{80,40},{20,40},{20,30}}, color={255,0,0}),
        Text(
          extent={{4,78},{40,36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="LS"),
        Text(
          extent={{62,72},{96,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T2")}));
end PartialV6_3LS;
