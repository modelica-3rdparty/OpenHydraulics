within OpenHydraulics.Interfaces;
partial model PartialFluidComponent
  "Base model for any component involving fluid"

  outer OpenHydraulics.Fluids.BaseClasses.PartialFluid oil
    "This model must be defined in each circuit; the type must be a subtype of PartialFluid";

  parameter SI.AbsolutePressure p_init = environment.p_ambient
    "Initial temperature of the component" annotation (Dialog(tab="Initialization",group="Fluid"));

protected
  outer OpenHydraulics.Circuits.Environment environment;

end PartialFluidComponent;
