within OpenHydraulics.DevelopmentTests;
model TankTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  Basic.LaminarRestriction laminarRestriction(L=3) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,20})));
  Components.Volumes.Tank tank(p_const=500000)
    annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
  Components.Volumes.Tank tank1(p_const=100000)
    annotation (Placement(transformation(extent={{10,-20},{30,0}})));
equation
  connect(tank.port, laminarRestriction.port_b) annotation (Line(
      points={{-40,0},{-40,20},{-20,20}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(laminarRestriction.port_a, tank1.port) annotation (Line(
      points={{0,20},{20,20},{20,0}},
      color={255,0,0},
      smooth=Smooth.None));
  annotation (
      Diagram(graphics),
    experiment(StopTime=1000),
    experimentSetupOutput);
end TankTest;
