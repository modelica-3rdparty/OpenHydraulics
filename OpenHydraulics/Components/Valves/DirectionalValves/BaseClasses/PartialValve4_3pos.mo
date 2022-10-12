within OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses;
partial model PartialValve4_3pos "Partial class for building 4-port 3-position valves"

  // sizing parameters
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
  parameter Real q_fraction_B2T = 1 "Fraction of nominal flow rate"
    annotation(Dialog(tab="Sizing",group="Advanced Metering"));

  // dynamic response parameters
  parameter SI.Frequency bandwidth = 10 "Bandwidth of 2nd order response"
    annotation(Dialog(tab="Dynamics"));
  parameter Real dampCoeff = 1 "Damping coefficient of 2nd order response"
    annotation(Dialog(tab="Dynamics"));

  // configuration options
  parameter Boolean useCheckValve = true "true = use check valve on port P"
    annotation (Dialog(tab="Config Options"));

  extends OpenHydraulics.Components.Valves.DirectionalValves.BaseClasses.Valve4_3posInterface;

  // the spool models
  OpenHydraulics.Basic.VariableRestrictionSeriesValve P2A(
    final q_nom=q_nom*q_fraction_P2A,
    table=[0,0; 1,1],
    D_nom=0.01,
    dp_nom=dp_nom,
    min_contr=0,
    max_contr=1,
    p_init=p_init)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={-40,0},
        extent={{-8,-8},{8,8}},
        rotation=90)));

  OpenHydraulics.Basic.VariableRestriction B2T(
    final q_nom=q_nom*q_fraction_B2T,
    table=[0,0; 1,1],
    D_nom=0.01,
    dp_nom=dp_nom,
    min_contr=0,
    max_contr=1,
    p_init=p_init)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
        origin={40,0},
        extent={{-8,8},{8,-8}},
        rotation=270)));

  OpenHydraulics.Basic.VariableRestrictionSeriesValve P2B(
    final q_nom=q_nom*q_fraction_P2B,
    table=[-1,1; 0,0],
    D_nom=0.01,
    dp_nom=dp_nom,
    min_contr=-1,
    max_contr=0,
    p_init=p_init)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
          extent={{-28,-22},{-12,-38}})));

  OpenHydraulics.Basic.VariableRestriction A2T(
    final q_nom=q_nom*q_fraction_A2T,
    table=[-1,1; 0,0],
    D_nom=0.01,
    dp_nom=dp_nom,
    min_contr=-1,
    max_contr=0,
    p_init=p_init)
    annotation (
    Dialog(tab="Metering",group="Spool"), Placement(transformation(
          extent={{-28,22},{-12,38}})));

  // configurable components

  // the connection junctions (with small volumes)
  Lines.NJunction j1(
    n_ports=3,
    p_init=p_init)
    annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));

  Lines.NJunction j2(
    n_ports=3,
    p_init=p_init)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));

  Lines.NJunction j3(
    n_ports=3,
    p_init=p_init)
    annotation (Placement(transformation(extent={{30,50},{50,70}})));

  Lines.NJunction j4(
    n_ports=3,
    p_init=p_init)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));

  Modelica.Blocks.Continuous.SecondOrder dynamicResponse(
    w=bandwidth*2*Modelica.Constants.pi,
    D=dampCoeff,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{86,-10},{66,10}})));

initial equation
  assert(useCheckValve,"not implemented yet without serial check valve");

equation
  connect(dynamicResponse.y, A2T.control)
    annotation (Line(points={{65,0},{50,0},{50,12},{30,12},{30,0},{-20,
          0},{-20,23.6}}, color={0,0,127}));
  connect(dynamicResponse.y, B2T.control)
    annotation (Line(points={{65,0},{50,0},{50,-1.17566e-015},{46.4,-1.17566e-015}},
                          color={0,0,127}));
  connect(dynamicResponse.y, P2A.control)
    annotation (Line(points={{65,0},{50,0},{50,12},{30,12},{30,0},{-28,
          0},{-28,-3.91887e-016},{-33.6,-3.91887e-016}}, color={0,0,127}));
  connect(dynamicResponse.y, P2B.control)
    annotation (Line(points={{65,0},{50,0},{50,12},{30,12},{30,0},{-20,
          0},{-20,-23.6}}, color={0,0,127}));
  connect(j2.port[1], portA)
    annotation (Line(points={{-40,59.3333},{-40,80}}, color={255,0,0}));
  connect(portB,j3. port[1])
    annotation (Line(points={{40,80},{40,59.3333}}, color={255,0,0}));
  connect(portT,j4. port[1])
    annotation (Line(points={{40,-80},{40,-60.6667}}, color={255,0,0}));
  connect(j4.port[2], B2T.port_b)
    annotation (Line(points={{40,-60},{40,-8}}, color={255,0,0}));
  connect(j3.port[3], B2T.port_a)
    annotation (Line(points={{40,60.6667},{40,8}}, color={255,0,0}));
  connect(A2T.port_a, j2.port[3])
    annotation (Line(points={{-28,30},{-40,30},{-40,60.6667}}, color={
          255,0,0}));
  connect(A2T.port_b, j4.port[3])
    annotation (Line(points={{-12,30},{-12,30},{12,-30},{40,-30},{40,-59.3333}},
                      color={255,0,0}));
  connect(control, dynamicResponse.u)
    annotation (Line(points={{110,0},{88,0}}, color={0,0,127}));
  connect(P2A.port_a, j1.port[2])
    annotation (Line(points={{-40,-8},{-40,-60}}, color={255,0,0}));
  connect(P2B.port_a, j1.port[3])
     annotation (Line(points={{-28,-30},{-40,-30},{-40,-59.3333}},
        color={255,0,0}));
  connect(portP, j1.port[1])
    annotation (Line(points={{-40,-80},{-40,-60.6667}}, color={255,0,0}));
  connect(P2A.port_b, j2.port[2])
    annotation (Line(points={{-40,8},{-40,60}}, color={255,0,0}));
  connect(P2B.port_b, j3.port[2])
    annotation (Line(points={{-12,-30},{12,30},{40,30},{40,60}}, color=
          {255,0,0}));
  annotation (Diagram(graphics={
        Text(
          extent={{-24,-66},{24,-72}},
          lineColor={0,0,255},
          textString=
               "P2A and P2B"),
        Text(
          extent={{-24,-72},{24,-78}},
          lineColor={0,0,255},
          textString=
               "can be configured"),
        Text(
          extent={{-24,-78},{24,-84}},
          lineColor={0,0,255},
          textString=
               "with useCheckValve"),
        Rectangle(extent={{-24,-64},{24,-86}}, lineColor={0,0,255})}));
end PartialValve4_3pos;
