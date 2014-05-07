within OpenHydraulics.Basic.BaseClasses;
function massFlowRate_dp
  "Return mass flow rate from constant loss factor data and pressure drop (m_flow = f(dp))"

  input SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";
  input SI.Density d_a "Density at port_a";
  input SI.Density d_b "Density at port_b";
  input LossFactorData data "Constant loss factors for both flow directions";
  input SI.AbsolutePressure dp_small = 1 "Turbulent flow if |dp| >= dp_small";
  output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";

algorithm
  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   kinv = 1/k;
  */
m_flow := OpenHydraulics.Utilities.regRoot2(
        dp,
        dp_small,
        d_a*data.kinv1,
        d_b*data.kinv2);
  annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute mass flow rate from constant loss factor and pressure drop (m_flow = f(dp)).
For small pressure drops (dp &lt; dp_small), the characteristic is approximated by
a polynomial in order to have a finite derivative at zero mass flow rate.
</p>
</html>"));
end massFlowRate_dp;
