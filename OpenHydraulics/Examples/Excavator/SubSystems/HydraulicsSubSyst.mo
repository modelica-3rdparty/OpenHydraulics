within OpenHydraulics.Examples.Excavator.SubSystems;
model HydraulicsSubSyst
  extends OpenHydraulics.Interfaces.PartialFluidCircuit;

  //parameter SI.
  parameter Modelica.Units.SI.Length boom_s_init=1.19 "Initial position of boom cylinder" annotation (Dialog(tab="Initialization", group="Actuator Positions"));
  parameter Modelica.Units.SI.Length arm_s_init=0.71 "Initial position of arm cylinder" annotation (Dialog(tab="Initialization", group="Actuator Positions"));
  parameter Modelica.Units.SI.Length bucket_s_init=0.77 "Initial position of bucket cylinder" annotation (Dialog(tab="Initialization", group="Actuator Positions"));

  // the main components
  OpenHydraulics.Components.Cylinders.DoubleActingCylinder boomCylRight(
    closedLength=2.48,
    boreDiameter=0.135,
    rodDiameter=0.05,
    pistonMass=10,
    s_init=boom_s_init,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration,
    fixRodPressure=true,
    strokeLength=1.25) annotation (Placement(transformation(extent={{-38,50},{-18,70}})));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder boomCylLeft(
    strokeLength=1.25,
    closedLength=2.48,
    boreDiameter=0.135,
    rodDiameter=0.05,
    pistonMass=10,
    s_init=boom_s_init)
    annotation (Placement(transformation(
        origin={-80,54},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder armCyl(
    strokeLength=1.64,
    closedLength=2.26,
    boreDiameter=0.145,
    rodDiameter=0.05,
    pistonMass=10,
    s_init=arm_s_init,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration,
    fixHeadPressure=true) annotation (Placement(transformation(extent={{16,50},{36,70}})));

  OpenHydraulics.Components.Cylinders.DoubleActingCylinder bucketCyl(
    closedLength=2.30,
    boreDiameter=0.095,
    rodDiameter=0.05,
    s_init=bucket_s_init,
    pistonMass=5,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration,
    fixRodPressure=true,
    strokeLength=0.9) annotation (Placement(transformation(extent={{56,50},{76,70}})));

 OpenHydraulics.Components.MotorsPumps.Motor swingMotor(Dconst=0.3)
    annotation (Placement(transformation(
        origin={-68,84},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  // the valves
 OpenHydraulics.Examples.Excavator.SubSystems.LSValveUnit bucketValve(
    sizeOfInputs=4,
    inputIndex=4,
    q_nom=0.003)
    annotation (Placement(transformation(extent={{52,-40},{82,-10}})));

 OpenHydraulics.Examples.Excavator.SubSystems.LSValveUnit armValve(
    sizeOfInputs=4,
    inputIndex=3,
    q_nom=0.01)
    annotation (Placement(transformation(extent={{10,-40},{40,-10}})));

 OpenHydraulics.Examples.Excavator.SubSystems.LSValveUnit boomValve(
    sizeOfInputs=4,
    inputIndex=2,
    q_nom=0.01,
    q_fraction_A2T=0.4)
    annotation (Placement(transformation(extent={{-38,-40},{-8,-10}})));

 OpenHydraulics.Examples.Excavator.SubSystems.LSValveUnit swingValve(
    sizeOfInputs=4,
    q_nom=0.01,
    q_fraction_A2T=0.6,
    q_fraction_B2T=0.6)
    annotation (Placement(transformation(extent={{-80,-40},{-50,-10}})));

  // the LoadSensing pump and control circuitry
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(
      w_fixed=150,
      useSupport=false)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  OpenHydraulics.Examples.Excavator.SubSystems.PowerUnit powerUnit
    annotation (Placement(transformation(extent={{-16,-96},{16,-64}})));

  // the lines and junctions
  OpenHydraulics.Components.Lines.NJunction jB
    annotation (Placement(transformation(extent={{-24,28},{-4,48}})));

  OpenHydraulics.Components.Lines.NJunction jA
    annotation (Placement(transformation(extent={{-40,36},{-20,56}})));

  OpenHydraulics.Components.Lines.Line boomLineB(
    L=1,
    D=0.05,
    lineBulkMod=1e7)
    annotation (Placement(transformation(
        origin={-14,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line boomLineA(
    L=1,
    D=0.05,
    lineBulkMod=1e7)
    annotation (Placement(transformation(
        origin={-30,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line bucketLineB(
    L=1,
    D=0.05,
    lineBulkMod=1e7)
    annotation (Placement(transformation(
        origin={74,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line bucketLineA(
    L=1,
    D=0.05,
    lineBulkMod=1e7)
    annotation (Placement(transformation(
        origin={60,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line armLineA(
    L=1,
    D=0.05,
    lineBulkMod=1e7)
    annotation (Placement(transformation(
        origin={18,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line armLineB(
    L=1,
    D=0.05,
    lineBulkMod=1e7)
    annotation (Placement(transformation(
        origin={34,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line swingLineA(
    L=2,
    D=0.03,
    lineBulkMod=1e8)
    annotation (Placement(transformation(
        origin={-72,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  OpenHydraulics.Components.Lines.Line swingLineB(
    L=2,
    D=0.03,
    lineBulkMod=1e8)
    annotation (Placement(transformation(
        origin={-56,22},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  Basic.OpenTank openTank
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));

  // the connectors
  Modelica.Mechanics.Rotational.Interfaces.Flange_b SwingFlange
    annotation (Placement(transformation(extent={{-94,90},{-74,110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a BoomCylBaseR
    annotation (Placement(transformation(extent={{-54,90},{-34,110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b BoomCylRodR
    annotation (Placement(transformation(extent={{-34,90},{-14,110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a BoomCylBaseL
    annotation (Placement(transformation(extent={{-110,34},{-90,54}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b BoomCylRodL
    annotation (Placement(transformation(extent={{-110,54},{-90,74}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a ArmCylBase
    annotation (Placement(transformation(extent={{-6,90},{14,110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b ArmCylRod
    annotation (Placement(transformation(extent={{14,90},{34,110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a BucketCylBase
    annotation (Placement(transformation(extent={{46,90},{66,110}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b BucketCylRod
    annotation (Placement(transformation(extent={{66,90},{86,110}})));
  Modelica.Blocks.Interfaces.RealInput Command[4]
    annotation (Placement(transformation(
        origin={109,0},
        extent={{-15,-16},{15,16}},
        rotation=180)));

  OpenHydraulics.Components.Lines.Line pumpLine(
    D=0.05,
    L=2,
    lineBulkMod=1e8)
    annotation (Placement(transformation(
        origin={-50,-54},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  OpenHydraulics.Components.Lines.Line tankLine(
    D=0.05,
    L=2,
    lineBulkMod=1e8)
    annotation (Placement(transformation(
        origin={-20,-48},
        extent={{-10,-10},{10,10}},
        rotation=180)));

equation
  connect(boomCylRight.flange_a, BoomCylBaseR)
                                             annotation (Line(points={{
          -38,60},{-38,80},{-44,80},{-44,100}}, color={0,127,0}));
  connect(boomCylRight.flange_b, BoomCylRodR)
                                          annotation (Line(points={{-18,
          60},{-18,80},{-24,80},{-24,100}}, color={0,127,0}));
  connect(boomCylLeft.flange_a, BoomCylBaseL) annotation (Line(points={{
          -80,44},{-100,44}}, color={0,127,0}));
  connect(boomCylLeft.flange_b, BoomCylRodL)
                                           annotation (Line(points={{-80,
          64},{-100,64}}, color={0,127,0}));
  connect(armCyl.flange_a, ArmCylBase)        annotation (Line(points={{
          16,60},{16,80},{4,80},{4,100}}, color={0,127,0}));
  connect(armCyl.flange_b, ArmCylRod)      annotation (Line(points={{36,
          60},{36,80},{24,80},{24,100}}, color={0,127,0}));
  connect(bucketCyl.flange_a, BucketCylBase)  annotation (Line(points={{
          56,60},{56,100}}, color={0,127,0}));
  connect(bucketCyl.flange_b, BucketCylRod)
                                           annotation (Line(points={{76,
          60},{76,100}}, color={0,127,0}));
  connect(swingMotor.flange_b, SwingFlange)
                                        annotation (Line(points={{-77.8,
          84},{-84,84},{-84,100}}, color={0,0,0}));
  connect(swingValve.portLS1, boomValve.portLS2) annotation (Line(
      points={{-50,-22},{-38,-22}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(boomValve.portLS1, armValve.portLS2)
    annotation (Line(
      points={{-8,-22},{10,-22}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(armValve.portLS1, bucketValve.portLS2)
    annotation (Line(
      points={{40,-22},{52,-22}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(swingValve.portP1, boomValve.portP2) annotation (Line(points={{
          -50,-31},{-38,-31}}, color={255,0,0}));
  connect(swingValve.portT1, boomValve.portT2) annotation (Line(points={{
          -50,-37},{-38,-37}}, color={255,0,0}));
  connect(boomValve.portP1, armValve.portP2) annotation (Line(points={{-8,
          -31},{10,-31}}, color={255,0,0}));
  connect(boomValve.portT1, armValve.portT2) annotation (Line(points={{-8,
          -37},{10,-37}}, color={255,0,0}));
  connect(armValve.portP1, bucketValve.portP2) annotation (Line(points={{
          40,-31},{52,-31}}, color={255,0,0}));
  connect(armValve.portT1, bucketValve.portT2) annotation (Line(points={{
          40,-37},{52,-37}}, color={255,0,0}));
  connect(constantSpeed.flange, powerUnit.flange_a) annotation (Line(
        points={{-30,-80},{-16,-80}}, color={0,0,0}));
  connect(powerUnit.portLS, swingValve.portLS2) annotation (Line(
      points={{-9.6,-64},{-10,-62},{-10,-60},{-94,-60},{-94,-22},{-80,-22}},
      color={255,0,0},
      pattern=LinePattern.Dash));

  connect(jA.port[2], boomCylRight.port_a) annotation (Line(points={{-30,
          46},{-30,52},{-36,52}}, color={255,0,0}));
  connect(jA.port[3], boomCylLeft.port_a) annotation (Line(points={{-30,
          46.6667},{-30,46},{-72,46}}, color={255,0,0}));
  connect(jB.port[2], boomCylRight.port_b) annotation (Line(points={{-14,
          38},{-14,52},{-20,52}}, color={255,0,0}));
  connect(jB.port[3], boomCylLeft.port_b) annotation (Line(points={{-14,
          38.6667},{-14,38},{-46,38},{-46,62},{-72,62}}, color={255,0,0}));
  connect(boomValve.portB, boomLineB.port_a)
                                         annotation (Line(points={{-15.2,
          -10},{-14,-10},{-14,12}}, color={255,0,0}));
  connect(boomValve.portA, boomLineA.port_a)
                                         annotation (Line(points={{-30.8,
          -10},{-30,-10},{-30,12}}, color={255,0,0}));
  connect(boomLineA.port_b, jA.port[1])
                                    annotation (Line(points={{-30,32},{
          -30,45.3333}}, color={255,0,0}));
  connect(boomLineB.port_b, jB.port[1])
                                    annotation (Line(points={{-14,32},{
          -14,37.3333}}, color={255,0,0}));
  connect(bucketValve.portA, bucketLineA.port_a)
                                           annotation (Line(points={{59.2,
          -10},{60,-10},{60,12}}, color={255,0,0}));
  connect(bucketValve.portB, bucketLineB.port_a)
                                           annotation (Line(points={{74.8,
          -10},{74,-10},{74,12}}, color={255,0,0}));
  connect(bucketLineA.port_b, bucketCyl.port_a)
                                          annotation (Line(points={{60,32},
          {58,32},{58,52}}, color={255,0,0}));
  connect(bucketLineB.port_b, bucketCyl.port_b)
    annotation (Line(points={{74,32},{74,52}}, color={255,0,0}));
  connect(armValve.portA, armLineA.port_a)
                                        annotation (Line(points={{17.2,
          -10},{18,-10},{18,12}}, color={255,0,0}));
  connect(armValve.portB, armLineB.port_a)
                                        annotation (Line(points={{32.8,
          -10},{34,-10},{34,12}}, color={255,0,0}));
  connect(armLineB.port_b, armCyl.port_b)
    annotation (Line(points={{34,32},{34,52}}, color={255,0,0}));
  connect(armLineA.port_b, armCyl.port_a)
    annotation (Line(points={{18,32},{18,52}}, color={255,0,0}));
  connect(swingValve.portA, swingLineA.port_a)
                                          annotation (Line(points={{-72.8,
          -10},{-72,-10},{-72,12}}, color={255,0,0}));
  connect(swingValve.portB, swingLineB.port_a)
                                          annotation (Line(points={{-57.2,
          -10},{-56,-10},{-56,12}}, color={255,0,0}));
  connect(swingLineA.port_b, swingMotor.portB)
                                    annotation (Line(points={{-72,32},{
          -68,32},{-68,74}}, color={255,0,0}));
  connect(swingLineB.port_b, swingMotor.portA)
                                     annotation (Line(points={{-56,32},{
          -56,94},{-68,94}}, color={255,0,0}));
  connect(bucketValve.y, armValve.u) annotation (Line(points={{51.1,-14.5},
          {40.9,-14.5}}, color={0,0,127}));
  connect(armValve.y, boomValve.u) annotation (Line(points={{9.1,-14.5},{
          -7.1,-14.5}}, color={0,0,127}));
  connect(boomValve.y, swingValve.u) annotation (Line(points={{-38.9,
          -14.5},{-49.1,-14.5}}, color={0,0,127}));
  connect(Command, bucketValve.u) annotation (Line(points={{109,0},{90,0},
          {90,-14.5},{82.9,-14.5}}, color={0,0,127}));
  connect(bucketValve.portLS1, openTank.port) annotation (Line(
      points={{82,-22},{90,-22},{90,-40}},
      color={255,0,0},
      pattern=LinePattern.Dash));
  connect(powerUnit.portT, tankLine.port_a) annotation (Line(points={{9.6,
          -64},{10,-64},{10,-48},{-10,-48}}, color={255,0,0}));
  connect(tankLine.port_b, swingValve.portT2) annotation (Line(points={{
          -30,-48},{-84,-48},{-84,-37},{-80,-37}}, color={255,0,0}));
  connect(powerUnit.portP, pumpLine.port_a) annotation (Line(points={{0,
          -64},{0,-54},{-40,-54}}, color={255,0,0}));
  connect(pumpLine.port_b, swingValve.portP2) annotation (Line(points={{
          -60,-54},{-90,-54},{-90,-31},{-80,-31}}, color={255,0,0}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,26},{100,-14}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end HydraulicsSubSyst;
