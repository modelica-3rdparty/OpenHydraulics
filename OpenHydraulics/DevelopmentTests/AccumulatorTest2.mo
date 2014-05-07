within OpenHydraulics.DevelopmentTests;
model AccumulatorTest2

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.FluidPower2MechRotConst idealConDispPump
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
                                                J=0.001)
    annotation (Placement(transformation(extent={{24,0},{44,20}})));
  Components.Volumes.Accumulator accumulator(
    liquidVolume=0.01,
    gasVolume=0.011,
    p_init=1e6) annotation (Placement(transformation(extent={{-10,38},{10,58}})));
  Components.Volumes.Accumulator accumulator1(
    liquidVolume=0.01,
    gasVolume=0.011,
    initType=OpenHydraulics.Types.AccInit.Pressure)
    annotation (Placement(transformation(
        origin={0,-32},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(idealConDispPump.flange_b, inertia.flange_a) annotation (Line(
        points={{10,10},{24,10}}, color={0,0,0}));
  connect(accumulator.port_a, idealConDispPump.port_b)
    annotation (Line(points={{0,38},{0,20}}, color={255,0,0}));
  connect(accumulator1.port_a, idealConDispPump.port_a) annotation (Line(
        points={{1.22465e-015,-22},{0,-22},{0,0}}, color={255,0,0}));
  annotation (Diagram(graphics));
end AccumulatorTest2;
