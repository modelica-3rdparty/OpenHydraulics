within OpenHydraulics.DevelopmentTests;
model LossyPumpTestSimple

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  Basic.FluidPower2MechRotConst idealPump
                       annotation (Placement(transformation(
        origin={-20,0},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Components.MotorsPumps.PCLSPump idealPump1
                               annotation (Placement(transformation(
        origin={20,0},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=0.01,
    amplitude=3e5,
    offset=4e5)
            annotation (Placement(transformation(extent={{80,-40},{60,-20}},
          rotation=0)));
  Basic.OpenTank tank      annotation (Placement(transformation(extent={{-10,-64},
            {10,-44}}, rotation=0)));
  Basic.OpenTank tank1(  p_const=300000)
                                   annotation (Placement(transformation(
          extent={{-10,28},{10,48}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
                                                            w_fixed=
        6.283185307, useSupport=false)
                     annotation (Placement(transformation(extent={{-60,-10},{
            -40,10}}, rotation=0)));
  OpenHydraulics.Components.Sensors.PressureSensor pressureSensor
    annotation (Placement(transformation(extent={{30,60},{50,80}}, rotation=0)));
  Components.Lines.NJunction j1(            n_ports=4)
    annotation (Placement(transformation(extent={{-10,50},{10,70}}, rotation=
            0)));
  Components.Lines.NJunction j2(            n_ports=3)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}},
          rotation=0)));
  OpenHydraulics.Basic.VarPressureSource varPressureSource
    annotation (Placement(transformation(extent={{50,-40},{30,-20}}, rotation=
           0)));
  Components.Volumes.Accumulator accumulator
        annotation (Placement(transformation(
          extent={{10,20},{30,40}}, rotation=0)));
equation
  connect(idealPump.flange_b, idealPump1.flange_a)
                                                 annotation (Line(points={{-10,
          -1.22465e-015},{0,-3.64618e-021},{0,1.22465e-015},{10,1.22465e-015}},
                          color={0,0,0}));
  connect(constantSpeed.flange, idealPump.flange_a) annotation (Line(points={{-40,0},
          {-35,0},{-35,1.22465e-015},{-30,1.22465e-015}},         color={0,0,
          0}));
  connect(idealPump.port_b, j1.port[1]) annotation (Line(points={{-20,10},{
          -20,60},{0,60},{0,59.25}}, color={255,0,0}));
  connect(tank1.port, j1.port[2])
    annotation (Line(points={{0,48},{0,59.75}}, color={255,0,0}));
  connect(pressureSensor.port_a, j1.port[4]) annotation (Line(points={{40,60},
          {0,60},{0,60.75}}, color={255,0,0}));
  connect(tank.port, j2.port[2])
    annotation (Line(points={{0,-44},{0,-30}}, color={255,0,0}));
  connect(idealPump.port_a, j2.port[1]) annotation (Line(points={{-20,-10},{
          -20,-30},{0,-30},{0,-30.6667}}, color={255,0,0}));
  connect(idealPump1.portT, j2.port[3]) annotation (Line(points={{20,-10},{20,
          -29.3333},{0,-29.3333}}, color={255,0,0}));
  connect(sine.y, varPressureSource.control) annotation (Line(points={{59,-30},
          {50,-30}}, color={0,0,127}));
  connect(varPressureSource.port, idealPump1.portLS) annotation (Line(points={{40,-20},
          {12,-20},{12,-8}},           color={255,0,0}));
  connect(accumulator.port_a, idealPump1.portP)
    annotation (Line(points={{20,20},{20,10}}, color={255,0,0}));
annotation ( Diagram(graphics),
    experiment(StopTime=1000),
    experimentSetupOutput);
end LossyPumpTestSimple;
