within OpenHydraulics.Basic.BaseClasses;
function pressureLoss_m_flow_and_Re
  "Return pressure drop from constant loss factor, mass flow rate and Re (dp = f(m_flow))"
  extends Modelica.Icons.Function;
  input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
  input SI.Density d_a "Density at port_a";
  input SI.Density d_b "Density at port_b";
  input SI.DynamicViscosity eta_a "Dynamic viscosity at port_a";
  input SI.DynamicViscosity eta_b "Dynamic viscosity at port_b";
  input LossFactorData data "Constant loss factors for both flow directions";
  output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

  import Modelica.Constants.pi;
protected
  Real k0 = 2*data.c0/(pi*data.D_Re^3);
  Real yd0 "Derivative of dp = f(m_flow) at zero, if data.zetaLaminarKnown";
  SI.MassFlowRate m_flow_turbulent
    "The turbulent region is: |m_flow| >= m_flow_turbulent";
algorithm
/*
Turbulent region:
   Re = m_flow*(4/pi)/(D_Re*eta)
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
   m_flow_turbulent = (pi/4)*D_Re*eta*Re_turbulent
   dp_turbulent     =  k/d *(D_Re*eta*pi/4)^2 * Re_turbulent^2

   The start of the turbulent region is computed with mean values
   of dynamic viscosity eta and density rho. Otherwise, one has
   to introduce different "delta" values for both flow directions.
   In order to simplify the approach, only one delta is used.

Laminar region:
   dp = 0.5*zeta/(A^2*d) * m_flow * |m_flow|
      = 0.5 * c0/(|m_flow|*(4/pi)/(D_Re*eta)) / ((pi*(D_Re/2)^2)^2*d) * m_flow*|m_flow|
      = 0.5 * c0*(pi/4)*(D_Re*eta) * 16/(pi^2*D_Re^4*d) * m_flow*|m_flow|
      = 2*c0/(pi*D_Re^3) * eta/d * m_flow
      = k0 * eta/d * m_flow
   k0 = 2*c0/(pi*D_Re^3)

   In order that the derivative of dp=f(m_flow) is continuous
   at m_flow=0, the mean values of eta and d are used in the
   laminar region: eta/d = (eta_a + eta_b)/(d_a + d_b)
   If data.zetaLaminarKnown = false then eta_a and eta_b are potentially zero
   (because dummy values) and therefore the division is only performed
   if zetaLaminarKnown = true.
*/
  m_flow_turbulent :=(pi/8)*data.D_Re*(eta_a + eta_b)*data.Re_turbulent;
  yd0 :=if data.zetaLaminarKnown then k0*(eta_a + eta_b)/(d_a + d_b) else 0;
dp := Modelica.Fluid.Utilities.regSquare2(
        m_flow,
        m_flow_turbulent,
        1/(d_a*data.kinv1),
        1/(d_b*data.kinv2),
        data.zetaLaminarKnown,
        yd0);
  annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute pressure drop from constant loss factor and mass flow rate (dp = f(m_flow)).
If the Reynolds-number Re &ge; data.Re_turbulent, the flow
is treated as a turbulent flow with constant loss factor zeta.
If the Reynolds-number Re &lt; data.Re_turbulent, the flow
is laminar and/or in a transition region between laminar and
turbulent. This region is approximated by two
polynomials of third order, one polynomial for m_flow &ge; 0
and one for m_flow &lt; 0.
The common derivative
of the two polynomials at Re = 0 is
computed from the equation \"data.c0/Re\".
</p>
<p>
If no data for c0 is available, the derivative at Re = 0 is computed in such
a way, that the second derivatives of the two polynomials
are identical at Re = 0. The polynomials are constructed, such that
they smoothly touch the characteristic curves in the turbulent
regions. The whole characteristic is therefore <b>continuous</b>
and has a <b>finite</b>, <b>continuous first derivative everywhere</b>.
In some cases, the constructed polynomials would \"vibrate\". This is
avoided by reducing the derivative at Re=0 in such a way that
the polynomials are guaranteed to be monotonically increasing.
The used sufficient criteria for monotonicity follows from:
</p>

<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>"));
end pressureLoss_m_flow_and_Re;
