within OpenHydraulics.Circuits;
model OpenCenter_tandem
  "Open Center circuit with fixed displacement pump and open center tandem valve"

    extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=Types.RevoluteInit.Position) annotation (Placement(transformation(extent={{-68,48},{-48,68}})));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-90,48},{-70,68}})));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=1000)
    annotation (Placement(transformation(extent={{-44,48},{-24,68}})));
  Modelica.Blocks.Sources.Sine sine(
    startTime=0,
    amplitude=1,
    offset=0,
    f=0.1) annotation (Placement(transformation(
        origin={-10,88},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2, V_init=1)
                                  annotation (Placement(transformation(extent=
           {{10,-50},{-10,-30}})));

  OpenHydraulics.Components.Lines.NJunction j1(n_ports=4)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

  OpenHydraulics.Components.Lines.NJunction j2(n_ports=4)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=250,
      useSupport=false)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  OpenHydraulics.Components.MotorsPumps.ConstantDisplacementPump constantDisplacementPump(Dconst=
        1e-5)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));

  OpenHydraulics.Components.Valves.DirectionalValves.V4_3OCTandem valve4_3posOCtandem
    annotation (Placement(transformation(extent={{-70,18},{-50,38}})));
  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder1(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=Types.RevoluteInit.Position) annotation (Placement(transformation(extent={{20,48},{40,68}})));

  Modelica.Mechanics.Translational.Components.Fixed fixed1
    annotation (Placement(transformation(extent={{0,48},{20,68}})));
  OpenHydraulics.Components.Valves.DirectionalValves.V4_3OCTandem valve4_3posOCtandem1
    annotation (Placement(transformation(extent={{20,18},{40,38}})));
  Modelica.Mechanics.Translational.Components.Mass slidingMass1(
                                                           m=1000)
    annotation (Placement(transformation(extent={{44,48},{64,68}})));
  Modelica.Blocks.Sources.Constant const(k=0.5)
    annotation (Placement(transformation(
        origin={70,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{-68,58},{-80,58}}, color={0,127,0}));
  connect(doubleActingCylinder.flange_b, slidingMass.flange_a)
    annotation (Line(points={{-48,58},{-44,58}}, color={0,127,0}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{-10,0},{
          -10,-0.25},{-20,-0.25}}, color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{10,-40},{
          20,-40},{20,-0.75}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{10,0},{20,
          0},{20,-0.25}}, color={255,0,0}));
  connect(constantSpeed.flange, constantDisplacementPump.flange_a)
    annotation (Line(points={{-40,-20},{-30,-20}}, color={0,0,0}));
  connect(constantDisplacementPump.portP, j1.port[1]) annotation (Line(points=
         {{-20,-10},{-20,-0.75}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portP, j1.port[3]) annotation (Line(points={{
          -64,20},{-64,0.25},{-20,0.25}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portA, doubleActingCylinder.port_a) annotation (Line(
        points={{-64,36},{-64,40},{-66,40},{-66,50}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portB, doubleActingCylinder.port_b) annotation (Line(
        points={{-56,36},{-56,50},{-50,50}}, color={255,0,0}));
  connect(valve4_3posOCtandem.control, sine.y) annotation (Line(points={{-49,28},
          {-10,28},{-10,77}},     color={0,0,127}));
  connect(constantDisplacementPump.portT, circuitTank.port_b) annotation (Line(
        points={{-20,-30},{-20,-40},{-10,-40}}, color={255,0,0}));
  connect(doubleActingCylinder1.flange_a,fixed1.flange)  annotation (Line(
        points={{20,58},{10,58}}, color={0,127,0}));
  connect(valve4_3posOCtandem1.portA, doubleActingCylinder1.port_a)
                                                                  annotation (Line(
        points={{26,36},{26,40},{22,40},{22,50}}, color={255,0,0}));
  connect(slidingMass1.flange_a, doubleActingCylinder1.flange_b)
    annotation (Line(points={{44,58},{40,58}}, color={0,127,0}));
  connect(valve4_3posOCtandem1.portB, doubleActingCylinder1.port_b)
    annotation (Line(points={{34,36},{34,40},{38,40},{38,50}}, color={255,0,0}));
  connect(const.y, valve4_3posOCtandem1.control) annotation (Line(points={{70,
          79},{70,28},{41,28}}, color={0,0,127}));
  connect(valve4_3posOCtandem.portT, j2.port[3]) annotation (Line(points={{
          -56,20},{-18,20},{20,8},{20,0.25}}, color={255,0,0}));
  connect(valve4_3posOCtandem1.portT, j2.port[4]) annotation (Line(points={{
          34,20},{34,0.75},{20,0.75}}, color={255,0,0}));
  connect(valve4_3posOCtandem1.portP, j1.port[4]) annotation (Line(points={{
          26,20},{20,20},{-20,8},{-20,0.75}}, color={255,0,0}));
  annotation (
    experiment(StopTime=250, Tolerance=1e-008));
end OpenCenter_tandem;
