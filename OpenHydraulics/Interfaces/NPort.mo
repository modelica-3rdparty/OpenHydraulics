within OpenHydraulics.Interfaces;
partial model NPort "Two horizontally oriented fluid ports"
  // include the base characteristics for ANY fluid two-port
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  outer OpenHydraulics.Fluids.BaseClasses.PartialFluid oil
    "This model must be defined in each circuit; the type must be a subtype of PartialFluid";

  // the connectors
  parameter Integer n_ports(min=1) "Number of ports (min=1)"
    annotation(Dialog(tab="Sizing"));

  OpenHydraulics.Interfaces.FluidPort port[n_ports](m_flow(each start=0), p(
        each start=p_init))
      annotation (Placement(transformation(extent={{-10,-11},{10,10}})));

        // the media properties
  SI.AbsolutePressure p[n_ports](each start=p_init)
    "Oil properties at each port";

equation
  for i in 1:n_ports loop
    // set the fluid properties (set two state variable for each instance of medium)
    p[i] = port[i].p;
  end for;
end NPort;
