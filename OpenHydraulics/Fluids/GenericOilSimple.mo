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
    extends Modelica.Icons.Function;

  algorithm
    //   for some reason OpenModelica doesn't like this expression... will try to make it constant
    d := 870 + 5e-7*(p-p0);
    //    d := 870;
    annotation (smoothOrder=2);
  end density;

  redeclare final function extends dynamicViscosity
    extends Modelica.Icons.Function;

  algorithm
    eta := 0.036;
    annotation (smoothOrder=2);
  end dynamicViscosity;

annotation (
  Documentation(info="<html>
<h4>Simple Linear Fluid Model</h4>
<p>
Oil model that includes temperature and pressure dependence for density and dynamic viscosity.
</p>
</html>"));
end GenericOilSimple;
