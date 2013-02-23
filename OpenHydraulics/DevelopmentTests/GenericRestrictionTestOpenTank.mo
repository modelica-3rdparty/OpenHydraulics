within OpenHydraulics.DevelopmentTests;
model GenericRestrictionTestOpenTank

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.FluidPower2MechRotConst idealPump(port_b(p(start=2e5)))
                       annotation (Placement(transformation(extent={{-30,-10},
            {-10,10}}, rotation=0)));

  Basic.LaminarRestriction             GenericRestriction(L=3)
    annotation (Placement(transformation(
        origin={20,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Sine sinusoid(
    startTime=0.01,
    freqHz=.5,
    amplitude=10)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
          rotation=0)));
  Components.Volumes.Tank tank(p_const=100000)
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Components.Volumes.Tank tank1(p_const=100000)
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
equation
  connect(idealPump.port_b, GenericRestriction.port_b)
                                               annotation (Line(points={{-20,
          10},{-20,20},{20,20},{20,10}}, color={255,0,0}));
  connect(sinusoid.y, torque.tau)
    annotation (Line(points={{-73,0},{-62,0}}, color={0,0,127}));
  connect(torque.flange,   idealPump.flange_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,0,0}));
  connect(idealPump.port_a, tank.port) annotation (Line(
      points={{-20,-10},{-20,-20}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(GenericRestriction.port_a, tank1.port) annotation (Line(
      points={{20,-10},{20,-20}},
      color={255,0,0},
      smooth=Smooth.None));
  annotation (
      Diagram(graphics),
    experiment(StopTime=10),
    experimentSetupOutput);
end GenericRestrictionTestOpenTank;
