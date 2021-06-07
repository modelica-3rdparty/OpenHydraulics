within OpenHydraulics.Circuits;
model OpenCenter
  "Open Center circuit with fixed displacement pump and open center valve"

    extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(
        origin={0,6},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.Position,
    q_nom=1e-4) annotation (Placement(transformation(extent={{42,38},{62,58}})));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(
        origin={36,48},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=1000)
    annotation (Placement(transformation(extent={{68,38},{88,58}})));
  Modelica.Blocks.Sources.Sine sine(
    startTime=1,
    f=0.1,
    amplitude=1) annotation (Placement(transformation(
        origin={80,-38},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2, V_init=1)
                                  annotation (Placement(transformation(extent=
           {{-16,-24},{-36,-4}})));
  OpenHydraulics.Components.Lines.NJunction j1(n_ports=3)
    annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=50,
      useSupport=false)
    annotation (Placement(transformation(extent={{-86,0},{-70,16}})));
  OpenHydraulics.Components.Valves.DirectionalValves.V4_3OC valve4_3posOC
    annotation (Placement(transformation(
        origin={26,8},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  OpenHydraulics.Components.MotorsPumps.ConstantDisplacementPump constantDisplacementPump(Dconst=
        1e-5)
    annotation (Placement(transformation(extent={{-64,-2},{-44,18}})));

  Modelica.Blocks.Sources.Sine sine1(
    f=0.1,
    startTime=9,
    phase=5.02658,
    amplitude=1) annotation (Placement(transformation(
        origin={80,-2},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
        origin={50,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{42,48},{36,48}}, color={0,127,0}));
  connect(doubleActingCylinder.flange_b, slidingMass.flange_a)
    annotation (Line(points={{62,48},{68,48}}, color={0,127,0}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{
          1.83697e-015,16},{1.83697e-015,22},{-5.55112e-017,22},{
          -5.55112e-017,30}}, color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{-16,-14},
          {0,-14},{0,-14.6667}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{
          -1.83697e-015,-4},{-1.83697e-015,-10},{0,-10},{0,-14}}, color={255,
          0,0}));
  connect(valve4_3posOC.portA, doubleActingCylinder.port_a) annotation (Line(
        points={{34,12},{44,12},{44,40}}, color={255,0,0}));
  connect(valve4_3posOC.portB, doubleActingCylinder.port_b) annotation (Line(
        points={{34,4},{60,4},{60,40}}, color={255,0,0}));
  connect(valve4_3posOC.portT, j2.port[3]) annotation (Line(points={{18,4},{
          18,-14},{0,-14},{0,-13.3333}}, color={255,0,0}));
  connect(valve4_3posOC.portP, j1.port[3]) annotation (Line(points={{18,12},{
          18,30},{-0.666667,30}}, color={255,0,0}));
  connect(constantSpeed.flange, constantDisplacementPump.flange_a)
    annotation (Line(points={{-70,8},{-64,8}}, color={0,0,0}));
  connect(constantDisplacementPump.portP, j1.port[1]) annotation (Line(points={{-54,18},
          {-54,30},{0.666667,30}},          color={255,0,0}));
  connect(sine.y, add.u1) annotation (Line(points={{69,-38},{64,-38},{64,-26},
          {62,-26}}, color={0,0,127}));
  connect(sine1.y, add.u2) annotation (Line(points={{69,-2},{64,-2},{64,-14},
          {62,-14}}, color={0,0,127}));
  connect(add.y, valve4_3posOC.control) annotation (Line(points={{39,-20},{26,
          -20},{26,-3}}, color={0,0,127}));
  connect(circuitTank.port_b, constantDisplacementPump.portT) annotation (Line(
        points={{-36,-14},{-54,-14},{-54,-2}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=100, Tolerance=1e-008));
end OpenCenter;
