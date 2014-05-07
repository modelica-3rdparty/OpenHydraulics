within OpenHydraulics.DevelopmentTests;
model RestrictionTestSimple

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.ConstPressureSource source(p_const=1e5)     annotation (Placement(transformation(extent={{
            10,-40},{-10,-20}})));
  OpenHydraulics.Basic.VarPressureSource source1   annotation (Placement(transformation(
        origin={0,50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5e7,
    offset=1e5,
    duration=900)
                annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Basic.LaminarRestriction laminarRestriction(L=3) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,10})));
equation
  connect(ramp.y, source1.control) annotation (Line(points={{-39,50},{-39,50},
          {-18,50},{-10,50}},
        color={0,0,127}));
  connect(source1.port, laminarRestriction.port_b) annotation (Line(
      points={{-1.22465e-015,40},{6.12323e-016,40},{6.12323e-016,20}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(laminarRestriction.port_a, source.port) annotation (Line(
      points={{-6.12323e-016,0},{0,0},{0,-20}},
      color={255,0,0},
      smooth=Smooth.None));
  annotation (
      Diagram(graphics),
    experiment(StopTime=1000));
end RestrictionTestSimple;
