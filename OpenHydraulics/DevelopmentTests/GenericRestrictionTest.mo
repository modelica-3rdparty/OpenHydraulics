within OpenHydraulics.DevelopmentTests;
model GenericRestrictionTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.FluidPower2MechRotConst idealPump(port_b(p(start=2e5)))
                       annotation (Placement(transformation(extent={{-30,-10},
            {-10,10}})));

  Basic.GenericPressureLoss GenericRestriction(D_a=0.01,D_b=0.01,
    use_Re=true)
    annotation (Placement(transformation(
        origin={20,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Sine sinusoid(
    startTime=0.01,
    f=0.5,
    amplitude=10) annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2000,
      V_init=1000)
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(idealPump.port_a, circuitTank.port_b) annotation (Line(points={{-20,
          -10},{-20,-30}}, color={255,0,0}));
  connect(idealPump.port_b, GenericRestriction.port_b)
                                               annotation (Line(points={{-20,
          10},{-20,20},{20,20},{20,10}}, color={255,0,0}));
  connect(GenericRestriction.port_a, circuitTank.port_a)
                                                 annotation (Line(points={{20,
          -10},{20,-30},{0,-30}}, color={255,0,0}));
  connect(sinusoid.y, torque.tau)
    annotation (Line(points={{-73,0},{-62,0}}, color={0,0,127}));
  connect(torque.flange,   idealPump.flange_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=10));
end GenericRestrictionTest;
