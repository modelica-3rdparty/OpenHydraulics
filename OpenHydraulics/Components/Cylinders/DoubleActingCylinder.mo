within OpenHydraulics.Components.Cylinders;
model DoubleActingCylinder
  import Modelica.Constants.pi;

  // the parameters
  parameter SI.Length boreDiameter = 0.05 "Bore diameter"
    annotation (Dialog(tab="Sizing",group="Dimensions"));
  parameter SI.Length rodDiameter = 0.01 "Rod diameter"
    annotation (Dialog(tab="Sizing",group="Dimensions"));
  parameter SI.Length strokeLength = 0.1 "Stroke length of the cylinder"
    annotation (Dialog(tab="Sizing",group="Dimensions"));
  parameter SI.Length closedLength = 0.3
    "Total length of cylinder fully retracted"
    annotation (Dialog(tab="Sizing",group="Dimensions"));
  parameter SI.VolumeFlowRate q_nom = 0.01 "Nominal flow rate for in/outlet"
    annotation (Dialog(tab="Sizing",group="Hydraulics"));
  parameter SI.Pressure dp_nom = 1e4 "Nominal pressure drop for q_nom"
    annotation (Dialog(tab="Sizing",group="Hydraulics"));
  parameter SI.AbsolutePressure maxPressure = 3e7 "Maximum rated pressure"
    annotation (Dialog(tab="Sizing",group="Hydraulics"));

  // dynamics parameters
  parameter SI.Mass pistonMass = 0 "Mass of the piston and rod"
    annotation (Dialog(tab="Dynamics"));
  parameter Real damping( final unit="N/ (m/s)",
    final min=0) = 1e4 "damping between piston and cylinder [N/ (m/s)]"
    annotation (Dialog(tab="Dynamics"));

  parameter SI.Distance endOfTravelDistance = 0.01
    "Maximum distance beyond the end of travel point"
    annotation (Dialog(tab="Dynamics",group="End-of-travel"));
  parameter Real stopStiffness(
    final unit="N/m",
    final min=0) = 1e9 "stiffness at impact"
    annotation(Dialog(tab="Dynamics",group="End-of-travel"));
  parameter Real stopDamping(
    final unit="N.s/m",
    final min=-1000) = 1e12 "damping at impact"
    annotation(Dialog(tab="Dynamics",group="End-of-travel"));

  // cushion parameters
  parameter Boolean useCushionHead = true
    "false = constant restriction with q_nom & dp_nom"
    annotation(Evaluate=true, Dialog(tab="Cushions",group="Head Cushion"));
  parameter Real cushionTableHead[:, :]=[0,0.001;0.001,0.001;0.029,0.01;0.03,1]
    "Cushion flow rate (1st col = s_rel; 2nd col = fraction of q_nom)"
    annotation(Dialog(tab="Cushions",group="Head Cushion",enable=useCushionHead));
  parameter Modelica.Blocks.Types.Smoothness smoothnessHead=
    Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation"
    annotation(Dialog(tab="Cushions",group="Head Cushion",enable=useCushionHead));
  parameter Boolean useCushionRod = true
    "false = constant restriction with q_nom & dp_nom"
    annotation(Evaluate=true, Dialog(tab="Cushions",group="Rod Cushion"));
  parameter Real cushionTableRod[:, :]=[0,0.001;0.001,0.001;0.029,0.01;0.03,1]
    "Cushion flow rate (1st col = s_rel; 2nd col = fraction of q_nom)"
    annotation(Dialog(tab="Cushions",group="Rod Cushion",enable=useCushionRod));
  parameter Modelica.Blocks.Types.Smoothness smoothnessRod=
    Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation"
    annotation(Dialog(tab="Cushions",group="Rod Cushion",enable=useCushionRod));

  // sealing parameters
  parameter SI.Length L_A2B = 0.01 "Length of seal between chambers A and B"
    annotation (Dialog(tab="Seals",group="Piston"));
  parameter SI.Diameter D_A2B = 1e-5
    "Hydraulic diameter of seal between chambers A and B"
    annotation (Dialog(tab="Seals",group="Piston"));
  parameter SI.Length L_A2Env = 0.01
    "Length of seal between chamber A and Environment"
    annotation (Dialog(tab="Seals",group="Piston"));
  parameter SI.Diameter D_A2Env = 0
    "Hydraulic diameter of seal between chamber A and Environment"
    annotation (Dialog(tab="Seals",group="Piston"));
  parameter SI.Length L_B2Env = 0.01
    "Length of seal between chamber B and Environment"
    annotation (Dialog(tab="Seals",group="Piston"));
  parameter SI.Diameter D_B2Env = 0
    "Hydraulic diameter of seal between chamber B and Environment"
    annotation (Dialog(tab="Seals",group="Piston"));

  // initialization parameters
  parameter ObsoleteModelica4.Mechanics.MultiBody.Types.Init initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.Free "Type of initialization (defines usage of start values below)" annotation (Dialog(tab="Initialization", group="Mechanical"));
  parameter SI.Distance s_init = 0 "Initial position >0 and <stroke"
    annotation (Dialog(tab="Initialization",group="Mechanical"));
  parameter SI.Velocity v_init = 0 "Initial velocity"
    annotation (Dialog(tab="Initialization",group="Mechanical"));
  parameter SI.Acceleration a_init = 0 "Initial acceleration"
    annotation (Dialog(tab="Initialization",group="Mechanical"));
  parameter Boolean fixHeadPressure = false
    "Initialize the pressure at the head side"
    annotation (Dialog(tab="Initialization",group="Fluid"));
  parameter Boolean fixRodPressure = false
    "Initialize the pressure at the rod side"
    annotation (Dialog(tab="Initialization",group="Fluid"));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{90,-90},{70,-70}})));

  // the components
  Basic.FluidPower2MechTrans cylinderChamberHead(
    A = pi/4*boreDiameter^2,
    stopStiffness = stopStiffness,
    stopDamping = stopDamping,
    n_ports=3,
    p_init=p_init,
    maxPressure=maxPressure*10)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));

  Basic.FluidPower2MechTrans cylinderChamberRod(
    A=pi/4*(boreDiameter^2 - rodDiameter^2),
    stopStiffness = stopStiffness,
    stopDamping = stopDamping,
    n_ports=3,
    p_init=p_init,
    maxPressure=maxPressure*10)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  BaseClasses.CylinderCushion cushionHead(
    cushionTable=if useCushionHead then cushionTableHead else [0,0.001;strokeLength/1000,1;1,1],
    smoothness=smoothnessHead,
    q_nom=q_nom,
    dp_nom=dp_nom,
    dp_relief=maxPressure*0.9)
    annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  BaseClasses.CylinderCushion cushionRod(
    cushionTable=if useCushionRod then cushionTableRod else [0,0.001;strokeLength/1000,1;1,1],
    smoothness=smoothnessHead,
    q_nom=q_nom,
    dp_nom=dp_nom,
    dp_relief=maxPressure*0.9)
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  Basic.LaminarRestriction leakage_Head2Rod(
    L=L_A2B,
    D=D_A2B)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Mechanics.Translational.Components.Mass piston(
                                                      m=pistonMass)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.Translational.Components.Rod cylinder(
                                                L=strokeLength)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Mechanics.Translational.Components.Rod rod(
                                           L=closedLength)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
    "(left) driving flange (flange axis directed INTO cut plane, e. g. from left to right)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flange_b
    "(right) driven flange (flange axis directed OUT OF cut plane, i. e. from right to left)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.Translational.Components.Damper damper(
                                                 d=damping)
    annotation (Placement(transformation(extent={{-48,58},{-28,78}})));
  Basic.ConstPressureSource envSinkA
    annotation (Placement(transformation(
        origin={-90,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.ConstPressureSource envSinkB
    annotation (Placement(transformation(
        origin={90,-20},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Basic.LaminarRestriction leakage_Head2Env(
    L=L_A2Env,
    D=D_A2Env)
    annotation (Placement(transformation(extent={{-74,-30},{-54,-10}})));
  Basic.LaminarRestriction leakage_Rod2Env(
    L=L_B2Env,
    D=D_B2Env)
    annotation (Placement(transformation(
        origin={64,-20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Lines.NJunction jA(
    n_ports=2)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Lines.NJunction jB(
    n_ports=2)
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

protected
  outer OpenHydraulics.Circuits.Environment environment;

initial equation
  assert(cylinderChamberHead.s_rel>=0,"Initial position is smaller than zero");
  assert(cylinderChamberRod.s_rel>=0,"Initial position is larger than strokeLength");

  // state initialization
  if initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.Position then
    cylinderChamberHead.s_rel = s_init;
  elseif initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.Velocity then
    cylinderChamberHead.v_rel = v_init;
  elseif initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocity then
    cylinderChamberHead.s_rel = s_init;
    cylinderChamberHead.v_rel = v_init;
  elseif initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.VelocityAcceleration then
    cylinderChamberHead.v_rel = v_init;
    piston.a = a_init;
  elseif initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.SteadyState then
    cylinderChamberHead.v_rel = 0;
    piston.a = a_init;
  elseif initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocityAcceleration then
    cylinderChamberHead.s_rel = s_init;
    cylinderChamberHead.v_rel = v_init;
    piston.a = a_init;
  elseif initType == ObsoleteModelica4.Mechanics.MultiBody.Types.Init.Free then
    // nothing
  else
    assert(true,"Invalid initialization type in FluidPower2MechTrans");
  end if;

  if fixHeadPressure then
    cylinderChamberHead.p_vol = p_init;
  end if;
  if fixRodPressure then
    cylinderChamberRod.p_vol = p_init;
  end if;

equation
  when cushionRod.reliefValve.valvePositionSteadyState>0 then
    Modelica.Utilities.Streams.print("\nWARNING: Cylinder exceeds maximum pressure at the rod end.");
    Modelica.Utilities.Streams.print("         This could just be due to end-of-travel behavior.");
    Modelica.Utilities.Streams.print("         (time = "+String(time)+")");
  end when;
  when cushionHead.reliefValve.valvePositionSteadyState>0 then
    Modelica.Utilities.Streams.print("\nWARNING: Cylinder exceeds maximum pressure at the head end.");
    Modelica.Utilities.Streams.print("         This could just be due to end-of-travel behavior.");
    Modelica.Utilities.Streams.print("         (time = "+String(time)+")");
  end when;

  connect(cylinderChamberHead.flange_b, piston.flange_a)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,127,0}));
  connect(rod.flange_a, piston.flange_b)
    annotation (Line(points={{70,0},{70,20},{62,20},{62,22},{58,22},{58,20},
          {14,20},{14,0},{10,0}}, color={0,127,0}));
  connect(piston.flange_b, cylinderChamberRod.flange_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,127,0}));
  connect(cylinder.flange_b, cylinderChamberRod.flange_b)
    annotation (Line(points={{10,80},{60,80},{60,0},{50,0}}, color={0,127,0}));
  connect(cylinderChamberHead.flange_a, cylinder.flange_a)
    annotation (Line(points={{-50,0},{-60,0},{-60,80},{-10,80}}, color={0,
          127,0}));
  connect(cylinderChamberHead.flange_a, flange_a)
    annotation (Line(points={{-50,0},{-100,0}}, color={0,127,0}));
  connect(rod.flange_b, flange_b)
    annotation (Line(points={{90,0},{100,0}}, color={0,127,0}));
  connect(flange_a, damper.flange_a)
    annotation (Line(points={{-100,0},{-80,0},{-80,68},{-62,68},{-62,70},{
          -58,70},{-58,68},{-48,68}}, color={0,127,0}));
  connect(damper.flange_b,cylinderChamberHead. flange_b)
    annotation (Line(points={{-28,68},{-14,68},{-14,0},{-30,0}}, color={0,
          127,0}));
  connect(envSinkA.port, leakage_Head2Env.port_a)
    annotation (Line(points={{-80,-20},{-78,-20},{-78,-20},{-74,-20}},
        color={255,0,0}));
  connect(envSinkB.port, leakage_Rod2Env.port_a)
    annotation (Line(points={{80,-20},{74,-20}}, color={255,0,0}));
  connect(port_a,jA. port[1]) annotation (Line(points={{-80,-80},{-40,-80},
          {-40,-80.5}}, color={255,0,0}));
  connect(port_b,jB. port[1]) annotation (Line(points={{80,-80},{40,-80},{
          40,-80.5}}, color={255,0,0}));

  connect(cylinderChamberHead.port[1], cushionHead.port_a) annotation (Line(
        points={{-40,-0.75},{-40,-40}}, color={255,0,0}));

  connect(cushionHead.port_b, jA.port[2]) annotation (Line(points={{-40,-60},
          {-40,-79.5}}, color={255,0,0}));
  connect(cylinderChamberHead.flange_a, cushionHead.flange_a) annotation (Line(
        points={{-50,0},{-50,-50}}, color={0,127,0}));
  connect(cylinderChamberHead.flange_b, cushionHead.flange_b) annotation (Line(
        points={{-30,0},{-30,-50}}, color={0,127,0}));
  connect(cylinderChamberRod.flange_a, cushionRod.flange_a) annotation (Line(
        points={{30,0},{30,-50}}, color={0,127,0}));
  connect(cylinderChamberRod.flange_b, cushionRod.flange_b) annotation (Line(
        points={{50,0},{50,-50}}, color={0,127,0}));
  connect(cushionRod.port_b, jB.port[2]) annotation (Line(points={{40,-60},
          {40,-79.5}}, color={255,0,0}));
  connect(cylinderChamberRod.port[1], cushionRod.port_a) annotation (Line(
        points={{40,-0.75},{40,-40}}, color={255,0,0}));
  connect(leakage_Head2Rod.port_b, cylinderChamberRod.port[2]) annotation (Line(
        points={{10,-20},{38,-20},{38,0},{40,0},{40,-0.05}}, color={255,0,0}));
  connect(leakage_Head2Rod.port_a, cylinderChamberHead.port[2]) annotation (Line(
        points={{-10,-20},{-38,-20},{-38,0},{-40,0},{-40,-0.05}}, color={
          255,0,0}));
  connect(leakage_Head2Env.port_b, cylinderChamberHead.port[3]) annotation (Line(
        points={{-54,-20},{-42,-20},{-42,0},{-40,0},{-40,0.65}}, color={255,
          0,0}));
  connect(leakage_Rod2Env.port_b, cylinderChamberRod.port[3]) annotation (Line(
        points={{54,-20},{42,-20},{42,0},{40,0},{40,0.65}}, color={255,0,0}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-90,80},{90,-90}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,10},{0,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,39},{0,-39}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-40},{-80,-40},{-80,-40},{-80,-80}}, color={255,0,
              0}),
        Line(points={{80,-40},{80,-40},{80,-40},{80,-78}}, color={255,0,0}),
        Polygon(
          points={{-88,-40},{-80,-30},{-72,-40},{-88,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{72,-40},{80,-30},{88,-40},{72,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-64,-56},{-34,-96}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{34,-56},{64,-96}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{0,84},{0,60}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{-34,18},{16,-18}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-22,-26},{8,34}}, color={0,0,0}),
        Polygon(
          points={{8,34},{-8,18},{4,12},{8,34}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end DoubleActingCylinder;
