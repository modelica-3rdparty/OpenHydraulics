within OpenHydraulics.DevelopmentTests;
model ThrottleValveTest2

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.VariableRestriction throttleValve(table=[0.0,0.0; 1,0.001],
      D_nom=0.05)
            annotation (Placement(transformation(extent={{6,30},{26,10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=0.5,
    f=1,                                           offset=0.5)
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  Components.Volumes.Tank
                 tank(                      p_const=1e6)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Components.Volumes.Tank
                 tank1
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Basic.GenericPressureLoss restriction(
    D_a=0.1,
    D_b=0.1,
    Re_turbulent=3000,
    use_Re=true)
         annotation (Placement(
        transformation(extent={{40,10},{60,30}})));
equation
  connect(sine.y, throttleValve.control) annotation (Line(points={{3,50},{16,
          50},{16,28}}, color={0,0,127}));
  connect(tank.port, throttleValve.port_a) annotation (Line(points={{0,-20},{
          0,20},{6,20}}, color={255,0,0}));
  connect(throttleValve.port_b, restriction.port_a)
    annotation (Line(points={{26,20},{40,20}}, color={255,0,0}));
  connect(restriction.port_b, tank1.port)
    annotation (Line(points={{60,20},{60,-20}}, color={255,0,0}));
  annotation (
    experiment(StopTime=5));
end ThrottleValveTest2;
