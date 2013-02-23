within OpenHydraulics.Types;
type AccInit = enumeration(
    Free "No hard initialization",
    Pressure "Pressure inside accumulator is fixed at initialization",
    Volume "Fluid volume inside accumulator is fixed at initialization")
  "Enumeration defining the types of initialization available for accumulators";
