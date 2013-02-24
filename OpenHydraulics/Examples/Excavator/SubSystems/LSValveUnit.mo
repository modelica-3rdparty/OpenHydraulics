within OpenHydraulics.Examples.Excavator.SubSystems;
model LSValveUnit

  // sizing parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 3e5 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing"));

  parameter Real q_fraction_P2A = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P2B = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_A2T = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_B2T = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));

  // dynamic response parameters
  parameter SI.Frequency bandwidth = 10 "Bandwidth of 2nd order response"
    annotation(Dialog(tab="Dynamics"));
  parameter Real dampCoeff = 1 "Damping coefficient of 2nd order response"
    annotation(Dialog(tab="Dynamics"));

  // initialization parameters
  parameter Boolean fixPressureA = false "True if pressure at port is fixed"
  annotation(Dialog(tab="Initialization",group="Pressures"));
  parameter Boolean fixPressureB = false "True if pressure at port is fixed"
  annotation(Dialog(tab="Initialization",group="Pressures"));

  // the components

  OpenHydraulics.Components.Valves.ShuttleValve shuttleValve(q_nom=0.01)
    annotation (Placement(transformation(
        origin={0,30},
        extent={{10,-10},{-10,10}},
        rotation=270)));

  // configuration components
  OpenHydraulics.Components.Valves.DirectionalValves.V4_3CCLSHydAntiCavitation
    valve4_3pos_wRelief(
    bandwidth=bandwidth,
    dampCoeff=dampCoeff,
    q_nom=q_nom,
    dp_nom=dp_nom,
    q_fraction_P2A=q_fraction_P2A,
    q_fraction_P2B=q_fraction_P2B,
    q_fraction_A2T=q_fraction_A2T,
    q_fraction_B2T=q_fraction_B2T,
    j1(V=0))
    annotation (
    Dialog(tab="Config Options"), Placement(transformation(extent={{-10,
            -8},{10,12}}, rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j1(n_ports=3)
    annotation (Placement(transformation(extent={{-14,-50},{6,-30}},
          rotation=0)));

  OpenHydraulics.Components.Lines.NJunction j2(n_ports=3)
    annotation (Placement(transformation(extent={{-6,-90},{14,-70}},
          rotation=0)));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort portA(p(start=p_init, fixed=
          fixPressureA))
    annotation (Placement(transformation(extent={{-58,94},{-46,106}},
          rotation=0)));

  OpenHydraulics.Interfaces.FluidPort portB(p(start=p_init, fixed=
          fixPressureB))
    annotation (Placement(transformation(extent={{46,94},{58,106}},
          rotation=0)));

  OpenHydraulics.Interfaces.FluidPort portP2
    annotation (Placement(transformation(extent={{-106,-46},{-94,-34}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portT2
    annotation (Placement(transformation(extent={{-106,-86},{-94,-74}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portP1
    annotation (Placement(transformation(extent={{94,-46},{106,-34}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portT1
    annotation (Placement(transformation(extent={{94,-86},{106,-74}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portLS1
    annotation (Placement(transformation(extent={{94,14},{106,26}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort portLS2
    annotation (Placement(transformation(extent={{-106,14},{-94,26}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u[sizeOfInputs]
    annotation (Placement(transformation(
        origin={106,70},
        extent={{-14,-14},{14,14}},
        rotation=180)));
  parameter Integer sizeOfInputs=1 "Size of input array";
  Modelica.Blocks.Interfaces.RealOutput y[sizeOfInputs]
    annotation (Placement(transformation(
        origin={-106,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  parameter Integer inputIndex=1 "Index of command for this valve";

  extends OpenHydraulics.Interfaces.PartialFluidComponent;
equation
  connect(valve4_3pos_wRelief.portLS, shuttleValve.PortA) annotation (Line(
        points={{0,10},{0,20},{-1.83697e-015,20}},color={255,0,0}));
  connect(portLS1, shuttleValve.PortB) annotation (Line(points={{100,20},
          {60,20},{60,50},{0,50},{0,40},{1.83697e-015,40}},  color={255,0,
          0}));
  connect(shuttleValve.PortC, portLS2) annotation (Line(points={{-8,30},{
          -60,30},{-60,20},{-100,20}}, color={255,0,0}));
  connect(portP2, j1.port[1]) annotation (Line(points={{-100,-40},{-4,-40},
          {-4,-40.6667}},
                        color={255,0,0}));
  connect(portP1, j1.port[2]) annotation (Line(points={{100,-40},{48,-40},{48,-40},
          {-4,-40}},                color={255,0,0}));
  connect(portT2, j2.port[1]) annotation (Line(points={{-100,-80},{4,-80},
          {4,-80.6667}},
                       color={255,0,0}));
  connect(portT1, j2.port[2]) annotation (Line(points={{100,-80},{4,-80},{4,-80}},
                       color={255,0,0}));
  connect(j2.port[3], valve4_3pos_wRelief.portT)
    annotation (Line(points={{4,-79.3333},{4,-6}},
                                                 color={255,0,0}));
  connect(u, y)
    annotation (Line(points={{106,70},{-106,70}}, color={0,0,127}));
  connect(u[inputIndex], valve4_3pos_wRelief.control)
                                               annotation (Line(points={{
          106,70},{68,70},{68,2},{11,2}}, color={0,0,127}));
  connect(valve4_3pos_wRelief.portA, portA) annotation (Line(points={{-4,
          10},{-4,12},{-52,12},{-52,100}}, color={255,0,0}));
  connect(valve4_3pos_wRelief.portB, portB) annotation (Line(points={{4,
          10},{4,12},{52,12},{52,100}}, color={255,0,0}));
  connect(valve4_3pos_wRelief.portP, j1.port[3]) annotation (Line(points={{-4,-6},
          {-4,-39.3333}},        color={255,0,0}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{62,24},{96,14}},
          lineColor={255,0,0},
          textString="LS"),
        Text(
          extent={{-94,24},{-60,14}},
          lineColor={255,0,0},
          textString="LS"),
        Text(
          extent={{72,-34},{98,-44}},
          lineColor={255,0,0},
          textString="P"),
        Text(
          extent={{-92,-36},{-66,-46}},
          lineColor={255,0,0},
          textString="P"),
        Text(
          extent={{70,-74},{96,-84}},
          lineColor={255,0,0},
          textString="T"),
        Text(
          extent={{-94,-76},{-68,-86}},
          lineColor={255,0,0},
          textString="T"),
        Text(
          extent={{-66,90},{-38,76}},
          lineColor={255,0,0},
          textString="A"),
        Text(
          extent={{38,90},{68,76}},
          lineColor={255,0,0},
          textString="B"),
        Text(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          textString="Valve"),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Text(
          extent={{-100,-20},{100,-60}},
          lineColor={0,0,0},
          textString="Unit"),
        Text(
          extent={{-100,80},{100,40}},
          lineColor={0,0,255},
          textString="%name")}));
end LSValveUnit;
