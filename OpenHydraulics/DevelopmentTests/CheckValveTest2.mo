within OpenHydraulics.DevelopmentTests;
model CheckValveTest2

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.FluidPower2MechRotConst idealPump(port_b(p(start=2e5)))
                       annotation (Placement(transformation(extent={{-30,-10},
            {-10,10}})));

  OpenHydraulics.Components.Valves.CheckValve checkValve(q_nom=0.001)
    annotation (Placement(transformation(
        origin={20,-4},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Sine sinusoid(startTime=0.01)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2000,
      V_init=1000)
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}})));
  OpenHydraulics.Components.Valves.CheckValve checkValve1(q_nom=0.001)
    annotation (Placement(transformation(
        origin={40,-4},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sources.Speed speed(useSupport=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Lines.NJunction j2(            n_ports=3)
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Components.Lines.NJunction j1(            n_ports=3)
    annotation (Placement(transformation(extent={{10,10},{30,30}})));
equation
  connect(idealPump.port_a, circuitTank.port_b) annotation (Line(points={{-20,
          -10},{-20,-30}}, color={255,0,0}));
  connect(speed.flange,   idealPump.flange_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,0,0}));
  connect(sinusoid.y, speed.w_ref)
    annotation (Line(points={{-73,0},{-62,0}}, color={0,0,127}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{0,-30},{
          20,-30},{20,-30.6667}}, color={255,0,0}));
  connect(checkValve.port_a, j2.port[2]) annotation (Line(points={{20,-14},{
          20,-30}}, color={255,0,0}));
  connect(checkValve1.port_b, j2.port[3]) annotation (Line(points={{40,-14},{
          40,-30},{20,-30},{20,-29.3333}}, color={255,0,0}));
  connect(idealPump.port_b, j1.port[1]) annotation (Line(points={{-20,10},{
          -20,20},{20,20},{20,19.3333}}, color={255,0,0}));
  connect(checkValve.port_b, j1.port[2])
    annotation (Line(points={{20,6},{20,20}}, color={255,0,0}));
  connect(checkValve1.port_a, j1.port[3]) annotation (Line(points={{40,6},{40,
          20},{20,20},{20,20.6667}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=5, Tolerance=1e-006));
end CheckValveTest2;
