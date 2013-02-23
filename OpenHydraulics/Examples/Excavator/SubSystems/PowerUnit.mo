within OpenHydraulics.Examples.Excavator.SubSystems;
model PowerUnit

  Components.MotorsPumps.PCLSPump pclsPump(
    p_margin=3e5,
    Dmax=0.0005,
    timeConst=0.01)
    annotation (                         Dialog, Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));

  OpenHydraulics.Components.Volumes.CircuitTank circuitTank
    annotation (Placement(transformation(extent={{40,-50},{20,-30}},
          rotation=0)));

  OpenHydraulics.Components.Valves.ReliefValve reliefValve(dp_relief=3e7,
      dp_open=3.1e7)
    annotation (Placement(transformation(extent={{20,30},{40,50}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j1(n_ports=3)
    annotation (Placement(transformation(extent={{-10,30},{10,50}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j2(n_ports=3)
    annotation (Placement(transformation(extent={{50,30},{70,50}},
          rotation=0)));

  // the ports
  OpenHydraulics.Interfaces.FluidPort portP
    annotation (Placement(transformation(extent={{-6,94},{6,106}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portT
    annotation (Placement(transformation(extent={{54,94},{66,106}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portLS
    annotation (Placement(transformation(extent={{-66,94},{-54,106}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    "(left) driving flange (flange axis directed INTO cut plane)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;
equation
  connect(circuitTank.port_b, pclsPump.portT)
    annotation (Line(points={{20,-40},{0,-40},{0,-10}}, color={255,0,0}));
  connect(pclsPump.portP, j1.port[1]) annotation (Line(points={{0,10},{0,
          39.3333}},
                   color={255,0,0}));
  connect(circuitTank.port_a, j2.port[1]) annotation (Line(points={{40,-40},
          {60,-40},{60,39.3333}},    color={255,0,0}));
  connect(j2.port[3], reliefValve.port_b) annotation (Line(points={{60,40.6667},
          {60,40},{40,40}},        color={255,0,0}));
  connect(j1.port[3], reliefValve.port_a) annotation (Line(points={{0,40.6667},
          {0,40},{20,40}},        color={255,0,0}));
  connect(j1.port[2], portP) annotation (Line(points={{0,40},{0,100}},
        color={255,0,0}));
  connect(j2.port[2], portT) annotation (Line(points={{60,40},{60,100}},
        color={255,0,0}));
  connect(pclsPump.flange_a, flange_a) annotation (Line(points={{-10,0},{
          -100,0}}, color={0,0,0}));
  connect(portLS, pclsPump.portLS) annotation (Line(points={{-60,100},{
          -60,-20},{-8,-20},{-8,-8}}, color={255,0,0}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-80,92},{-40,68}},
          lineColor={255,0,0},
          textString="LS"),
        Text(
          extent={{-20,92},{20,68}},
          lineColor={255,0,0},
          textString="P"),
        Text(
          extent={{40,92},{80,68}},
          lineColor={255,0,0},
          textString="T"),
        Text(
          extent={{-100,50},{100,10}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          textString="Power Unit"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Text(
          extent={{-100,-10},{100,-50}},
          lineColor={0,0,255},
          textString="%name")}));
end PowerUnit;
