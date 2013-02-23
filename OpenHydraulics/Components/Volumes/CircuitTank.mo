within OpenHydraulics.Components.Volumes;
model CircuitTank "Model for a Oil Tank"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // tank is a reservoir with two inputs!
  // two inputs are necessary to alow for taking cooling into account
  // inflowing fluid is mixed with fluid in the reservoir assuming perfect mixing
  // heat transfer occurs from this fluid to the environment (heat path not part of model)
  // We need to specify a preload pressure for the tank -- necessary boundary condition
  // we should allow for the initial temperature and quantity of the oil to be specified.

  // main parameters
  parameter SI.Volume V_max = 1 "Tank Volume"
    annotation(Dialog(tab="Sizing"));
  parameter SI.AbsolutePressure p_const = environment.p_ambient
    "preload pressure"
    annotation(Dialog(tab="Initialization"));
  parameter SI.Volume V_init = 0.1 "Initial Volume"
    annotation(Dialog(tab="Initialization"));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}},
          rotation=0)));

  // the components
  OpenHydraulics.Basic.VolumeOpen volumeOpen(final n_ports=2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0)));
equation
  connect(port_a, volumeOpen.port[1]) annotation (Line(points={{-100,0},{0,
          0},{0,-0.575}}, color={255,0,0}));
  connect(port_b, volumeOpen.port[2]) annotation (Line(points={{100,0},{0,0},
          {0,0.475}}, color={255,0,0}));
  annotation (
    Diagram(graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(points={{-60,20},{-60,-80},{60,-80},{60,20}}, color={0,0,0}),
        Line(points={{-100,0},{-80,0},{-80,40},{-40,40},{-40,14}}, color={
              255,0,0}),
        Line(points={{100,0},{80,0},{80,40},{40,40},{40,40},{40,-76}},
            color={255,0,0}),
        Rectangle(
          extent={{-60,-40},{60,-80}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,80},{100,40}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end CircuitTank;
