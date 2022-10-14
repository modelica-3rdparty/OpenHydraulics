within OpenHydraulics.DevelopmentTests;
model AccumulatorTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Volumes.Accumulator accumulator(p_precharge=100000)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  OpenHydraulics.Basic.OpenTank tank(p_const=1e5)
                                     annotation (Placement(transformation(
          extent={{-20,-40},{0,-20}})));
  OpenHydraulics.Basic.GenericPressureLoss restriction(
    D_b=0.01,
    Re_turbulent=2000,
    use_Re=true,
    D_a=0.01,
    zeta1=2,
    zeta2=2,
    zetaLaminarKnown=true,
    c0=0.1)
    annotation (Placement(transformation(
        origin={-10,-2},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(accumulator.port_a, restriction.port_b) annotation (Line(points={{
          -10,20},{-10,8}}, color={255,0,0}));
  connect(tank.port, restriction.port_a) annotation (Line(points={{-10,-20},{
          -10,-12}}, color={255,0,0}));

end AccumulatorTest;
