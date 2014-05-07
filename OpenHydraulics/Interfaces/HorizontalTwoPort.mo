within OpenHydraulics.Interfaces;
partial model HorizontalTwoPort "Two horizontally oriented fluid ports"
  // include the base characteristics for ANY fluid two-port
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // the main variables (most commonly investigated during simulation
  SI.VolumeFlowRate q_flow_a = port_a.m_flow/oil.density(p_a);
  SI.VolumeFlowRate q_flow_b = port_b.m_flow/oil.density(p_b);

  // the variables
  SI.Pressure dp = port_a.p - port_b.p "Pressure drop (negative for pumps)";

  // the media properties
  SI.AbsolutePressure p_a(start=p_init) "Oil properties at the inlet";
  SI.AbsolutePressure p_b(start=p_init) "Oil properties at the inlet";

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a(p(start=p_init))
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  OpenHydraulics.Interfaces.FluidPort port_b(p(start=p_init))
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
equation
  // set the fluid properties (set two state variable for each instance of medium)
  p_a = port_a.p;
  p_b = port_b.p;

end HorizontalTwoPort;
