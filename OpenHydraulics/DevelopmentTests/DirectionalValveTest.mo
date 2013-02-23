within OpenHydraulics.DevelopmentTests;
model DirectionalValveTest

  Real quadratic "quadratic relationship for comparison";
  parameter Real constPos = 0.192;
  parameter Real constNeg = 3;
  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.FluidPower2MechRotConst idealPump
                       annotation (Placement(transformation(extent={{-30,-10},
            {-10,10}}, rotation=0)));

  OpenHydraulics.Basic.SharpEdgedOrifice restriction(
    D_pipe=0.02,
    L=0.01,
    D_min=0.01,
    alpha=10,
    use_Re=true)
    annotation (Placement(transformation(
        origin={60,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2000,
      V_init=1000)
    annotation (Placement(transformation(extent={{0,-40},{-20,-20}}, rotation=
           0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
          rotation=0)));
  OpenHydraulics.Components.Valves.DirectionalValves.V4_3CC valve4_3pos
                                                                    annotation (Placement(transformation(
        origin={16,4},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Sine sinusoid1(
    freqHz=.5,
    amplitude=1,
    startTime=0)
    annotation (Placement(transformation(
        origin={18,-56},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.RealExpression realExpression(y=5000)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}},
          rotation=0)));
equation
  quadratic = if restriction.dp>0 then sqrt(restriction.dp*constPos) else
                                       -sqrt(-restriction.dp*constNeg);

  connect(idealPump.port_a, circuitTank.port_b) annotation (Line(points={{-20,
          -10},{-20,-30}}, color={255,0,0}));
  connect(torque.flange,   idealPump.flange_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,0,0}));
  connect(idealPump.port_b, valve4_3pos.portP) annotation (Line(points={{-20,10},
          {-20,16},{2,16},{2,8},{8,8}},     color={255,0,0}));
  connect(circuitTank.port_a, valve4_3pos.portT) annotation (Line(points={{0,-30},
          {0,1.33227e-015},{8,1.33227e-015}},      color={255,0,0}));
  connect(valve4_3pos.portA, restriction.port_a)  annotation (Line(points={{24,8},{
          42,8},{42,20},{60,20},{60,10}},        color={255,0,0}));
  connect(valve4_3pos.portB, restriction.port_b)  annotation (Line(points={{24,
          -1.77636e-015},{34,-1.77636e-015},{34,0},{42,0},{42,-18},{60,-18},
          {60,-10}}, color={255,0,0}));
  connect(sinusoid1.y, valve4_3pos.control) annotation (Line(points={{18,-45},
          {18,-7},{16,-7}}, color={0,0,127}));
  connect(realExpression.y, torque.tau)
    annotation (Line(points={{-75,0},{-62,0}}, color={0,0,127}));
  annotation (
      Diagram(graphics),
    experiment(StopTime=10, Tolerance=1e-008),
    experimentSetupOutput);
end DirectionalValveTest;
