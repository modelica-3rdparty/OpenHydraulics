within OpenHydraulics.Components.Lines;
model NJunction
  "Splitting/joining component with static balances for an infinitesimal control volume"
  parameter Integer n_ports(min=1) = 3 "Number of ports (min=1)";
  parameter SI.Volume V = 1e-6 "Volume of junction"
    annotation(Dialog(tab="Sizing"));

  parameter Boolean fixPressure = false "True if pressure at junction is fixed"
  annotation(Dialog(tab="Initialization"));

  OpenHydraulics.Interfaces.FluidPort port[n_ports](m_flow(each start=0), p(
        each start=p_init))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Basic.VolumeClosed volumeClosed(
    final n_ports=n_ports,
    final V = V,
    compressible=false)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;
initial equation
  if fixPressure then
    volumeClosed.p_vol = p_init;
  end if;

equation
  connect(port, volumeClosed.port)
    annotation (Line(points={{0,0},{0,-30.05}}, color={255,0,0}));

  annotation (defaultComponentName="j1",Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-50,48},{50,-38}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,-26},{0,-56}},
          lineColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
                          Diagram(graphics),
             Documentation(info="<html>
  This model is the simplest implementation for a splitting/joining component for
  N flows. Its use is not required. It just formulates the balance
  equations in the same way that the connect symmantics would formulate them anyways.
  The main advantage of using this component is, that the user does not get
  confused when looking at the specific enthalpy at each port which might be confusing
  when not using a splitting/joining component. The reason for the confusion is that one exmanins the mixing
  enthalpy of the infinitesimal control volume introduced with the connect statement when
  looking at the specific enthalpy in the connector which
  might not be equal to the specific enthalpy at the port in the \"real world\".</html>"));
end NJunction;
