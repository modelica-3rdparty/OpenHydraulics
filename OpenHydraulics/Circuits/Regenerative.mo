within OpenHydraulics.Circuits;
model Regenerative "Closed center regenerative circuit"

    extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=0.3,
    s_init=0.1,
    initType=Modelica.Mechanics.MultiBody.Types.Init.Position,
    q_nom=1e-4,
    strokeLength=0.5)
                annotation (Placement(transformation(extent={{44,30},{64,50}})));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=1000)
    annotation (Placement(transformation(extent={{70,30},{90,50}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=0.1,
    amplitude=1,
    startTime=0)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2, V_init=1)
                                  annotation (Placement(transformation(extent=
           {{-10,-50},{-30,-30}})));
  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(
        origin={0,-40},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=50,
      useSupport=false)
    annotation (Placement(transformation(extent={{-84,-26},{-68,-10}})));
  OpenHydraulics.Components.Valves.DirectionalValves.V4_3CCRegenerative RegenValve
    annotation (Placement(transformation(
        origin={30,-18},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  OpenHydraulics.Components.MotorsPumps.ConstantDisplacementPump constantDisplacementPump(Dconst=
        1e-5)
    annotation (Placement(transformation(extent={{-62,-28},{-42,-8}})));

equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{44,40},{10,40},{10,30}}, color={0,127,0}));
  connect(doubleActingCylinder.flange_b, slidingMass.flange_a)
    annotation (Line(points={{64,40},{70,40}}, color={0,127,0}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{
          1.83697e-015,-10},{1.83697e-015,0},{-5.55112e-017,0}}, color={255,0,
          0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{-10,-40},
          {0.666667,-40},{0.666667,-40}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{
          -1.83697e-015,-30},{-1.83697e-015,-36},{-5.55112e-017,-36},{
          -5.55112e-017,-40}}, color={255,0,0}));
  connect(RegenValve.portA, doubleActingCylinder.port_a)    annotation (Line(
        points={{38,-14},{46,-14},{46,32}}, color={255,0,0}));
  connect(RegenValve.portB, doubleActingCylinder.port_b)    annotation (Line(
        points={{38,-22},{62,-22},{62,32}}, color={255,0,0}));
  connect(RegenValve.portT, j2.port[3])    annotation (Line(points={{22,-22},
          {20,-22},{20,-40},{-0.666667,-40}}, color={255,0,0}));
  connect(RegenValve.portP, j1.port[3])    annotation (Line(points={{22,-14},
          {20,-14},{20,0},{-0.666667,0}}, color={255,0,0}));
  connect(constantSpeed.flange, constantDisplacementPump.flange_a)
    annotation (Line(points={{-68,-18},{-62,-18}}, color={0,0,0}));
  connect(constantDisplacementPump.portP, j1.port[1]) annotation (Line(points={{-52,-8},
          {-52,0},{0.666667,0}},          color={255,0,0}));
  connect(sine.y, RegenValve.control) annotation (Line(points={{21,-70},{30,
          -70},{30,-29}}, color={0,0,127}));
  connect(constantDisplacementPump.portT, circuitTank.port_b) annotation (Line(
        points={{-52,-28},{-52,-40},{-30,-40}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=100, Tolerance=1e-006));
end Regenerative;
