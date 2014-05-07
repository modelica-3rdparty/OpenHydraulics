within OpenHydraulics.Components.MotorsPumps;
model PCLSPump

  // parameters in sizing tab
  parameter SI.Volume Dmax = 0.001 "Maximum pump displacement"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Volume Dmin = 0 "Minimum pump displacement (<0 for over-center)"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Volume Dlimit = max(abs(Dmax),abs(Dmin)) "Displacement of pump"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure p_margin = 1e5 "Desired margin over measured pressure"
    annotation(Dialog(tab="Sizing"));

  // parameters in Dynamics tab
  parameter Real propGain = 2e-5 "Proportional controller gain"
    annotation(Dialog(tab="Dynamics"));
  parameter Real timeConst = 0.1 "Time constant of swashplate controller"
    annotation(Dialog(tab="Dynamics"));

  // loss parameters
  parameter Real Cv = 60000 "Coefficient of viscous drag"
    annotation(Dialog(tab="Efficiency",group="Mechanical Efficiency"));
  parameter Real Cf = 0.007
    "Coefficient of Coulomb friction (fraction of full stroke torque)"
    annotation(Dialog(tab="Efficiency",group="Mechanical Efficiency"));
  parameter Real Cs = 1.8e-9 "Leakage coefficient"
    annotation(Dialog(tab="Efficiency",group="Volumetric Efficiency"));
  parameter Real Vr = 0.54 "Volume ratio of pump or motor"
    annotation(Dialog(tab="Efficiency",group="Volumetric Efficiency"));
  parameter SI.DynamicViscosity mu = oil.dynamicViscosity(p_init)
    "Dynamic viscosity (used only for efficiency computation)"
    annotation(Dialog(tab="Efficiency",group="Related Parameters"));
  parameter SI.BulkModulus B = oil.approxBulkModulus(p_init)
    "Approximate bulk modulus (used only for efficiency models)"
    annotation(Dialog(tab="Efficiency",group="Related Parameters"));

  // the sub-components
  Basic.FluidPower2MechRotVar fluidPower2MechRotVar(
      Dmax=Dmax,
      Dmin = Dmin,
      Dlimit = Dlimit)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  BaseClasses.MechanicalPumpLosses mechanicalPumpLosses(
    Cv=Cv,
    Cf=Cf,
    Dmax=Dlimit,
    mu = mu)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Basic.VariableFlow leakage_P2T
    annotation (Placement(transformation(
        origin={60,0},
        extent={{-10,10},{10,-10}},
        rotation=270)));

  Sensors.PressureSensor pressureSensorP
    annotation (Placement(transformation(
        origin={80,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Continuous.LimPID swashPlatePD(
    final controllerType=Modelica.Blocks.Types.SimpleController.PD,
    k=propGain,
    Td=timeConst,
    final yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    annotation (Placement(transformation(extent={{0,-36},{20,-16}})));
  Sensors.PressureSensor pressureSensorLS
    annotation (Placement(transformation(extent={{-90,-42},{-70,-22}})));
  Modelica.Blocks.Math.Add desiredPressure
    annotation (Placement(transformation(extent={{-30,-36},{-10,-16}})));
  Modelica.Blocks.Sources.RealExpression pressureMargin(
    y=p_margin)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Lines.NJunction j1
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Lines.NJunction j2(
    n_ports=4)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));

  // the ports
  OpenHydraulics.Interfaces.FluidPort portP
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  OpenHydraulics.Interfaces.FluidPort portT
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  OpenHydraulics.Interfaces.FluidPort portLS
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    "(left) driving flange (flange axis directed INTO cut plane)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

protected
  SI.Pressure dp = portP.p - portT.p;
equation
  // connect the input of the leakage model and the mechanical loss model
  leakage_P2T.q_flow = Cs*dp*Dlimit/mu
      + dp*mechanicalPumpLosses.w*Dlimit*(Vr + (1+fluidPower2MechRotVar.dispFraction)/2)/B;
  mechanicalPumpLosses.dp = dp;

  connect(pressureSensorLS.port_a, portLS) annotation (Line(points={{-80,
          -42},{-80,-80}}, color={255,0,0}));
  connect(desiredPressure.y, swashPlatePD.u_s)  annotation (Line(points={{
          -9,-26},{-2,-26}}, color={0,0,127}));
  connect(pressureSensorP.y, swashPlatePD.u_m)  annotation (Line(points={{
          80,33},{80,-56},{10,-56},{10,-38}}, color={0,0,127}));
  connect(flange_a, mechanicalPumpLosses.flange_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,0,0}));
  connect(mechanicalPumpLosses.flange_b, fluidPower2MechRotVar.flange_a)
    annotation (Line(points={{-60,0},{30,0}}, color={0,0,0}));
  connect(portT, j1.port[1])
    annotation (Line(points={{0,-100},{40,-100},{40,-40.6667}}, color={255,
          0,0}));
  connect(portP, j2.port[1])
    annotation (Line(points={{0,100},{40,100},{40,39.25}}, color={255,0,0}));
  connect(fluidPower2MechRotVar.port_b, j2.port[2])
    annotation (Line(points={{40,10},{40,39.75}}, color={255,0,0}));
  connect(fluidPower2MechRotVar.port_a, j1.port[2])
    annotation (Line(points={{40,-10},{40,-40}}, color={255,0,0}));
  connect(leakage_P2T.port_a, j2.port[3]) annotation (Line(points={{60,10},
          {60,40},{40,40},{40,40.25}}, color={255,0,0}));
  connect(leakage_P2T.port_b, j1.port[3]) annotation (Line(points={{60,-10},
          {60,-40},{40,-40},{40,-39.3333}}, color={255,0,0}));
  connect(pressureSensorP.port_a, j2.port[4]) annotation (Line(points={{70,
          40},{40,40},{40,40.75}}, color={255,0,0}));
  connect(pressureMargin.y, desiredPressure.u1) annotation (Line(points={{
          -39,-20},{-32,-20}}, color={0,0,127}));
  connect(pressureSensorLS.y, desiredPressure.u2) annotation (Line(points={
          {-73,-32},{-32,-32}}, color={0,0,127}));
  connect(swashPlatePD.y, fluidPower2MechRotVar.dispFraction) annotation (Line(
        points={{21,-26},{26,-26},{26,-7.9},{31.5,-7.9}}, color={0,0,127}));
  annotation (Diagram(graphics={
        Text(
          extent={{-38,64},{-38,52}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "section for"),
        Text(
          extent={{-38,76},{-38,64}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "see equations"),
        Rectangle(extent={{-78,76},{0,40}}, lineColor={0,0,255}),
        Text(
          extent={{-38,52},{-38,40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString=
               "loss relationships")}),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-54,54},{54,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-54},{0,-100}}, color={255,0,0}),
        Line(points={{0,100},{0,54}}, color={255,0,0}),
        Rectangle(
          extent={{-90,8},{-54,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{80,80}}, color={0,0,0}),
        Polygon(
          points={{80,80},{52,66},{66,52},{80,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,34},{0,54},{20,34},{-20,34}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-34},{0,-54},{20,-34},{-20,-34}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{100,-54},{-100,-90}}, textString="%name"),
        Text(
          extent={{10,-80},{40,-120}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Text(
          extent={{10,120},{40,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="P")}));
end PCLSPump;
