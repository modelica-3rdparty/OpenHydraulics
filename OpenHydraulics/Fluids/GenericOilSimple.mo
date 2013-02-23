within OpenHydraulics.Fluids;
model GenericOilSimple "Template for Fluid Model"

  extends OpenHydraulics.Fluids.BaseClasses.PartialFluid(final oilName="GenericOilSimple");

  // Constants to be set in actual Medium
  constant SI.AbsolutePressure p0=101325
    "Reference pressure of Medium: default 1 atmosphere";
  constant SI.Temperature T0=273.15 "reference Temperature";

  /*
   * update the following model for specific Oils
   */
  redeclare final function extends density
    "Return density as a function of p and T"
  algorithm
    //   for some reason OpenModelica doesn't like this expression... will try to make it constant
    d := 870 + 5e-7*(p-p0);
    //    d := 870;
    annotation (smoothOrder=2);
  end density;

  redeclare final function extends dynamicViscosity
  algorithm
    eta := 0.036;
    annotation (smoothOrder=2);
  end dynamicViscosity;

annotation (
  Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Simple Linear Fluid Model</font></h3>
<p>
Oil model that includes temperature and pressure dependence for density and dynamic viscosity.
</p>
</HTML>"));
end GenericOilSimple;
