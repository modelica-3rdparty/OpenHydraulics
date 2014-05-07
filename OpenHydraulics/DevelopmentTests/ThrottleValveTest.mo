within OpenHydraulics.DevelopmentTests;
model ThrottleValveTest
  extends OpenHydraulics.Interfaces.PartialFluidCircuit;

  Basic.OpenTank tank( p_const=1e6)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Basic.OpenTank tank1
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Basic.GenericPressureLoss restriction(
    D_a=0.1,
    D_b=0.1,
    Re_turbulent=3000,
    use_Re=true)    annotation (Placement(
        transformation(extent={{20,10},{40,30}})));
equation
  connect(restriction.port_b, tank1.port)
    annotation (Line(points={{40,20},{60,20},{60,-20}}, color={255,0,0}));
  connect(restriction.port_a, tank.port) annotation (Line(points={{20,20},{0,
          20},{0,-20}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=5));
end ThrottleValveTest;
