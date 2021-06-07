within OpenHydraulics.Circuits;
model PressureCompensated

    extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.Position) annotation (Placement(transformation(extent={{0,40},{20,60}})));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-20,38},{0,58}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1,
    startTime=0,
    f=0.1) annotation (Placement(transformation(
        origin={60,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Components.MotorsPumps.PCLSPump PCPump(
    Dmax=1e-5)
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));

  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2, V_init=1)
                                  annotation (Placement(transformation(extent=
           {{34,-70},{14,-50}})));

  OpenHydraulics.Components.Valves.DirectionalValves.V4_3CC v4_3CC(
    portA(p(start=101325, fixed=true)),
    portB(p(start=101325, fixed=false)),
    portP(p(start=101325)),
    P2A(table=[0,0; 1,1]),
    B2T(table=[0,0; 1,1]),
    P2B(table=[-1,1; 0,0; 1,0]),
    A2T(table=[-1,1; 0,0]))
    annotation (Placement(transformation(extent={{0,0},{20,20}})));

  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=150,
      useSupport=false)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=1000)
    annotation (Placement(transformation(extent={{28,40},{48,60}})));
  OpenHydraulics.Components.Lines.NJunction j3
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));

equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{0,50},{-10,50},{-10,48}}, color={0,127,0}));
  connect(v4_3CC.portA, doubleActingCylinder.port_a)    annotation (Line(
        points={{6,18},{6,28},{2,28},{2,42}}, color={255,0,0}));
  connect(v4_3CC.portB, doubleActingCylinder.port_b)    annotation (Line(
        points={{14,18},{14,28},{18,28},{18,42}}, color={255,0,0}));
  connect(v4_3CC.control, sine.y)    annotation (Line(points={{21,10},{35,10},
          {35,10},{49,10}}, color={0,0,127}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{0,-20},{0,
          -20},{-20,-20}}, color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{34,-60},{
          40,-60},{40,-20.6667}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{20,-20},{
          40,-20},{40,-20}}, color={255,0,0}));
  connect(v4_3CC.portT, j2.port[3])    annotation (Line(points={{14,2},{14,0},
          {40,0},{40,-19.3333}}, color={255,0,0}));
  connect(j1.port[3], v4_3CC.portP)    annotation (Line(points={{-20,-19.3333},
          {-20,0},{6,0},{6,2}}, color={255,0,0}));
  connect(PCPump.portP, j1.port[1])   annotation (Line(points={{-20,-40},{-20,
          -20.6667}}, color={255,0,0}));
  connect(constantSpeed.flange, PCPump.flange_a)
    annotation (Line(points={{-40,-50},{-30,-50}}, color={0,0,0}));
  connect(slidingMass.flange_a, doubleActingCylinder.flange_b)
    annotation (Line(points={{28,50},{20,50}}, color={0,127,0}));
  connect(circuitTank.port_b, j3.port[3]) annotation (Line(points={{14,-60},{
          7,-60},{7,-59.3333},{0,-59.3333}}, color={255,0,0}));
  connect(PCPump.portT, j3.port[2]) annotation (Line(points={{-20,-60},{0,-60}},
        color={255,0,0}));
  connect(PCPump.portLS, j3.port[1]) annotation (Line(points={{-28,-58},{-28,
          -66},{0,-66},{0,-60.6667}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(
      StopTime=10,
      NumberOfIntervals=5000,
      Tolerance=1e-008));
end PressureCompensated;
