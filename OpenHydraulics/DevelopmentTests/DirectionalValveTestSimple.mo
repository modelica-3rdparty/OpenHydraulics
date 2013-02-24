within OpenHydraulics.DevelopmentTests;
model DirectionalValveTestSimple

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(
        origin={-30,-16},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  OpenHydraulics.Basic.OpenTank tank          annotation (Placement(transformation(extent={{-70,-60},
            {-50,-40}}, rotation=0)));
  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration)
                annotation (Placement(transformation(extent={{20,42},{40,62}},
          rotation=0)));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-10,32},{10,52}}, rotation=
            0)));
  Modelica.Mechanics.Translational.Components.Mass slidingMass
    annotation (Placement(transformation(extent={{60,42},{80,62}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine(amplitude=0.1)
    annotation (Placement(transformation(extent={{-34,-80},{-14,-60}},
          rotation=0)));
  OpenHydraulics.Basic.VariableRestriction throttleValve(D_nom=0.01)
    annotation (Placement(transformation(extent={{-8,0},{12,20}}, rotation=0)));
  OpenHydraulics.Basic.ConstVolumeSource source(q=0.001)
    annotation (Placement(transformation(extent={{-70,-20},{-50,0}}, rotation=
           0)));
  Components.Lines.NJunction j1(            n_ports=3)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=
            0)));
  Components.Lines.NJunction j2(            n_ports=3)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}},
          rotation=0)));
equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{20,52},{0,52},{0,42}}, color={0,127,0}));
  connect(doubleActingCylinder.flange_b, slidingMass.flange_a)
    annotation (Line(points={{40,52},{60,52}}, color={0,127,0}));
  connect(throttleValve.port_b, doubleActingCylinder.port_a) annotation (Line(
        points={{12,10},{22,10},{22,44}}, color={255,0,0}));
  connect(throttleValve.control, sine.y) annotation (Line(points={{2,2},{2,
          -70},{-13,-70}}, color={0,0,127}));
  connect(reliefValve.port_a, j1.port[1]) annotation (Line(points={{-30,-6},{
          -30,1.625},{-30,9.33333},{-30,9.33333}}, color={255,0,0}));
  connect(source.port, j1.port[2]) annotation (Line(points={{-60,0},{-60,10},
          {-30,10}}, color={255,0,0}));
  connect(throttleValve.port_a, j1.port[3]) annotation (Line(points={{-8,10},
          {-30,10},{-30,10.6667}}, color={255,0,0}));
  connect(tank.port, j2.port[1]) annotation (Line(points={{-60,-40},{-30,-40},
          {-30,-40.6667}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{-30,-26},
          {-30,-33.025},{-30,-40},{-30,-40}}, color={255,0,0}));
  connect(doubleActingCylinder.port_b, j2.port[3]) annotation (Line(points={{38,44},
          {38,-40},{-30,-40},{-30,-39.3333}},        color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=0.5),
    experimentSetupOutput);
end DirectionalValveTestSimple;
