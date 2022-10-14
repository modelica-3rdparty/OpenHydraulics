within OpenHydraulics.Basic.BaseClasses;
function pressureLoss_m_flow
  "Return pressure drop from constant loss factor and mass flow rate (dp = f(m_flow))"
  extends Modelica.Icons.Function;
  input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
  input SI.Density d_a "Density at port_a";
  input SI.Density d_b "Density at port_b";
  input LossFactorData data "Constant loss factors for both flow directions";
  input SI.MassFlowRate m_flow_small = 0.01
    "Turbulent flow if |m_flow| >= m_flow_small";
  output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

algorithm
  /*
   dp = 0.5*zeta*d*v*|v|
      = 0.5*zeta*d*1/(d*A)^2 * m_flow * |m_flow|
      = 0.5*zeta/A^2 *1/d * m_flow * |m_flow|
      = k/d * m_flow * |m_flow|
   k  = 0.5*zeta/A^2
      = 0.5*zeta/(pi*(D/2)^2)^2
      = 8*zeta/(pi*D^2)^2
  */
dp := Modelica.Fluid.Utilities.regSquare2(
        m_flow,
        m_flow_small,
        1/(d_a*data.kinv1),
        1/(d_b*data.kinv2));
  annotation (smoothOrder=1, Documentation(info="<html>
<p>
Compute pressure drop from constant loss factor and mass flow rate (dp = f(m_flow)).
For small mass flow rates(|m_flow| &lt; m_flow_small), the characteristic is approximated by
a polynomial in order to have a finite derivative at zero mass flow rate.
</p>
</html>"));
end pressureLoss_m_flow;
