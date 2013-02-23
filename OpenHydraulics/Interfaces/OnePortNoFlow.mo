within OpenHydraulics.Interfaces;
partial model OnePortNoFlow
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // the ports
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
          rotation=0)));

equation
  // balance equations
  port_a.m_flow = 0;

end OnePortNoFlow;
