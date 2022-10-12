within OpenHydraulics.Components.MotorsPumps;
model Motor

  // the parameters
  parameter SI.Volume Dconst = 1e-5 "Displacement of the motor"
    annotation(Dialog(tab="Sizing"));
  parameter Real damp=100000 "Viscous damping constant"
    annotation(Dialog(tab="Losses"));

  // the ports
  OpenHydraulics.Interfaces.FluidPort portB
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  OpenHydraulics.Interfaces.FluidPort portA
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  // the components
  OpenHydraulics.Basic.FluidPower2MechRotConst idealMotor(Dconst=Dconst)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  OpenHydraulics.Basic.LaminarRestriction leakeage_A2B(L=0.1,D=1e-4)
    "Laminar leakage between ports A to B"
    annotation (
    Dialog(tab="Losses"), Placement(transformation(
        origin={-20,2},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  // configuration options
  parameter Boolean usePRV = true "True if pressure relieve valves are present"
    annotation(Dialog(tab="Config Options"));
  OpenHydraulics.Components.Valves.ReliefValve PRV_A2B if usePRV
    "Relief from port A to B"
    annotation (
    Dialog(tab="Config Options",group="PRV Characteristics",enable=usePRV),
      Placement(transformation(
        origin={-48,2},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  OpenHydraulics.Components.Valves.ReliefValve PRV_B2A if usePRV
    "Relief from port B to A"
    annotation (
    Dialog(tab="Config Options",group="PRV Characteristics",enable=usePRV),
      Placement(transformation(
        origin={-80,2},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    "(right) driven flange (flange axis directed OUT OF cut plane)"
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(
                                              d=damp)
    annotation (Placement(transformation(extent={{10,12},{30,32}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{34,12},{54,32}})));
  OpenHydraulics.Components.Lines.NJunction j2(n_ports=5)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  OpenHydraulics.Components.Lines.NJunction j1(n_ports=5)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));

 extends OpenHydraulics.Interfaces.PartialFluidComponent;

equation
  connect(idealMotor.port_b, j2.port[1])       annotation (Line(points={{0,10},{
          0,39.2}},       color={255,0,0}));
  connect(leakeage_A2B.port_b, j2.port[2])       annotation (Line(points={{-20,12},
          {-20,40},{0,40},{0,39.6}},          color={255,0,0}));
  connect(idealMotor.port_a, j1.port[1])       annotation (Line(points={{0,-10},
          {0,-40.8}},       color={255,0,0}));
  connect(j1.port[2], leakeage_A2B.port_a)       annotation (Line(points={{0,-40.4},
          {0,-40},{-20,-40},{-20,-8}},           color={255,0,0}));
  connect(idealMotor.flange_b, flange_b)
    annotation (Line(points={{10,0},{98,0}}, color={0,0,0}));
  connect(j2.port[3], portB)
                            annotation (Line(points={{0,40},{0,100}},
        color={255,0,0}));
  connect(portA,j1. port[3]) annotation (Line(points={{0,-100},{0,-40}},
        color={255,0,0}));
  connect(idealMotor.flange_b, damper.flange_a)
    annotation (Line(points={{10,0},{10,22}}, color={0,0,0}));
  connect(damper.flange_b,fixed.flange)
    annotation (Line(points={{30,22},{44,22}}, color={0,0,0}));
  connect(PRV_A2B.port_b, j2.port[4])     annotation (Line(points={{-48,12},
          {-48,40},{0,40},{0,40.4}},  color={255,0,0}));
  connect(PRV_B2A.port_a,j2. port[5])      annotation (Line(points={{-80,12},
          {-80,40},{0,40},{0,40.8}},  color={255,0,0}));
  connect(PRV_B2A.port_b,j1. port[5])      annotation (Line(points={{-80,-8},
          {-80,-40},{0,-40},{0,-39.2}},  color={255,0,0}));
  connect(PRV_A2B.port_a, j1.port[4])     annotation (Line(points={{-48,-8},
          {-48,-40},{0,-40},{0,-39.6}},  color={255,0,0}));
annotation (     Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-54,54},{54,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-54},{0,-100}}, color={255,0,0}),
        Line(points={{0,100},{0,54}}, color={255,0,0}),
        Rectangle(
          extent={{54,8},{90,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-50},{0,-30},{20,-50},{-20,-50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,50},{0,30},{20,50},{-20,50}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{100,-54},{-100,-90}}, textString="%name"),
        Text(
          extent={{10,-80},{40,-120}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{10,120},{40,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B")}));
end Motor;
