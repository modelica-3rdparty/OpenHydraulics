within OpenHydraulics.Circuits;
model OpenCenterSectionalValveCircuit
  "Open center circuit controlled by sectional valve"
  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  Components.Lines.NJunction j1(
     n_ports=4)
    annotation (Placement(transformation(extent={{52,-90},{72,-70}}, rotation=
           0)));
  Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{-68,-50},{-48,-30}},
          rotation=0)));

  Components.MotorsPumps.ConstantDisplacementPump constantDisplacementPump(
    Dconst=1e-4)
    annotation (Placement(transformation(extent={{-68,-72},{-48,-52}},
          rotation=0)));

  Components.Volumes.CircuitTank circuitTank(
    V_max=0.025,
    V_init=0.02)                  annotation (Placement(transformation(extent=
           {{2,-90},{-18,-70}}, rotation=0)));

  replaceable Components.Valves.DirectionalValves.SV6_3OCParallel Valve1
    annotation (Placement(transformation(extent={{-40,-58},{-4,-22}},
          rotation=0)));

  replaceable Components.Valves.DirectionalValves.SV6_3OCParallel valve2
    annotation (Placement(transformation(extent={{12,-58},{48,-22}}, rotation=
           0)));

  Components.Valves.ReliefValve reliefValve(
    dp_relief=15e6,
    dp_open=25e6)
    annotation (Placement(transformation(
        origin={76,-58},
        extent={{-8,-8},{8,8}},
        rotation=270)));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=250,
      useSupport=false)
    annotation (Placement(transformation(extent={{-88,-72},{-68,-52}},
          rotation=0)));
  Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=Modelica.Mechanics.MultiBody.Types.Init.Position)
                annotation (Placement(transformation(extent={{-48,0},{-28,20}},
          rotation=0)));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-78,0},{-58,20}}, rotation=
            0)));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=1000)
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  Components.Cylinders.DoubleActingCylinder doubleActingCylinder1(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=Modelica.Mechanics.MultiBody.Types.Init.Position)
                annotation (Placement(transformation(extent={{36,0},{56,20}},
          rotation=0)));

  Modelica.Mechanics.Translational.Components.Fixed fixed1
    annotation (Placement(transformation(extent={{6,0},{26,20}}, rotation=0)));
  Modelica.Mechanics.Translational.Components.Mass slidingMass1(
                                                           m=1000)
    annotation (Placement(transformation(extent={{64,0},{84,20}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine(
    startTime=0,
    freqHz=0.1,
    amplitude=1)
    annotation (Placement(transformation(extent={{-86,-36},{-66,-16}},
          rotation=0)));
equation
  connect(circuitTank.port_b,constantDisplacementPump. portT) annotation (Line(
        points={{-18,-80},{-58,-80},{-58,-72}}, color={255,0,0}));
  connect(circuitTank.port_a,j1. port[1]) annotation (Line(points={{2,-80},{
          62,-80},{62,-80.75}}, color={255,0,0}));
  connect(reliefValve.port_b,j1. port[4]) annotation (Line(points={{76,-66},{
          76,-79.25},{62,-79.25}}, color={255,0,0}));
  connect(valve2.T2_in, j1.port[2])                         annotation (Line(
        points={{46.2,-50.8},{62,-50.8},{62,-80.25}}, color={255,0,0}));
  connect(reliefValve.port_a, valve2.P1_out)
    annotation (Line(points={{76,-50},{76,-32.8},{46.2,-32.8}}, color={255,0,
          0}));
  connect(valve2.P2_out, j1.port[3])                         annotation (Line(
        points={{46.2,-40},{62,-40},{62,-79.75}}, color={255,0,0}));
  connect(constantDisplacementPump.portP,j2. port[1]) annotation (Line(points={{-58,-52},
          {-58,-40.6667}},           color={255,0,0}));
  connect(Valve1.P1_in, j2.port[2])     annotation (Line(points={{-38.2,-32.8},
          {-58,-32.8},{-58,-40}}, color={255,0,0}));
  connect(Valve1.P2_in, j2.port[3])     annotation (Line(points={{-38.2,-40},
          {-58,-40},{-58,-39.3333}}, color={255,0,0}));
  connect(Valve1.P2_out, valve2.P2_in) annotation (Line(points={{-5.8,-40},{
          13.8,-40}}, color={255,0,0}));
  connect(Valve1.T2_in, valve2.T2_out) annotation (Line(points={{-5.8,-50.8},
          {13.8,-50.8}}, color={255,0,0}));
  connect(constantSpeed.flange, constantDisplacementPump.flange_a)
    annotation (Line(points={{-68,-62},{-68,-62}}, color={0,0,0}));
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{-48,10},{-68,10}}, color={0,127,0}));
  connect(slidingMass.flange_a,doubleActingCylinder. flange_b) annotation (Line(
        points={{-20,10},{-28,10}}, color={0,127,0}));
  connect(doubleActingCylinder.port_a, Valve1.A) annotation (Line(points={{
          -46,2},{-46,-18},{-29.2,-18},{-29.2,-23.8}}, color={255,0,0}));
  connect(doubleActingCylinder.port_b, Valve1.B) annotation (Line(points={{
          -30,2},{-30,-14},{-14.8,-14},{-14.8,-23.8}}, color={255,0,0}));
  connect(doubleActingCylinder1.flange_a,fixed1.flange)  annotation (Line(
        points={{36,10},{16,10}}, color={0,127,0}));
  connect(slidingMass1.flange_a, doubleActingCylinder1.flange_b)
                                                               annotation (Line(
        points={{64,10},{56,10}}, color={0,127,0}));
  connect(valve2.A, doubleActingCylinder1.port_a) annotation (Line(points={{
          22.8,-23.8},{22.8,-12},{38,-12},{38,2}}, color={255,0,0}));
  connect(valve2.B, doubleActingCylinder1.port_b) annotation (Line(points={{
          37.2,-23.8},{37.2,-18},{54,-18},{54,2}}, color={255,0,0}));
  connect(sine.y, Valve1.u[1]) annotation (Line(points={{-65,-26},{-48,-26},{
          -48,-56.2},{-28.3,-56.2}}, color={0,0,127}));
  connect(valve2.P1_in, Valve1.P1_out) annotation (Line(points={{13.8,-32.8},
          {-5.8,-32.8}}, color={255,0,0}));
  connect(Valve1.y, valve2.u) annotation (Line(points={{-16.6,-56.2},{23.7,
          -56.2}}, color={0,0,127}));
  annotation (Diagram(graphics),
    experiment(StopTime=250, Tolerance=1e-008),
    __Dymola_experimentSetupOutput);
end OpenCenterSectionalValveCircuit;
