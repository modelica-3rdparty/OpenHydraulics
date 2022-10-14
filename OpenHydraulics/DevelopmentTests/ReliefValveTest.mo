within OpenHydraulics.DevelopmentTests;
model ReliefValveTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  Components.MotorsPumps.ConstantDisplacementPump idealPump(Dconst=1e-5)
                       annotation (Placement(transformation(extent={{-30,-10},
            {-10,10}})));

  OpenHydraulics.Components.Valves.ReliefValve reliefValve(q_nom=0.01,
      dp_relief=1e5)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2000,
      V_init=1000)
    annotation (Placement(transformation(extent={{40,-30},{20,-10}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=100,
      useSupport=false)
                     annotation (Placement(transformation(extent={{-60,-10},{
            -40,10}})));
equation
  connect(circuitTank.port_a, reliefValve.port_b) annotation (Line(points={{
          40,-20},{56,-20},{56,20},{40,20}}, color={255,0,0}));
  connect(constantSpeed.flange, idealPump.flange_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,0,0}));
  connect(idealPump.portP, reliefValve.port_a) annotation (Line(points={{-20,
          10},{-20,20},{20,20}}, color={255,0,0}));
  connect(idealPump.portT, circuitTank.port_b) annotation (Line(points={{-20,
          -10},{-20,-20},{20,-20}}, color={255,0,0}));
  annotation (
    experiment(StopTime=0.05, Tolerance=1e-006));
end ReliefValveTest;
