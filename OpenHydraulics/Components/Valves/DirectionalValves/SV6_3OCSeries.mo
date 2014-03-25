within OpenHydraulics.Components.Valves.DirectionalValves;
model SV6_3OCSeries "Sectional valve "
   extends OpenHydraulics.Interfaces.PartialFluidComponent;
    // parameters
  parameter Integer sizeOfInputs=1 "Size of input array";
  parameter Integer inputIndex=1 "Index of command for this valve";

    //ports
  OpenHydraulics.Interfaces.FluidPort P1_in
    annotation (Placement(transformation(extent={{-100,30},{-80,50}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort P2_in
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort T2_out
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort P1_out
    annotation (Placement(transformation(extent={{80,30},{100,50}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort P2_out
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort T2_in
    annotation (Placement(transformation(extent={{80,-70},{100,-50}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort A
    annotation (Placement(transformation(extent={{-50,80},{-30,100}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort B
    annotation (Placement(transformation(extent={{30,80},{50,100}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u[sizeOfInputs]
    annotation (Placement(transformation(extent={{-44,-100},{-26,-80}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y[sizeOfInputs]
    annotation (Placement(transformation(extent={{20,-100},{40,-80}},
          rotation=0)));

    //junctions
  OpenHydraulics.Components.Lines.NJunction j1(n_ports=4)
    annotation (Placement(transformation(
        origin={12,-60},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.NJunction j2(n_ports=4)
    annotation (Placement(transformation(extent={{52,-10},{72,10}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j3
    annotation (Placement(transformation(extent={{30,50},{50,70}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j4
    annotation (Placement(transformation(extent={{-50,50},{-30,70}},
          rotation=0)));

    //components
  OpenHydraulics.Components.Valves.DirectionalValves.V6_3OC v6_3OC
    annotation (Placement(transformation(
        origin={-14,0},
        extent={{-20,-20},{20,20}},
        rotation=270)));

  OpenHydraulics.Components.Valves.Anticavitation_ReliefValve AnticavRelief
    annotation (Placement(transformation(extent={{-32,50},{-12,70}},
          rotation=0)));
  OpenHydraulics.Components.Valves.Anticavitation_ReliefValve AnticavRelief2
    annotation (Placement(transformation(extent={{36,50},{16,70}},
          rotation=0)));

    //equations and connect
equation
  connect(j4.port[1], A) annotation (Line(points={{-40,59.3333},{-40,90}},
        color={255,0,0}));
  connect(j3.port[1],B)  annotation (Line(points={{40,59.3333},{40,90},{
          40,90}}, color={255,0,0}));
  connect(u, y)
    annotation (Line(points={{-35,-90},{30,-90}}, color={0,0,127}));
  connect(u[inputIndex], v6_3OC.control)          annotation (Line(points=
         {{-35,-90},{-14,-90},{-14,-21.2}}, color={0,0,127}));
  connect(v6_3OC.portA,j4. port[2])          annotation (Line(points={{2,
          16},{2,40},{-40,40},{-40,60}}, color={255,0,0}));
  connect(v6_3OC.portB,j3. port[2])          annotation (Line(points={{2,
          -16},{40,-16},{40,60}}, color={255,0,0}));
  connect(AnticavRelief.port_a,j4. port[3]) annotation (Line(points={{-30,
          60},{-40,60},{-40,60.6667}}, color={255,0,0}));
  connect(AnticavRelief2.port_a,j3. port[3]) annotation (Line(points={{34,
          60},{38,60},{38,60.6667},{40,60.6667}}, color={255,0,0}));
  connect(j1.port[1], T2_out) annotation (Line(points={{12.75,-60},{-90,
          -60}}, color={255,0,0}));
  connect(v6_3OC.portT1, j2.port[2])          annotation (Line(points={{2,
          -2.93906e-015},{62,-2.93906e-015},{62,-0.25}}, color={255,0,0}));
  connect(P1_out, j2.port[3]) annotation (Line(points={{90,40},{62,40},{
          62,0.25}}, color={255,0,0}));
  connect(j2.port[4], P2_out) annotation (Line(points={{62,0.75},{62,0},{
          90,0}}, color={255,0,0}));
  connect(P2_in, v6_3OC.portP)          annotation (Line(points={{-90,0},
          {-47.7,0},{-47.7,2.93906e-015},{-30,2.93906e-015}}, color={255,
          0,0}));
  connect(P1_in, v6_3OC.portP1)          annotation (Line(points={{-90,40},
          {-56,40},{-56,16},{-30,16}}, color={255,0,0}));
  connect(v6_3OC.portT2, j2.port[1])          annotation (Line(points={{
          -30,-16},{-30,-38},{62,-38},{62,-0.75}}, color={255,0,0}));
  connect(AnticavRelief.port_b,j1. port[2]) annotation (Line(points={{-14,
          60},{12,60},{12,-60},{12.25,-60}}, color={255,0,0}));
  connect(AnticavRelief2.port_b,j1. port[3]) annotation (Line(points={{18,
          60},{12,60},{12,-60},{11.75,-60}}, color={255,0,0}));
  connect(j1.port[4], T2_in) annotation (Line(points={{11.25,-60},{90,-60}},
        color={255,0,0}));
annotation (Diagram(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          pattern=LinePattern.DashDot)}),
                        Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{50,96},{68,74}},
          lineColor={0,0,0},
          textString="B"),
        Text(
          extent={{-68,96},{-48,74}},
          lineColor={0,0,0},
          textString="A"),
        Text(
          extent={{72,50},{118,-16}},
          lineColor={0,0,0},
          textString="P2out"),
        Text(
          extent={{72,-24},{106,-62}},
          lineColor={0,0,0},
          textString="T2in"),
        Text(
          extent={{-114,76},{-78,38}},
          lineColor={0,0,0},
          textString="P1in"),
        Text(
          extent={{-114,30},{-76,8}},
          lineColor={0,0,0},
          textString="P2in"),
        Text(
          extent={{-120,-22},{-76,-56}},
          lineColor={0,0,0},
          textString="T2out"),
        Text(
          extent={{72,76},{118,36}},
          lineColor={0,0,0},
          textString="P1out"),
        Polygon(
          points={{-2,-70},{90,-70},{90,-50},{68,-50},{68,-10},{90,-10},{
              90,10},{68,10},{68,30},{90,30},{90,50},{50,50},{50,92},{30,
              92},{30,72},{-30,72},{-30,90},{-50,90},{-50,50},{-90,50},{-90,
              30},{-70,30},{-70,10},{-90,10},{-90,-10},{-70,-10},{-70,-50},
              {-90,-50},{-90,-70},{-2,-70}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,-66},{40,-100}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-44,-100},{40,-100},{40,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-80,40},{80,40}}, color={0,0,0}),
        Rectangle(
          extent={{-36,38},{0,-46}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-36,10},{0,10},{0,-18},{-36,-18}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-36,-20},{0,-40}}, color={0,0,0}),
        Line(points={{0,-20},{-36,-40}}, color={0,0,0}),
        Line(points={{-36,-30},{-32,-30}}, color={0,0,0}),
        Line(points={{0,-30},{-4,-30}}, color={0,0,0}),
        Line(points={{-4,-26},{-4,-34}}, color={0,0,0}),
        Line(points={{-32,-26},{-32,-34}}, color={0,0,0}),
        Line(points={{-36,26},{-32,26}}, color={0,0,0}),
        Line(points={{-32,30},{-32,22}}, color={0,0,0}),
        Line(points={{-4,30},{-4,22}}, color={0,0,0}),
        Line(points={{0,26},{-4,26}}, color={0,0,0}),
        Line(points={{-36,-12},{-32,-12}}, color={0,0,0}),
        Line(points={{-32,-8},{-32,-16}}, color={0,0,0}),
        Line(points={{-4,-8},{-4,-16}}, color={0,0,0}),
        Line(points={{0,-12},{-4,-12}}, color={0,0,0}),
        Line(points={{-36,4},{-32,4}}, color={0,0,0}),
        Line(points={{-32,8},{-32,0}}, color={0,0,0}),
        Line(points={{-4,0},{-4,8}}, color={0,0,0}),
        Line(points={{0,4},{-4,4}}, color={0,0,0}),
        Line(
          points={{-44,-80},{-44,-70}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-36,16},{0,16}}, color={0,0,0}),
        Line(points={{-36,34},{0,34}}, color={0,0,0}),
        Line(points={{-36,-4},{0,-4}}, color={0,0,0}),
        Polygon(
          points={{0,16},{-4,18},{-4,14},{0,16}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-4},{-4,-2},{-4,-6},{0,-4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,32},{-36,34},{-32,36},{-32,32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-40},{-6,-38},{-4,-36},{0,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-32,-36},{-30,-38},{-36,-40},{-32,-36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-60},{80,-60}}, color={0,0,0}),
        Line(points={{-92,0},{-58,0},{-58,-4},{-36,-4}}, color={0,0,0}),
        Line(points={{0,-4},{54,-4},{54,0},{80,0}}, color={0,0,0}),
        Rectangle(
          extent={{-22,-46},{-14,-50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-22,-50},{-18,-46},{-14,-50},{-22,-50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-28,-90},{-18,-90},{18,-90},{20,-90}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-18,-50},{-18,-90}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-52,40},{-52,4},{-36,4}}, color={0,0,0}),
        Line(points={{24,58},{24,-20},{0,-20}}, color={0,0,0}),
        Line(points={{40,80},{40,58},{24,58},{24,58}}, color={0,0,0}),
        Line(points={{-40,80},{-40,58},{6,58},{6,4},{0,4}}, color={0,0,0}),
        Line(points={{-36,-12},{-52,-12},{-52,-56}}, color={0,0,0}),
        Line(points={{-52,-56},{54,-56},{54,-4},{54,40}}, color={0,0,0})}));
end SV6_3OCSeries;
