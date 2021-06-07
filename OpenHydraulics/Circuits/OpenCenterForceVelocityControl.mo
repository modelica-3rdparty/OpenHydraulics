within OpenHydraulics.Circuits;
model OpenCenterForceVelocityControl
  "Open Center circuit loaded and controlled by Force / Velocity controller"

    extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve(timeConstant=0.01)
    annotation (Placement(transformation(
        origin={-10,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    fixHeadPressure=true,
    fixRodPressure=true,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocity) annotation (Placement(transformation(extent={{30,10},{48,30}})));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(
        origin={24,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2, V_init=1)
                                  annotation (Placement(transformation(extent=
           {{-20,-60},{-40,-40}})));

  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(
        origin={-10,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=250,
      useSupport=false)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Components.Valves.DirectionalValves.V4_3CC valve4_3posOCtandem
    annotation (Placement(transformation(
        origin={22,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  OpenHydraulics.Components.MotorsPumps.ConstantDisplacementPump constantDisplacementPump(Dconst=
        1e-4)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));

  OpenHydraulics.Components.Sensors.FVController fVController(
    VelocityProfile(smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
        table=[0.0,0; 1,0; 2,0; 3,0.0001;4,0.0003;5,0.0002;6,0.0005;7,0.0001;8,
          0; 9,-0.0006;10,-0.0002;11,-0.0002;12,-0.00025;13,-0.00015;14,-0.0005;
          15,0; 16,0; 17,0.0009;18,0.0007;19,0.00005;20,0; 21,-0.0001;22,-0.00001;
          23,0; 24,0]),
    ForceProfile(table=[0.0,0; 1,0; 2,-10; 3,-200; 4,-200; 5,-50; 6,-10; 7,-30;
          8,0; 9,0; 10,60; 11,100; 12,100; 13,120; 14,0; 15,0; 16,-20; 17,-40;
          18,-80; 19,-80; 20,-500; 21,-100; 22,10; 23,0; 24,0]),
    k=300,
    Td=0.00001)   annotation (Placement(transformation(
        origin={70,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{30,20},{24,20}}, color={0,127,0}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{-10,-20},
          {-10,-15},{-10,-15},{-10,-10}}, color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{-20,-50},
          {-10,-50},{-10,-50.6667}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{-10,-40},
          {-10,-45},{-10,-45},{-10,-50}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portA, doubleActingCylinder.port_a)
                                                            annotation (Line(
        points={{30,-26},{32,-26},{32,12},{31.8,12}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portB, doubleActingCylinder.port_b)
                                                            annotation (Line(
        points={{30,-34},{46,-34},{46,12},{46.2,12}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portT, j2.port[3])
                                           annotation (Line(points={{14,-34},
          {12,-34},{12,-49.3333},{-10,-49.3333}}, color={255,0,0}));
  connect(valve4_3posOCtandem.portP, j1.port[3])
                                           annotation (Line(points={{14,-26},
          {12,-26},{12,-10},{-10.6667,-10}}, color={255,0,0}));
  connect(constantSpeed.flange, constantDisplacementPump.flange_a)
    annotation (Line(points={{-80,-30},{-70,-30}}, color={0,0,0}));
  connect(constantDisplacementPump.portP, j1.port[1]) annotation (Line(points={{-60,-20},
          {-60,-10},{-9.33333,-10}},           color={255,0,0}));
  connect(fVController.y, valve4_3posOCtandem.control)
                                                 annotation (Line(points={{67,-15},
          {67,-46},{22,-46},{22,-41}},      color={0,0,127}));
  connect(fVController.flange_a, doubleActingCylinder.flange_b) annotation (Line(
        points={{75,-5},{75,20},{48,20}}, color={0,127,0}));
  connect(constantDisplacementPump.portT, circuitTank.port_b) annotation (Line(
        points={{-60,-40},{-60,-50},{-40,-50}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(
      StopTime=25,
      NumberOfIntervals=5000,
      Tolerance=1e-008));
end OpenCenterForceVelocityControl;
