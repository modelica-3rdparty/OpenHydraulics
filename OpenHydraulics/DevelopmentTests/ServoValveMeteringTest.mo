within OpenHydraulics.DevelopmentTests;
model ServoValveMeteringTest "test of Servovalve metering curve"
    extends OpenHydraulics.Interfaces.PartialFluidCircuit;

  OpenHydraulics.Basic.VariableRestriction VR30(
    table=[0,0; 10,0; 25,0; 30,0.03;40,0.12;50,0.25;60,0.36;70,0.52;80,0.68;90,0.84;
        100,1],
    max_contr=100,
    D_nom=D_nom,
    zeta_nom=zeta_nom,
    q_nom=q_nom/60/1000)           annotation (Placement(transformation(
          extent={{-10,8},{10,32}})));
  Basic.ConstPressureSource constPressureSource(
    p_const=31e5)      annotation (Placement(transformation(extent={{-60,0},{
            -40,20}})));
  Basic.ConstPressureSource constPressureSource1 annotation (Placement(transformation(
          extent={{50,0},{70,20}})));
  Modelica.Blocks.Sources.Ramp ramp(height=100, duration=100)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Basic.ConstPressureSource constPressureSource2(
    p_const=11e5)      annotation (Placement(transformation(extent={{-60,60},
            {-40,80}})));
  OpenHydraulics.Basic.VariableRestriction VR10(
    table=[0,0; 10,0; 25,0; 30,0.03;40,0.12;50,0.25;60,0.36;70,0.52;80,0.68;90,0.84;
        100,1],
    max_contr=100,
    D_nom=D_nom,
    zeta_nom=zeta_nom,
    q_nom=q_nom/60/1000)           annotation (Placement(transformation(
          extent={{-10,68},{10,92}})));
  Basic.ConstPressureSource constPressureSource3(
    p_const=100e5)     annotation (Placement(transformation(extent={{-60,-80},
            {-40,-60}})));
  OpenHydraulics.Basic.VariableRestriction VR100(
    table=[0,0; 10,0; 25,0; 30,0.03;40,0.12;50,0.25;60,0.36;70,0.52;80,0.68;90,0.84;
        100,1],
    max_contr=100,
    D_nom=D_nom,
    zeta_nom=zeta_nom,
    q_nom=q_nom/60/1000)           annotation (Placement(transformation(
          extent={{-10,-48},{10,-72}})));
  OpenHydraulics.Components.Lines.NJunction j1(n_ports=4)
    annotation (Placement(transformation(extent={{28,10},{48,30}})));
  parameter Real D_nom=0.001 "nominal diameter for all valves";
  parameter Real zeta_nom=2 "nominal loss factor for all valves";
  parameter Real q_nom=7 "nominal flow through all valves in L/sec";
equation
  connect(constPressureSource.port, VR30.port_a)
    annotation (Line(points={{-50,20},{-10,20}}, color={255,0,0}));
  connect(ramp.y, VR30.control)                annotation (Line(points={{-19,
          -20},{0,-20},{0,10.4}}, color={0,0,127}));
  connect(constPressureSource2.port, VR10.port_a)
    annotation (Line(points={{-50,80},{-10,80}}, color={255,0,0}));
  connect(ramp.y, VR10.control) annotation (Line(points={{-19,-20},{20,-20},{
          20,44},{0,44},{0,70.4}}, color={0,0,127}));
  connect(constPressureSource3.port, VR100.port_a)
    annotation (Line(points={{-50,-60},{-10,-60}}, color={255,0,0}));
  connect(VR100.port_b, j1.port[1]) annotation (Line(points={{10,-60},{38,-60},
          {38,19.25}}, color={255,0,0}));
  connect(VR30.port_b, j1.port[2]) annotation (Line(points={{10,20},{38,20},{
          38,19.75}}, color={255,0,0}));
  connect(VR10.port_b, j1.port[3]) annotation (Line(points={{10,80},{38,80},{
          38,20.25}}, color={255,0,0}));
  connect(j1.port[4], constPressureSource1.port) annotation (Line(points={{38,
          20.75},{36,20.75},{36,20},{60,20}}, color={255,0,0}));
  connect(ramp.y, VR100.control) annotation (Line(points={{-19,-20},{0,-20},{
          0,-50.4}}, color={0,0,127}));
  annotation (
    experiment(StopTime=100));
end ServoValveMeteringTest;
