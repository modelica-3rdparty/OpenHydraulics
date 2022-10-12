within OpenHydraulics.DevelopmentTests;
model PumpTest "AccuTest"

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  parameter Real dispFraction = 1;
  parameter Real Cv = 60000 "Coefficient of viscous drag";
  parameter Real Cf = 0.007
    "Coefficient of Coulomb friction (fraction of full stroke torque)";
  parameter Real Cs = 1.8e-9 "Leakage coefficient";
  parameter Real Vr = 0.54 "Volume ratio of pump or motor";
  parameter SI.DynamicViscosity mu = oil.dynamicViscosity(5e6)
    "Dynamic viscosity (used only for efficiency models)";
  parameter SI.BulkModulus B = oil.approxBulkModulus(5e6)
    "Approximate bulk modulus (used only for efficiency models)";

  // efficiencies
  Real volumetricEfficiency2500;
  Real mechanicalEfficiency2500;
  Real energyEfficiency2500;
  Real volumetricEfficiency5000;
  Real mechanicalEfficiency5000;
  Real energyEfficiency5000;

  // mechanical components

  OpenHydraulics.Components.MotorsPumps.VariableDisplacementPump variableDisplacementPump(
    Dmax=0.000028,
    Dmin=-0.000028,
    Cv=Cv,
    Cf=Cf,
    Cs=Cs,
    Vr=Vr,
    mu=mu,
    B=B)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Basic.ConstPressureSource lowPressure(
       p_const=1e5)
    annotation (Placement(transformation(extent={{-10,-52},{10,-32}})));
  Basic.ConstPressureSource highPressure(
       p_const=346e5)
    annotation (Placement(transformation(
        origin={0,42},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression realExpression(y=dispFraction)
    annotation (Placement(transformation(extent={{-58,-38},{-38,-18}})));
  OpenHydraulics.Components.MotorsPumps.VariableDisplacementPump variableDisplacementPump1(
    Dmax=0.000028,
    Dmin=-0.000028,
    Cv=Cv,
    Cf=Cf,
    Cs=Cs,
    Vr=Vr,
    mu=mu,
    B=B)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Basic.ConstPressureSource lowPressure1(
       p_const=1e5)
    annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
  Basic.ConstPressureSource highPressure1(
       p_const=171e5)
    annotation (Placement(transformation(
        origin={30,42},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=250,
      useSupport=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  // compute the efficiencies
  volumetricEfficiency5000 = (variableDisplacementPump.fluidPower2MechRot.q_flow_a-
                          variableDisplacementPump.leakage_P2T.q_flow_a) /
                          variableDisplacementPump.fluidPower2MechRot.q_flow_a;
  mechanicalEfficiency5000 = variableDisplacementPump.fluidPower2MechRot.tau/
                         variableDisplacementPump.flange_a.tau;
  energyEfficiency5000 = volumetricEfficiency5000 * mechanicalEfficiency5000;
  volumetricEfficiency2500 = (variableDisplacementPump1.fluidPower2MechRot.q_flow_a-
                          variableDisplacementPump1.leakage_P2T.q_flow_a) /
                          variableDisplacementPump1.fluidPower2MechRot.q_flow_a;
  mechanicalEfficiency2500 = variableDisplacementPump1.fluidPower2MechRot.tau/
                         variableDisplacementPump1.flange_a.tau;
  energyEfficiency2500 = volumetricEfficiency2500 * mechanicalEfficiency2500;

  connect(variableDisplacementPump.portT, lowPressure.port)
    annotation (Line(points={{0,-10},{0,-32}}, color={255,0,0}));
  connect(realExpression.y, variableDisplacementPump.dispFraction) annotation (Line(
        points={{-37,-28},{-18,-28},{-18,-8},{-8.4,-8}}, color={0,0,127}));
  connect(highPressure.port, variableDisplacementPump.portP)
                                                        annotation (Line(
        points={{-1.22465e-015,32},{-1.22465e-015,22},{0,22},{0,10}}, color={
          255,0,0}));
  connect(variableDisplacementPump1.portT, lowPressure1.port)
    annotation (Line(points={{30,-10},{30,-32}}, color={255,0,0}));

  connect(highPressure1.port, variableDisplacementPump1.portP)
                                                        annotation (Line(
        points={{30,32},{30,10}}, color={255,0,0}));
  connect(realExpression.y, variableDisplacementPump1.dispFraction) annotation (Line(
        points={{-37,-28},{14,-28},{14,-8},{21.6,-8}}, color={0,0,127}));
  connect(constantSpeed.flange, variableDisplacementPump.flange_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,0,0}));
  connect(constantSpeed.flange, variableDisplacementPump1.flange_a) annotation (Line(
        points={{-40,0},{-20,0},{-20,16},{14,16},{14,0},{20,0}}, color={0,0,0}));
  annotation (
    experiment(StartTime=0.05, NumberOfIntervals=5000));
end PumpTest;
