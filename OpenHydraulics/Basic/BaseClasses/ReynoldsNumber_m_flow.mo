within OpenHydraulics.Basic.BaseClasses;
function ReynoldsNumber_m_flow
  "Return Reynolds number as a function of mass flow rate m_flow"

  input SI.MassFlowRate m_flow "Mass flow rate";
  input SI.DynamicViscosity eta "Dynamic viscosity of medium";
  input SI.Diameter diameter "Diameter of pipe/orifice";
  output SI.ReynoldsNumber Re "Reynolds number";
algorithm
  Re :=abs(m_flow)*(4/Modelica.Constants.pi)/(diameter*eta);
end ReynoldsNumber_m_flow;
