within OpenHydraulics.Components.Valves.DirectionalValves;
model V4_3CCRegenerative "Simple Regenerative valve model"

  // parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 1e6 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing"));
  parameter Real q_fraction_P2A = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_P2B = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real q_fraction_A2T = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));
  parameter Real dampCoeff = 1 "Damping coefficient of 2nd order response"
    annotation(Dialog(tab="Dynamics"));
  parameter Modelica.Units.SI.Frequency bandwidth=100 "Bandwidth of 2nd order response" annotation (Dialog(tab="Dynamics"));

  // configuration options
  parameter Boolean useCheckValve = true "true = use check valve on port P"
    annotation (Dialog(tab="Config Options"));

  extends OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.Valve4_3posInterface;

   //junctions
  OpenHydraulics.Components.Lines.NJunction j1
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));

  OpenHydraulics.Components.Lines.NJunction j2
    annotation (Placement(transformation(extent={{-50,-66},{-30,-46}})));

  //components
  Basic.VariableRestriction P2B(
    min_contr=-1,
    final q_nom=q_nom*q_fraction_P2B,
    table=[-1,1; 0,0; 1,1])
    annotation (Placement(transformation(extent={{-20,-30},{0,-50}})));

  Basic.VariableRestriction P2A(
    table=[-1,0; 0,0; 1,1],
    min_contr=-1,
    final q_nom=q_nom*q_fraction_P2A)
    annotation (Placement(transformation(
        origin={-40,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  Basic.VariableRestriction A2T(
    min_contr=-1,
    final q_nom=q_nom*q_fraction_A2T,
    table=[-1,1; 0,0; 1,0])
    annotation (Placement(transformation(
        origin={-10,40},
        extent={{10,10},{-10,-10}},
        rotation=180)));

  Modelica.Blocks.Continuous.SecondOrder dynamicResponse(
    w=bandwidth*2*Modelica.Constants.pi,
    D=dampCoeff,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
initial equation
  assert(useCheckValve,"not implemented yet without serial check valve");

equation
  connect(dynamicResponse.u, control)
    annotation (Line(points={{84,0},{110,0}}, color={0,0,127}));
  connect(portP,j2. port[1]) annotation (Line(points={{-40,-80},{-40,
          -56.6667}}, color={255,0,0}));
  connect(j2.port[2], P2A.port_a) annotation (Line(points={{-40,-56},{-40,
          -10}}, color={255,0,0}));
  connect(P2A.port_b, j1.port[1]) annotation (Line(points={{-40,10},{-40,
          59.3333}}, color={255,0,0}));
  connect(j1.port[2], portA) annotation (Line(points={{-40,60},{-40,80}},
        color={255,0,0}));
  connect(j1.port[3], A2T.port_a) annotation (Line(points={{-40,60.6667},
          {-40,40},{-20,40}}, color={255,0,0}));
  connect(j2.port[3], P2B.port_a) annotation (Line(points={{-40,-55.3333},
          {-40,-40},{-20,-40}}, color={255,0,0}));
  connect(dynamicResponse.y, A2T.control) annotation (Line(points={{61,0},
          {-10,0},{-10,32}}, color={0,0,127}));
  connect(dynamicResponse.y, P2B.control) annotation (Line(points={{61,0},
          {-10,0},{-10,-32}}, color={0,0,127}));
  connect(dynamicResponse.y, P2A.control) annotation (Line(points={{61,0},
          {-32,0},{-32,-4.89843e-016}}, color={0,0,127}));
  connect(P2B.port_b, portB) annotation (Line(points={{0,-40},{20,-40},{
          40,40},{40,80}}, color={255,0,0}));
  connect(A2T.port_b, portT) annotation (Line(points={{0,40},{20,40},{40,
          -40},{40,-80}}, color={255,0,0}));
  annotation (         Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-14,12},{-14,30}}, color={0,0,0}),
        Line(points={{-20,12},{-8,12}}, color={0,0,0}),
        Line(points={{8,12},{20,12}}, color={0,0,0}),
        Line(points={{14,12},{14,30}}, color={0,0,0}),
        Line(points={{8,-12},{20,-12}}, color={0,0,0}),
        Line(points={{14,-30},{14,-12}}, color={0,0,0}),
        Line(points={{-14,-30},{-14,-12}}, color={0,0,0}),
        Line(points={{-20,-12},{-8,-12}}, color={0,0,0}),
        Line(points={{-74,-30},{-74,30}}, color={0,0,0}),
        Line(points={{-46,12},{-46,30}}, color={0,0,0}),
        Line(points={{-74,12},{-46,12}}, color={0,0,0}),
        Line(points={{-46,-30},{-46,-12}}, color={0,0,0}),
        Line(points={{-52,-12},{-40,-12}}, color={0,0,0}),
        Line(points={{-40,70},{-40,60},{-14,60},{-14,30}}, color={255,0,0}),
        Line(points={{40,80},{40,60},{14,60},{14,30}}, color={255,0,0}),
        Line(points={{-40,-78},{-40,-60},{-14,-60},{-14,-30}}, color={255,
              0,0}),
        Line(points={{40,-80},{40,-60},{16,-60},{14,-60}}, color={255,0,0}),
        Line(points={{14,-30},{14,-60}}, color={255,0,0}),
        Line(points={{44,-30},{74,30}}, color={0,0,0}),
        Line(points={{44,30},{74,-30}}, color={0,0,0}),
        Polygon(
          points={{74,30},{66,24},{72,20},{74,30}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{72,-18},{66,-22},{74,-30},{72,-18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,92},{80,112}},
          lineColor={0,0,255},
          textString="%name")}));
end V4_3CCRegenerative;
