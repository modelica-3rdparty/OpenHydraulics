within OpenHydraulics.DevelopmentTests;
model DoubleActingCylinderTestSimple2

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-22,40},{-2,60}}, rotation=
            0)));
  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    initType=Modelica.Mechanics.MultiBody.Types.Init.Position,
    strokeLength=0.2,
    pistonMass=0.1,
    s_init=0.185,
    q_nom=1e-4)       annotation (Placement(transformation(extent={{22,40},{
            42,60}}, rotation=0)));
  OpenHydraulics.Basic.FluidPower2MechRotConst pump(Dconst=5e-5)
                                                         annotation (Placement(transformation(extent={{-24,-46},
            {-4,-26}}, rotation=0)));
  OpenHydraulics.Components.Volumes.CircuitTank circuitTank
    annotation (Placement(transformation(extent={{30,-90},{10,-70}}, rotation=
           0)));
  Modelica.Blocks.Sources.Ramp ramp(height=1000, duration=100)
    annotation (Placement(transformation(extent={{-74,-46},{-54,-26}},
          rotation=0)));
  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(
        origin={10,-46},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Sources.Position position(
                                                  f_crit=1, useSupport=false)
    annotation (Placement(transformation(extent={{-46,-46},{-26,-26}},
          rotation=0)));
  Components.Lines.NJunction j1(n_ports=3)  annotation (Placement(
        transformation(extent={{0,-26},{20,-6}}, rotation=0)));
  Components.Lines.NJunction j2(n_ports=3)
    annotation (Placement(transformation(extent={{30,-66},{50,-46}}, rotation=
           0)));
initial equation
  //reliefValve.port_a.p = 101325;

equation
  connect(fixed.flange,   doubleActingCylinder.flange_a)
    annotation (Line(points={{-12,50},{22,50}}, color={0,127,0}));
  connect(pump.port_a,circuitTank. port_b) annotation (Line(points={{-14,-46},
          {-14,-80},{10,-80}}, color={255,0,0}));
  connect(ramp.y, position.phi_ref)
    annotation (Line(points={{-53,-36},{-48,-36}}, color={0,0,127}));
  connect(position.flange,   pump.flange_a)
    annotation (Line(points={{-26,-36},{-24,-36}}, color={0,0,0}));
  connect(pump.port_b, j1.port[1]) annotation (Line(points={{-14,-26},{-14,
          -16},{10,-16},{10,-16.6667}}, color={255,0,0}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{10,-36},{
          10,-26.025},{10,-16},{10,-16}}, color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{30,-80},{
          40,-80},{40,-56.6667}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2])
    annotation (Line(points={{10,-56},{25,-56},{25,-56},{40,-56}}, color={255,
          0,0}));
  connect(doubleActingCylinder.port_b, j2.port[3]) annotation (Line(points={{40,42},
          {40,-55.3333}},        color={255,0,0}));
  connect(doubleActingCylinder.port_a, j1.port[3]) annotation (Line(points={{24,42},
          {24,-16},{10,-16},{10,-15.3333}},        color={255,0,0}));
annotation ( Diagram(graphics),
    experiment(StopTime=10, Tolerance=1e-008),
    experimentSetupOutput);
end DoubleActingCylinderTestSimple2;
