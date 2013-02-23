within OpenHydraulics.Circuits;
model PressureCompensatedLoadSensing
    extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Components.Valves.ReliefValve reliefValve
    annotation (Placement(transformation(
        origin={4,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  OpenHydraulics.Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    boreDiameter=0.12,
    strokeLength=1,
    closedLength=1.2,
    rodDiameter=0.03,
    pistonMass=.3,
    s_init=0.1,
    initType=Modelica.Mechanics.MultiBody.Types.Init.Position)
                annotation (Placement(transformation(extent={{44,30},{64,50}},
          rotation=0)));

  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{0,20},{20,40}}, rotation=0)));
  Modelica.Blocks.Sources.Sine sine(amplitude=1,
    startTime=1,
    phase=0,
    freqHz=.1)
    annotation (Placement(transformation(extent={{10,-82},{30,-62}}, rotation=
           0)));
  OpenHydraulics.Components.MotorsPumps.PCLSPump PCLSPump(Dmax=0.00004)
    annotation (Placement(transformation(extent={{-58,-32},{-38,-12}},
          rotation=0)));

  OpenHydraulics.Components.Volumes.CircuitTank circuitTank(V_max=2, V_init=1)
                                  annotation (Placement(transformation(extent=
           {{-6,-50},{-26,-30}}, rotation=0)));

  OpenHydraulics.Components.Valves.DirectionalValves.V4_3CCLSHydAntiCavitation
    valve4way3pos(
    portA(p(start=101325, fixed=true)),
    portB(p(start=101325, fixed=false)),
    portP(p(start=101325)),
    P2B(table=[-1,0.001; 0,0; 1,0]),
    P2A(table=[0,0; 1,.001]))
    annotation (Placement(transformation(
        origin={36,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(extent={{-6,-6},{14,14}}, rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{-6,-50},{14,-30}}, rotation=
           0)));

  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=150,
      useSupport=false)
    annotation (Placement(transformation(extent={{-84,-30},{-68,-14}},
          rotation=0)));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=1000)
    annotation (Placement(transformation(extent={{78,30},{98,50}}, rotation=0)));

equation
  connect(doubleActingCylinder.flange_a,fixed.flange)    annotation (Line(
        points={{44,40},{10,40},{10,30}}, color={0,127,0}));
  connect(valve4way3pos.portA, doubleActingCylinder.port_a)
                                                        annotation (Line(
        points={{44,-16},{46,-16},{46,32}}, color={255,0,0}));
  connect(valve4way3pos.portB, doubleActingCylinder.port_b)
                                                        annotation (Line(
        points={{44,-24},{62,-24},{62,32}}, color={255,0,0}));
  connect(valve4way3pos.control, sine.y)
                                     annotation (Line(points={{36,-31},{36,
          -72},{31,-72}}, color={0,0,127}));
  connect(reliefValve.port_a, j1.port[2]) annotation (Line(points={{4,-10},{4,
          -3.15625},{4,4},{4,4}}, color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{-6,-40},{
          4,-40},{4,-40.6667}}, color={255,0,0}));
  connect(reliefValve.port_b, j2.port[2]) annotation (Line(points={{4,-30},{4,
          -35.025},{4,-40},{4,-40}}, color={255,0,0}));
  connect(valve4way3pos.portT, j2.port[3])
                                       annotation (Line(points={{28,-24},{20,
          -24},{20,-40},{4,-40},{4,-39.3333}}, color={255,0,0}));
  connect(j1.port[3], valve4way3pos.portP)
                                       annotation (Line(points={{4,4.66667},{
          20,4.66667},{20,-16},{28,-16}}, color={255,0,0}));
  connect(PCLSPump.portP, j1.port[1]) annotation (Line(points={{-48,-12},{-48,
          4},{4,4},{4,3.33333}}, color={255,0,0}));
  connect(constantSpeed.flange, PCLSPump.flange_a)
    annotation (Line(points={{-68,-22},{-58,-22}}, color={0,0,0}));
  connect(slidingMass.flange_a, doubleActingCylinder.flange_b) annotation (Line(
        points={{78,40},{64,40}}, color={0,127,0}));
  connect(valve4way3pos.portLS, PCLSPump.portLS) annotation (Line(points={{44,
          -20},{54,-20},{54,-56},{-56,-56},{-56,-30}}, color={255,0,0}));
  connect(PCLSPump.portT, circuitTank.port_b) annotation (Line(points={{-48,
          -32},{-48,-40},{-26,-40}}, color={255,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=100),
    __Dymola_experimentSetupOutput);
end PressureCompensatedLoadSensing;
