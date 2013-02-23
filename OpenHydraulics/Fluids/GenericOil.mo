within OpenHydraulics.Fluids;
model GenericOil "Generic Oil model"

  extends OpenHydraulics.Fluids.BaseClasses.PartialFluid(final oilName="GenericOil");

  // Constants to be set in actual Medium
  constant SI.AbsolutePressure p0=101325
    "Reference pressure of Medium: default 1 atmosphere";
  constant SI.Temperature T0=273.15 "reference Temperature";

  /*
   * update the following model for specific Oils
   */

  redeclare final function extends density
    "Return density as a function of p and T (Tait equation)"
  protected
   SI.BulkModulus K0 "Temperature-dependent bulk modulus";
   constant SI.BulkModulus K00 = 8.4e9 "Bulk modulus at 0K";
   constant Real K0prime = 10.9 "Constant in Tait equation";
   constant Real betaK(final unit="1/K")=0.0058 "Temp coefficient";
   constant Real aV(final unit="1/K")=7.7e-4 "Therm. exp. coef.";
   constant Density d0 = 870 "Reference density at p0 and T0";
  algorithm
   K0 := K00*Modelica.Math.exp(-betaK*T);
   d  := d0/(1+aV*(T-T0))/
         (1-Modelica.Math.log(1+p*(1+K0prime)/K0)/(1+K0prime));
  end density;

  redeclare final function extends dynamicViscosity
    constant Real A = 9.32;
    constant Real B = 3.65;
    // approximately an ISO VG 46 oil
  algorithm
    // this viscosity model is based on the Walther equation for kinematic
    // viscosity (from ASTM D341): log(log(v + 0.7)) = A - B log T
    //    v is the kinematic viscosity in cSt
    //    T is the temperature in K
    //    log is base 10 log
    // translated into SI units and multiplied by the density, we get:
    eta := (10^(10^(A-B*Modelica.Math.log10(Toperating)))-0.7)*1e-6*density(p);
    annotation (smoothOrder=2);
  end dynamicViscosity;

annotation (
  Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Generic Oil Model</font></h3>
<p>
Oil model that includes temperature and pressure dependence for density and dynamic viscosity.
</p>
</HTML>"));
end GenericOil;
