within OpenHydraulics.Types;
type FlowDirection = enumeration(
    Unidirectional "Fluid flows only from port_a to port_b",
    Bidirectional "No restrictions on fluid flow (flow reversal possible)")
  "Initialization of flow direction for fluid power components";
