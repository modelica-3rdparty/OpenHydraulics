within OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses;
partial model PartialV6_3

    // sizing parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 1e6 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing"));

  parameter Real q_fraction_P12A = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P12B = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_A2T2 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_B2T2 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P22T1 = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));

    // dynamic response parameters
  parameter SI.Frequency bandwidth = 10 "Bandwidth of 2nd order response"
    annotation(Dialog(tab="Dynamics"));
  parameter Real dampCoeff = 1 "Damping coefficient of 2nd order response"
    annotation(Dialog(tab="Dynamics"));
  extends OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.V6_3Interface;

  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(extent={{-90,-68},{-70,-48}})));
  OpenHydraulics.Components.Lines.NJunction j2(n_ports=2)
    annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));
  OpenHydraulics.Components.Lines.NJunction j3
    annotation (Placement(transformation(extent={{50,-68},{70,-48}})));
  OpenHydraulics.Components.Lines.NJunction j4
    annotation (Placement(transformation(extent={{-90,52},{-70,72}})));
  OpenHydraulics.Components.Lines.NJunction j5
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  OpenHydraulics.Components.Lines.NJunction j6
    annotation (Placement(transformation(extent={{50,52},{70,72}})));
  Basic.VariableRestriction P22T1(
    final q_nom = q_nom*q_fraction_P22T1,
    D_nom=0.01,
    dp_nom=2e5,
    p_init=p_init,
    min_contr=-1,
    table=[-1,0; 0,1; 1,0],
    max_contr=1)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={-10,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  Basic.VariableRestriction P12B(
    final q_nom = q_nom*q_fraction_P12B,
    D_nom=0.01,
    dp_nom=2e5,
    p_init=p_init,
    table=[0,0; 1,1],
    min_contr=0,
    max_contr=1)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={-80,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  Basic.VariableRestriction A2T2(
    final q_nom = q_nom*q_fraction_A2T2,
    D_nom=0.01,
    dp_nom=2e5,
    p_init=p_init,
    table=[0,0; 1,1],
    min_contr=0,
    max_contr=1)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={60,20},
        extent={{-8,-8},{8,8}},
        rotation=90)));

  Basic.VariableRestriction B2T2(
    final q_nom = q_nom*q_fraction_B2T2,
    D_nom=0.01,
    dp_nom=2e5,
    p_init=p_init,
    min_contr=-1,
    max_contr=0,
    table=[-1,1; 0,0])
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
          extent={{30,-30},{50,-10}})));

  Basic.VariableRestriction P12A(
    final q_nom = q_nom*q_fraction_P12A,
    D_nom=0.01,
    dp_nom=2e5,
    p_init=p_init,
    min_contr=-1,
    max_contr=0,
    table=[-1,1; 0,0])
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
          extent={{-60,-10},{-40,-30}})));

  Modelica.Blocks.Continuous.SecondOrder dynamicResponse(
    w=bandwidth*2*Modelica.Constants.pi,
    D=dampCoeff,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
equation
  connect(j1.port[1], portP1) annotation (Line(points={{-80,-58.6667},{
          -80,-80}}, color={255,0,0}));
  connect(j5.port[1], portT1) annotation (Line(points={{-10,59.5},{-10,
          80},{0,80}}, color={255,0,0}));
  connect(j2.port[2], P22T1.port_a)   annotation (Line(points={{-10,
          -57.5},{-10,-50}}, color={255,0,0}));
  connect(P22T1.port_b, j5.port[2])   annotation (Line(points={{-10,-30},
          {-10,60.5}}, color={255,0,0}));
  connect(j1.port[2], P12B.port_a) annotation (Line(points={{-80,-58},{
          -80,0}}, color={255,0,0}));
  connect(P12B.port_b, j4.port[2]) annotation (Line(points={{-80,20},{
          -80,62}}, color={255,0,0}));
  connect(A2T2.port_b, j6.port[2]) annotation (Line(points={{60,28},{60,
          62}}, color={255,0,0}));
  connect(j3.port[2], A2T2.port_a) annotation (Line(points={{60,-58},{
          60,12}}, color={255,0,0}));
  connect(j1.port[3], P12A.port_a) annotation (Line(points={{-80,
          -57.3333},{-80,-20},{-60,-20}}, color={255,0,0}));
  connect(j3.port[3], B2T2.port_b) annotation (Line(points={{60,
          -57.3333},{60,-20},{50,-20}}, color={255,0,0}));
  connect(P12A.port_b, j6.port[3]) annotation (Line(points={{-40,-20},{
          -40,-20},{0,40},{60,40},{60,62.6667}}, color={255,0,0}));
  connect(B2T2.port_a, j4.port[3]) annotation (Line(points={{30,-20},{
          20,-20},{-20,40},{-80,40},{-80,62.6667}}, color={255,0,0}));
  connect(portA, j4.port[1]) annotation (Line(points={{-80,80},{-80,
          61.3333}}, color={255,0,0}));
  connect(j2.port[1], portP) annotation (Line(points={{-10,-58.5},{-10,
          -80},{0,-80}}, color={255,0,0}));
  connect(dynamicResponse.u, control) annotation (Line(points={{102,30},
          {112,30},{112,0},{106,0}}, color={0,0,127}));
  connect(dynamicResponse.y, A2T2.control) annotation (Line(points={{79,
          30},{74,30},{74,20},{66.4,20}}, color={0,0,127}));
  connect(dynamicResponse.y, P12B.control) annotation (Line(points={{79,
          30},{74,30},{74,10},{-72,10}}, color={0,0,127}));
  connect(dynamicResponse.y, P22T1.control)   annotation (Line(points={
          {79,30},{74,30},{74,-40},{-2,-40}}, color={0,0,127}));
  connect(dynamicResponse.y, B2T2.control) annotation (Line(points={{79,
          30},{74,30},{74,-40},{40,-40},{40,-28}}, color={0,0,127}));
  connect(dynamicResponse.y, P12A.control) annotation (Line(points={{79,
          30},{74,30},{74,10},{-50,10},{-50,-12}}, color={0,0,127}));
  connect(j3.port[1], portT2) annotation (Line(points={{60,-58.6667},{
          60,-80},{80,-80}}, color={255,0,0}));
  connect(j6.port[1], portB) annotation (Line(points={{60,61.3333},{60,
          80},{80,80}}, color={255,0,0}));

end PartialV6_3;
