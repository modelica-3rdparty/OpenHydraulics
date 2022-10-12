within OpenHydraulics.DevelopmentTests;
model ShuttleValveTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit;

  Components.Valves.ShuttleValve shuttleValve(timeConstant=0.01)        annotation (Placement(
        transformation(extent={{-10,10},{10,30}})));
  Basic.ConstPressureSource tank2
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Basic.VarPressureSource tank1
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1e4,
    f=1,                                           offset=101325)
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  Basic.VarPressureSource tank3
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=1e4,
    f=1,
    offset=101325,
    startTime=0.5)
    annotation (Placement(transformation(extent={{70,-20},{50,0}})));
  OpenHydraulics.Basic.GenericPressureLoss genericPressureLoss(D_a=0.001,D_b=0.001)
    annotation (Placement(transformation(
        origin={0,-4},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(tank1.port, shuttleValve.PortA)
                                         annotation (Line(points={{-30,0},{
          -30,20},{-10,20}}, color={255,0,0}));
  connect(sine.y, tank1.control) annotation (Line(points={{-49,-10},{-40,-10}},
        color={0,0,127}));
  connect(tank3.port, shuttleValve.PortB)
                                         annotation (Line(points={{30,0},{30,
          20},{10,20}}, color={255,0,0}));
  connect(sine1.y, tank3.control)
    annotation (Line(points={{49,-10},{40,-10}}, color={0,0,127}));
  connect(genericPressureLoss.port_a, shuttleValve.PortC) annotation (Line(
        points={{1.83697e-015,6},{0,6},{0,12}}, color={255,0,0}));
  connect(genericPressureLoss.port_b, tank2.port) annotation (Line(points={{-1.83697e-015,
          -14},{0,-14},{0,-20}},               color={255,0,0}));
  annotation (
    experiment(StopTime=5));
end ShuttleValveTest;
