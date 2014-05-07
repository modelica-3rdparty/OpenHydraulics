within OpenHydraulics.Components.Valves.DirectionalValves;
model SV6_3CCParallel "Sectional valve "
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  //parameters
  parameter Integer inputIndex=1 "Index of command for this valve";
  parameter Integer sizeOfInputs=1 "Size of input array";

  //ports
  OpenHydraulics.Interfaces.FluidPort P1in
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  OpenHydraulics.Interfaces.FluidPort LSout
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  OpenHydraulics.Interfaces.FluidPort T2_out
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  OpenHydraulics.Interfaces.FluidPort P1out
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  OpenHydraulics.Interfaces.FluidPort LSin
    annotation (Placement(transformation(extent={{80,-30},{100,-10}})));
  OpenHydraulics.Interfaces.FluidPort T2_in
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  OpenHydraulics.Interfaces.FluidPort LSout1
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  OpenHydraulics.Interfaces.FluidPort A
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  OpenHydraulics.Interfaces.FluidPort B
    annotation (Placement(transformation(extent={{30,80},{50,100}})));
  OpenHydraulics.Interfaces.FluidPort LSin1
    annotation (Placement(transformation(extent={{80,10},{100,30}})));
  Modelica.Blocks.Interfaces.RealOutput y[sizeOfInputs]
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));

  Modelica.Blocks.Interfaces.RealInput u[sizeOfInputs]
    annotation (Placement(transformation(extent={{-44,-100},{-26,-80}})));

    //junctions
  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(
        origin={-50,60},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(
        origin={30,20},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  OpenHydraulics.Components.Lines.NJunction j3(n_ports=5)
    annotation (Placement(transformation(
        origin={10,-60},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  OpenHydraulics.Components.Lines.NJunction j4
    annotation (Placement(transformation(
        origin={40,46},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  OpenHydraulics.Components.Lines.NJunction j5
    annotation (Placement(transformation(
        origin={-40,46},
        extent={{-10,-10},{10,10}},
        rotation=90)));

    //components
  OpenHydraulics.Components.Valves.DirectionalValves.V6_3CCLS v6_3CC
    annotation (Placement(transformation(
        origin={-20,-20},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  OpenHydraulics.Components.Valves.Anticavitation_ReliefValve AnticavRelief
    annotation (Placement(transformation(extent={{-30,36},{-10,56}})));

  OpenHydraulics.Components.Valves.Anticavitation_ReliefValve AnticavRelief2
    annotation (Placement(transformation(extent={{34,36},{14,56}})));

  OpenHydraulics.Components.Valves.PostPCValve post_PressureCompensationValve
    annotation (Placement(transformation(extent={{20,6},{40,-14}})));

  OpenHydraulics.Components.Valves.ShuttleValve shuttleValve(q_nom=0.02)
    annotation (Placement(transformation(
        origin={58,-24},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  parameter Real q_nom=q_nom;
equation
  connect(u, y)
    annotation (Line(points={{-35,-90},{30,-90}}, color={0,0,127}));
  connect(u[inputIndex], v6_3CC.control)          annotation (Line(points=
         {{-35,-90},{-20,-90},{-20,-39.6}}, color={0,0,127}));
  connect(v6_3CC.portP2, post_PressureCompensationValve.port_b)
    annotation (Line(points={{-4,-16},{40,-16},{40,-4}}, color={255,0,0}));
  connect(post_PressureCompensationValve.port_a, v6_3CC.portT1)
    annotation (Line(points={{20,-4},{20,-4},{10,-3.88},{10,-4},{-4,-4}},
        color={255,0,0}));
  connect(post_PressureCompensationValve.port_LS, j2.port[1])
    annotation (Line(
      points={{30,5},{30,20.6667}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(j2.port[3], LSin1) annotation (Line(
      points={{30,19.3333},{30,20},{90,20}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(j2.port[2], LSout1) annotation (Line(
      points={{30,20},{32,20},{32,20},{-90,20}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(j1.port[3], P1out) annotation (Line(points={{-50.6667,60},{90,
          60}}, color={255,0,0}));
  connect(P1in, j1.port[2]) annotation (Line(points={{-90,60},{-50,60}},
        color={255,0,0}));
  connect(j1.port[1], v6_3CC.portP1)          annotation (Line(points={{
          -49.3333,60},{-50,60},{-50,-4},{-36,-4}}, color={255,0,0}));
  connect(j5.port[2], A) annotation (Line(points={{-40,46},{-40,78},{-40,
          78},{-40,90}}, color={255,0,0}));
  connect(v6_3CC.portB,j4. port[1])          annotation (Line(points={{
          -36,-36},{-58,-36},{-58,30},{40,30},{40,46.6667}}, color={255,0,
          0}));
  connect(AnticavRelief2.port_a,j4. port[2]) annotation (Line(points={{32,
          46},{40,46}}, color={255,0,0}));
  connect(j4.port[3], B) annotation (Line(points={{40,45.3333},{40,90}},
        color={255,0,0}));
  connect(AnticavRelief.port_a,j5. port[3]) annotation (Line(points={{-28,
          46},{-40.6667,46}}, color={255,0,0}));
  connect(v6_3CC.portA,j5. port[1])          annotation (Line(points={{
          -36,-20},{-54,-20},{-54,46},{-39.3333,46}}, color={255,0,0}));
  connect(AnticavRelief.port_b, j3.port[3]) annotation (Line(points={{-12,
          46},{10,46},{10,-60}}, color={255,0,0}));
  connect(AnticavRelief2.port_b, j3.port[4]) annotation (Line(points={{16,
          46},{10,46},{10,-60.4}}, color={255,0,0}));
  connect(j3.port[5], T2_in) annotation (Line(points={{10,-60.8},{10,-60},
          {90,-60}}, color={255,0,0}));
  connect(v6_3CC.portT2, j3.port[2])          annotation (Line(points={{
          -4,-36},{10,-36},{10,-59.6}}, color={255,0,0}));
  connect(T2_out, j3.port[1]) annotation (Line(points={{-90,-60},{12,-60},
          {12,-59.2},{10,-59.2}}, color={255,0,0}));
  connect(shuttleValve.PortC, LSout) annotation (Line(
      points={{58,-16},{58,10},{-74,10},{-74,-20},{-90,-20}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(shuttleValve.PortA, LSin) annotation (Line(
      points={{68,-24},{72,-24},{72,-20},{90,-20}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(v6_3CC.portLS, shuttleValve.PortB) annotation (Line(
      points={{-4,-24},{22,-24},{22,-24},{48,-24}},
      color={255,0,0},
      pattern=LinePattern.Dash));
annotation (Diagram(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash)}),
                        Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-100,-100},{100,-124}},
          lineColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{40,-76},{40,-70},{92,-70},{92,-50},{70,-50},{60,-50},{
              60,-30},{92,-30},{92,-10},{60,-10},{60,10},{92,10},{92,30},
              {60,30},{60,50},{92,50},{92,70},{60,70},{52,70},{52,70},{50,
              70},{50,92},{30,92},{30,70},{-28,70},{-30,70},{-30,92},{-50,
              92},{-50,70},{-90,70},{-90,50},{-60,50},{-60,30},{-90,30},{
              -90,10},{-60,10},{-60,-10},{-90,-10},{-90,-30},{-60,-30},{-60,
              -50},{-90,-50},{-90,-70},{-60,-70},{-44,-70},{-44,-80},{-44,
              -100},{40,-100},{40,-80},{40,-76}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-102,96},{-66,58}},
          lineColor={0,0,0},
          textString="P1in"),
        Text(
          extent={{-104,-26},{-60,-60}},
          lineColor={0,0,0},
          textString="T2out"),
        Text(
          extent={{56,98},{102,58}},
          lineColor={0,0,0},
          textString="P1out"),
        Text(
          extent={{68,-24},{102,-62}},
          lineColor={0,0,0},
          textString="T2in"),
        Text(
          extent={{14,98},{32,76}},
          lineColor={0,0,0},
          textString="B"),
        Text(
          extent={{-32,98},{-12,76}},
          lineColor={0,0,0},
          textString="A"),
        Text(
          extent={{-118,62},{-60,12}},
          lineColor={0,0,0},
          textString="LSOut1"),
        Text(
          extent={{-112,20},{-60,-26}},
          lineColor={0,0,0},
          textString="LSOut"),
        Text(
          extent={{66,10},{102,-16}},
          lineColor={0,0,0},
          textString="LSin"),
        Text(
          extent={{64,52},{108,22}},
          lineColor={0,0,0},
          textString="LSin1"),
        Rectangle(
          extent={{-24,56},{12,-50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-24,24},{12,24},{12,-14},{-24,-14}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-24,-18},{-24,-10}}, color={0,0,0}),
        Line(points={{-16,14},{-16,22}}, color={0,0,0}),
        Line(points={{12,-28},{12,-14}}, color={0,0,0}),
        Line(points={{-24,18},{-16,18}}, color={0,0,0}),
        Line(points={{-12,-14},{-4,-14}}, color={0,0,0}),
        Line(points={{-24,4},{-16,4}}, color={0,0,0}),
        Line(points={{-16,0},{-16,8}}, color={0,0,0}),
        Line(points={{-24,-8},{-16,-8}}, color={0,0,0}),
        Line(points={{-16,-12},{-16,-4}}, color={0,0,0}),
        Line(points={{4,18},{12,18}}, color={0,0,0}),
        Line(points={{4,10},{12,10}}, color={0,0,0}),
        Line(points={{4,0},{12,0}}, color={0,0,0}),
        Line(points={{4,-8},{12,-8}}, color={0,0,0}),
        Line(points={{4,10},{4,-8}}, color={0,0,0}),
        Line(points={{4,14},{4,22}}, color={0,0,0}),
        Line(points={{-24,50},{12,50}}, color={0,0,0}),
        Line(points={{12,28},{-24,28}}, color={0,0,0}),
        Line(points={{12,44},{-24,38}}, color={0,0,0}),
        Line(points={{12,36},{6,36},{6,42}}, color={0,0,0}),
        Line(points={{-24,-20},{12,-20}}, color={0,0,0}),
        Line(points={{-24,-32},{12,-44}}, color={0,0,0}),
        Line(points={{-24,-44},{12,-28}}, color={0,0,0}),
        Line(points={{12,-38},{6,-38},{6,-30}}, color={0,0,0}),
        Polygon(
          points={{6,52},{6,48},{12,50},{6,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{6,-18},{6,-22},{12,-20},{6,-18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-18,26},{-24,28},{-18,30},{-18,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{12,-44},{6,-44},{8,-40},{12,-44}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-18,-44},{-24,-44},{-20,-40},{-18,-44}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-16,36},{-24,38},{-18,42},{-16,36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,60},{-46,60},{-30,60},{-30,18},{-24,18}}, color=
             {0,0,0}),
        Line(points={{-30,58},{-30,60},{80,60}}, color={0,0,0}),
        Line(points={{-24,4},{-36,4},{-40,4},{-40,80}}, color={0,0,0}),
        Line(points={{-24,-8},{-36,-8},{-36,64},{40,64},{40,80}}, color={
              0,0,0}),
        Line(points={{-80,-60},{80,-60}}, color={0,0,0}),
        Line(points={{12,-8},{22,-8},{22,-60}}, color={0,0,0}),
        Rectangle(
          extent={{38,-16},{54,-22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{42,-16},{38,-20},{42,-22}}, color={0,0,0}),
        Line(points={{50,-16},{54,-20},{50,-22}}, color={0,0,0}),
        Ellipse(
          extent={{46,-16},{42,-22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{54,-20},{78,-20},{80,-20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{12,0},{26,0},{26,-20},{38,-20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{46,-22},{46,-56},{-52,-56},{-52,-20},{-80,-20}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-80,20},{-48,20},{-48,-54},{32,-54},{32,4}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{28,14},{42,-2}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{12,10},{28,10}}, color={0,0,0}),
        Line(points={{12,18},{46,18},{46,10},{42,10}}, color={0,0,0}),
        Line(
          points={{80,20},{72,20},{54,20},{54,-4},{54,-8},{32,-8}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(points={{-26,-90},{20,-90},{-6,-90},{-6,-50}}, color={0,0,
              127}),
        Line(
          points={{34,14},{34,18},{34,16}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(points={{28,6},{42,6}}, color={0,0,0}),
        Line(points={{42,10},{40,10}}, color={0,0,0}),
        Line(points={{30,10},{28,10}}, color={0,0,0}),
        Line(points={{28,2},{42,2}}, color={0,0,0}),
        Polygon(
          points={{28,2},{30,0},{30,0},{30,4},{28,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{30,12},{30,8}}, color={0,0,0}),
        Line(points={{40,12},{40,8}}, color={0,0,0}),
        Line(points={{36,-2},{40,-2},{36,-2},{40,-4},{36,-4},{40,-6}},
            color={0,0,0})}));
end SV6_3CCParallel;
