within OpenHydraulics.Components.Valves.DirectionalValves;
model V6_3CCLS

    //parameters
    // sizing parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 1e6 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing"));
  parameter Real q_fraction_P12T1 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P22A = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P22T2 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P22B = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_A2T2 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_B2T2 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));

    //junctions
  OpenHydraulics.Components.Lines.NJunction j1(n_ports=2)
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j3
    annotation (Placement(transformation(
        origin={74,-60},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  OpenHydraulics.Components.Lines.NJunction j4(n_ports=2)
    annotation (Placement(transformation(extent={{-90,58},{-70,78}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j5(n_ports=4)
    annotation (Placement(transformation(extent={{-30,30},{-10,50}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j6(n_ports=4)
    annotation (Placement(transformation(extent={{64,30},{84,50}},
          rotation=0)));

    //components
  Basic.VariableRestriction P12T1(
    final q_nom=q_nom*q_fraction_P12T1,
    D_nom=0.01,
    dp_nom=dp_nom,
    p_init=p_init,
    min_contr=-1,
    max_contr=1,
    table=[-1,1; 0,0; 1,1])
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={-80,0},
        extent={{-8,-8},{8,8}},
        rotation=90)));

  Basic.VariableRestriction B2T2(
    final q_nom=q_nom*q_fraction_B2T2,
    D_nom=0.01,
    dp_nom=dp_nom,
    p_init=p_init,
    min_contr=-1,
    max_contr=1,
    table=[-1,0; 0,0; 1,1])
    annotation (
   Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={74,20},
        extent={{-8,8},{8,-8}},
        rotation=90)));

  Basic.VariableRestriction P22A(
    final q_nom=q_nom*q_fraction_P22A,
    D_nom=0.01,
    dp_nom=dp_nom,
    p_init=p_init,
    min_contr=-1,
    max_contr=1,
    table=[-1,0; 0,0; 1,1])
    annotation (
   Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={-20,20},
        extent={{-8,8},{8,-8}},
        rotation=270)));

  Basic.VariableRestriction P22B(
    final q_nom=q_nom*q_fraction_P22A,
    D_nom=0.01,
    dp_nom=dp_nom,
    p_init=p_init,
    min_contr=-1,
    max_contr=1,
    table=[-1,1; 0,0; 1,0])
    annotation (
   Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={0,-20},
        extent={{-8,8},{8,-8}},
        rotation=270)));

  Basic.VariableRestriction A2T2(
    final q_nom=q_nom*q_fraction_A2T2,
    D_nom=0.01,
    dp_nom=dp_nom,
    p_init=p_init,
    min_contr=-1,
    max_contr=1,
    table=[-1,1; 0,0; 1,0])
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={60,-20},
        extent={{-8,8},{8,-8}},
        rotation=90)));

  Basic.VariableRestriction P22T2(
    final q_nom=q_nom*q_fraction_P22T2,
    D_nom=1e-6,
    dp_nom=dp_nom,
    p_init=p_init,
    table=[-1,0; 0,1; 1,0],
    min_contr=-1,
    max_contr=1)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(extent=
           {{22,32},{38,48}}, rotation=0)));

extends
    OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.PartialV6_3LS;

  OpenHydraulics.Basic.VarPressureSource varPressureSource
      annotation (Placement(transformation(
          extent={{10,50},{30,70}}, rotation=0)));

 //equations and connect
equation
   varPressureSource.control=portP2.p;

  connect(P12T1.port_b, j4.port[2])   annotation (Line(points={{-80,8},{
          -80,68.5}}, color={255,0,0}));
  connect(portP1, j1.port[1]) annotation (Line(points={{-80,-80},{-80,
          -60.5}}, color={255,0,0}));
  connect(j1.port[2], P12T1.port_a)   annotation (Line(points={{-80,-59.5},
          {-80,-8}}, color={255,0,0}));
  connect(j4.port[1], portT1) annotation (Line(points={{-80,67.5},{-80,80}},
        color={255,0,0}));
  connect(portT2, j6.port[1]) annotation (Line(points={{80,80},{80,40},{
          74,40},{74,39.25}}, color={255,0,0}));
  connect(portB, j3.port[1]) annotation (Line(points={{80,-80},{80,-60},
          {74,-60},{74,-59.3333}},color={255,0,0}));
  connect(portA, j2.port[1]) annotation (Line(points={{0,-80},{0,-60.6667}},
        color={255,0,0}));
  connect(P22A.port_b, j2.port[2])   annotation (Line(points={{-20,12},{
          -20,-60},{0,-60}}, color={255,0,0}));
  connect(P22B.port_b, j3.port[2])   annotation (Line(points={{-1.46958e-015,
          -28},{0,-28},{0,-40},{20,-40},{60,-60},{74,-60}},
        color={255,0,0}));
  connect(j3.port[3], B2T2.port_a)   annotation (Line(points={{74,-60.6667},
          {74,12}},           color={255,0,0}));
  connect(B2T2.port_b, j6.port[2])   annotation (Line(points={{74,28},{74,
          39.75}}, color={255,0,0}));
  connect(j2.port[3], A2T2.port_a)   annotation (Line(points={{0,-59.3333},
          {0,-60},{40,-40},{60,-40},{60,-28}}, color={255,0,0}));
  connect(A2T2.port_b, j6.port[3])   annotation (Line(points={{60,-12},{
          60,40},{74,40},{74,40.25}}, color={255,0,0}));
  connect(P22T2.port_b, j6.port[4])   annotation (Line(points={{38,40},{
          74,40},{74,40.75}}, color={255,0,0}));
  connect(P22B.port_a, j5.port[1])   annotation (Line(points={{1.46958e-015,
          -12},{0,14},{0,40},{-20,40},{-20,39.25}},               color={
          255,0,0}));
  connect(P22A.port_a, j5.port[2])   annotation (Line(points={{-20,28},{
          -20,39.75}}, color={255,0,0}));
  connect(j5.port[3], portP2) annotation (Line(points={{-20,40.25},{-20,
          80},{-20,80}}, color={255,0,0}));
  connect(dynamicResponse.y, P22T2.control) annotation (Line(points={{79,
          -30},{30,-30},{30,33.6}}, color={0,0,127}));
  connect(dynamicResponse.y, P22B.control)   annotation (Line(points={{79,
          -30},{30,-30},{30,-20},{6.4,-20}}, color={0,0,127}));
  connect(dynamicResponse.y, A2T2.control)   annotation (Line(points={{79,
          -30},{30,-30},{30,-20},{53.6,-20}}, color={0,0,127}));
  connect(dynamicResponse.y, P12T1.control)   annotation (Line(points={{79,-30},
          {30,-30},{30,-3.91887e-016},{-73.6,-3.91887e-016}},
        color={0,0,127}));
  connect(dynamicResponse.y, P22A.control)   annotation (Line(points={{79,
          -30},{30,-30},{30,20},{-13.6,20}}, color={0,0,127}));
  connect(dynamicResponse.y, B2T2.control)   annotation (Line(points={{79,
          -30},{30,-30},{30,20},{67.6,20}}, color={0,0,127}));
  connect(P22T2.port_a, j5.port[4]) annotation (Line(points={{22,40},{-20,
          40},{-20,40.75}}, color={255,0,0}));
  connect(varPressureSource.port, portLS) annotation (Line(points={{20,70},
          {20,80}}, color={255,0,0}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-20,-30},{-20,-16}}, color={0,0,0}),
        Line(points={{0,-30},{0,-16}}, color={0,0,0}),
        Line(points={{20,-30},{20,-16}}, color={0,0,0}),
        Line(points={{20,16},{20,30}}, color={0,0,0}),
        Line(points={{-20,16},{-20,30}}, color={0,0,0}),
        Line(points={{-8,16},{-8,30}}, color={0,0,0}),
        Line(points={{8,16},{8,30}}, color={0,0,0}),
        Line(points={{-8,16},{20,16}}, color={0,0,0}),
        Line(points={{-24,16},{-16,16}}, color={0,0,0}),
        Line(points={{-24,-16},{-16,-16}}, color={0,0,0}),
        Line(points={{-4,-16},{4,-16}}, color={0,0,0}),
        Line(points={{16,-16},{24,-16}}, color={0,0,0}),
        Line(points={{-80,-30},{-80,30}}, color={0,0,0}),
        Line(points={{-70,30},{-60,-30}}, color={0,0,0}),
        Line(points={{-40,-30},{-40,30}}, color={0,0,0}),
        Line(points={{-54,30},{-54,16},{-68,16}}, color={0,0,0}),
        Polygon(
          points={{-80,30},{-84,18},{-76,18},{-80,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-66,-16},{-58,-14},{-60,-30},{-66,-16}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44,-18},{-36,-18},{-40,-30},{-44,-18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{40,-30},{40,30}}, color={0,0,0}),
        Polygon(
          points={{40,30},{36,18},{44,18},{40,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{80,30},{60,-30}}, color={0,0,0}),
        Line(points={{50,30},{80,-30}}, color={0,0,0}),
        Polygon(
          points={{70,-20},{78,-16},{80,-30},{70,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{72,18},{80,30},{80,16},{72,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{66,30},{66,14},{58,14}}, color={0,0,0}),
        Text(
          extent={{-80,92},{80,112}},
          lineColor={0,0,255},
          textString="%name")}));
end V6_3CCLS;
