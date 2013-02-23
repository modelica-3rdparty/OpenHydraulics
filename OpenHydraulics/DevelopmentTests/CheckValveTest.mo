within OpenHydraulics.DevelopmentTests;
model CheckValveTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.FluidPower2MechRotConst idealPump(port_b(p(start=2e5)))
                       annotation (Placement(transformation(extent={{-30,-10},
            {-10,10}}, rotation=0)));

  OpenHydraulics.Components.Valves.CheckValve checkValve(q_nom=0.001)
    annotation (Placement(transformation(
        origin={20,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Sine sinusoid(startTime=0.01)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}},
          rotation=0)));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2000,
      V_init=1000)
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}}, rotation=
           0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
          rotation=0)));
equation
  connect(idealPump.port_a, circuitTank.port_b) annotation (Line(points={{-20,
          -10},{-20,-30}}, color={255,0,0}));
  connect(idealPump.port_b, checkValve.port_b) annotation (Line(points={{-20,
          10},{-20,20},{20,20},{20,10}}, color={255,0,0}));
  connect(checkValve.port_a, circuitTank.port_a) annotation (Line(points={{20,
          -10},{20,-30},{0,-30}}, color={255,0,0}));
  connect(sinusoid.y, torque.tau)
    annotation (Line(points={{-73,0},{-62,0}}, color={0,0,127}));
  connect(torque.flange,   idealPump.flange_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=5, Tolerance=1e-006),
    experimentSetupOutput);
end CheckValveTest;
