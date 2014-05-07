within OpenHydraulics.Components.Valves.DirectionalValves;
model V4_3CCLSHydAntiCavitation
  "4-port 3-pos load-sensing valve with anti cavitation check valve"

  // parameters
  parameter SI.Time timeConstLS(final min=1e-3) = 0.05
    "response time of LS signal"
    annotation(Dialog(tab="Advanced"));
  parameter Real switchBand(final min=1e-3) = 0.01
    "Band of control inputs in which the LS port is switched"
    annotation(Dialog(tab="Advanced"));

  OpenHydraulics.Interfaces.FluidPort portLS
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));

  // configurable components
  replaceable OpenHydraulics.Components.Valves.CheckValve checkT2B(q_nom=
        0.02)
    annotation (
    choicesFromPackage=true,
    Dialog(tab="Config Options"),
    Placement(transformation(
        origin={56,44},
        extent={{-8,-8},{8,8}},
        rotation=270)));

  replaceable OpenHydraulics.Components.Valves.CheckValve checkT2A(q_nom=
        0.02)
    annotation (
    choicesFromPackage=true,
    Dialog(tab="Config Options"),
    Placement(transformation(
        origin={-56,44},
        extent={{-8,-8},{8,8}},
        rotation=270)));

  replaceable OpenHydraulics.Components.Valves.ReliefValve reliefB2T(dp_relief=
       1e7, dp_open=1e8)
    annotation (
    choicesFromPackage=true,
    Dialog(tab="Config Options"),
    Placement(transformation(
        origin={80,44},
        extent={{-8,-8},{8,8}},
        rotation=270)));

  replaceable OpenHydraulics.Components.Valves.ReliefValve reliefA2T(dp_relief=
       1e7, dp_open=1e8)
    annotation (
    choicesFromPackage=true,
    Dialog(tab="Config Options"),
    Placement(transformation(
        origin={-80,44},
        extent={{-8,-8},{8,8}},
        rotation=270)));

  Basic.VarPressureSource pressLS
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));

  extends
    OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.PartialValve4_3pos(
    j2(n_ports=5),
    j4(n_ports=7),
    j3(n_ports=5));

protected
  SI.AbsolutePressure ssLS "Steady State Load Sense pressure";
  SI.AbsolutePressure p_LS(start=p_init,fixed=true) "Load Sense pressure";
equation
  // first order response for LS pressure
  ssLS = if dynamicResponse.y > switchBand then portA.p else
         if dynamicResponse.y < -switchBand then portB.p else
         portT.p;
  der(p_LS)*timeConstLS = ssLS - p_LS;
  pressLS.control = p_LS;

  connect(j2.port[4], checkT2A.port_a) annotation (Line(points={{-40,60},
          {-40,60},{-56,60},{-56,52}}, color={255,0,0}));
  connect(checkT2A.port_b, j4.port[4]) annotation (Line(points={{-56,36},
          {-56,-46},{0,-46},{0,-60},{40,-60},{40,-60}}, color={255,0,0}));
  connect(j3.port[4], checkT2B.port_a) annotation (Line(points={{40,60},{
          40,60},{56,60},{56,52}}, color={255,0,0}));
  connect(checkT2B.port_b, j4.port[5]) annotation (Line(points={{56,36},{
          56,-60},{40,-60},{40,-60}}, color={255,0,0}));

  connect(j2.port[5], reliefA2T.port_a)   annotation (Line(points={{-40,
          60},{-40,60},{-80,60},{-80,52}}, color={255,0,0}));
  connect(reliefA2T.port_b, j4.port[6])   annotation (Line(points={{-80,
          36},{-80,28},{-56,28},{-56,-46},{0,-46},{0,-60},{40,-60},{40,
          -60}}, color={255,0,0}));
  connect(j3.port[5], reliefB2T.port_a)    annotation (Line(points={{40,
          60},{40,60},{80,60},{80,52}}, color={255,0,0}));
  connect(reliefB2T.port_b, j4.port[7])    annotation (Line(points={{80,
          36},{80,28},{56,28},{56,-60},{40,-60},{40,-60}}, color={255,0,0}));
  connect(pressLS.port, portLS)
    annotation (Line(points={{0,60},{0,80}}, color={255,0,0}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics={
        Line(points={{-78,-30},{-78,30}}, color={0,0,0}),
        Line(points={{-42,-30},{-42,30}}, color={0,0,0}),
        Polygon(
          points={{-78,30},{-84,10},{-72,10},{-78,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-42,-30},{-48,-10},{-36,-10},{-42,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{78,-30},{42,30}}, color={0,0,0}),
        Line(points={{42,-30},{78,30}}, color={0,0,0}),
        Polygon(
          points={{78,-30},{62,-14},{72,-8},{78,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{78,30},{72,8},{62,14},{78,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-18,-30},{-18,-12}}, color={0,0,0}),
        Line(points={{-24,-12},{-12,-12}}, color={0,0,0}),
        Line(points={{-24,12},{-12,12}}, color={0,0,0}),
        Line(points={{12,12},{24,12}}, color={0,0,0}),
        Line(points={{-18,12},{-18,30}}, color={0,0,0}),
        Line(points={{18,12},{18,30}}, color={0,0,0}),
        Line(points={{-18,30},{-18,60},{-40,60},{-40,80}}, color={255,0,0}),
        Line(points={{18,30},{18,60},{40,60},{40,80}}, color={255,0,0}),
        Line(points={{-18,-30},{-18,-60},{-40,-60},{-40,-80}}, color={255,
              0,0}),
        Line(points={{18,-30},{18,-60},{40,-60},{40,-80}}, color={255,0,0}),
        Line(points={{-60,4},{-60,30}}, color={0,0,0}),
        Line(points={{-78,4},{-60,4}}, color={0,0,0}),
        Line(points={{60,10},{60,30}}, color={0,0,0}),
        Line(points={{60,10},{66,10}}, color={0,0,0}),
        Line(points={{18,-30},{0,30}}, color={0,0,0}),
        Polygon(
          points={{18,-30},{6,-12},{18,-8},{18,-30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,30},{0,82}}, color={0,0,0}),
        Text(
          extent={{0,72},{0,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="LS")}),
                            Diagram(graphics));
end V4_3CCLSHydAntiCavitation;
