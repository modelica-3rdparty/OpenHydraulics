within OpenHydraulics.Basic.BaseClasses;
function massFlowRate_dp_WallFriction
  "Return mass flow rate from constant loss factor data, pressure drop and Re (m_flow = f(dp))"
  extends Modelica.Icons.Function;
  input SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";
  input SI.Density d_a "Density at port_a";
  input SI.Density d_b "Density at port_b";
  input SI.DynamicViscosity eta_a
    "Dynamic viscosity at port_a (dummy if use_eta = false)";
  input SI.DynamicViscosity eta_b
    "Dynamic viscosity at port_b (dummy if use_eta = false)";
  input SI.Length length "Length of pipe";
  input SI.Diameter diameter "Inner (hydraulic) diameter of pipe";
  input SI.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe, with a default for a smooth steel pipe";
  output SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";

protected
  constant Real pi = Modelica.Constants.pi;
  Real Delta = roughness/diameter "Relative roughness";
  SI.ReynoldsNumber Re1 = (745*Modelica.Math.exp(if Delta <= 0.0065 then 1 else 0.0065/Delta))^0.97
    "Re leaving laminar curve";
  SI.ReynoldsNumber Re2 = 4000 "Re entering turbulent curve";
  SI.DynamicViscosity eta "Upstream viscosity";
  SI.Density d "Upstream density";
  SI.ReynoldsNumber Re "Reynolds number";
  Real lambda2 "Modified friction coefficient (= lambda*Re^2)";

  function interpolateInRegion2
     input Real Re_turbulent;
     input SI.ReynoldsNumber Re1;
     input SI.ReynoldsNumber Re2;
     input Real Delta;
     input Real lambda2;
     output SI.ReynoldsNumber Re;
    // point lg(lambda2(Re1)) with derivative at lg(Re1)
  protected
    Real x1=Modelica.Math.log10(64*Re1);
    Real y1=Modelica.Math.log10(Re1);
    Real yd1=1;

    // Point lg(lambda2(Re2)) with derivative at lg(Re2)
    Real aux1=(0.5/Modelica.Math.log(10))*5.74*0.9;
    Real aux2=Delta/3.7 + 5.74/Re2^0.9;
    Real aux3=Modelica.Math.log10(aux2);
    Real L2=0.25*(Re2/aux3)^2;
    Real aux4=2.51/sqrt(L2) + 0.27*Delta;
    Real aux5=-2*sqrt(L2)*Modelica.Math.log10(aux4);
    Real x2=Modelica.Math.log10(L2);
    Real y2=Modelica.Math.log10(aux5);
    Real yd2=0.5 + (2.51/Modelica.Math.log(10))/(aux5*aux4);

    // Constants: Cubic polynomial between lg(Re1) and lg(Re2)
    Real diff_x=x2 - x1;
    Real m=(y2 - y1)/diff_x;
    Real c2=(3*m - 2*yd1 - yd2)/diff_x;
    Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
    Real lambda2_1=64*Re1;
    Real dx;
  algorithm
     dx := Modelica.Math.log10(lambda2/lambda2_1);
     Re := Re1*(lambda2/lambda2_1)^(1 + dx*(c2 + dx*c3));
     annotation(smoothOrder=1);
  end interpolateInRegion2;

algorithm
  // Determine upstream density, upstream viscosity, and lambda2
  d       := if dp >= 0 then d_a else d_b;
  eta     := if dp >= 0 then eta_a else eta_b;
  lambda2 := abs(dp)*2*diameter^3*d/(length*eta*eta);

  // Determine Re under the assumption of laminar flow
  Re := lambda2/64;

  // Modify Re, if turbulent flow
  if Re > Re1 then
     Re :=-2*sqrt(lambda2)*Modelica.Math.log10(2.51/sqrt(lambda2) + 0.27*Delta);
     if Re < Re2 then
        Re := interpolateInRegion2(Re, Re1, Re2, Delta, lambda2);
     end if;
  end if;

  // Determine mass flow rate
  m_flow := (pi*diameter/4)*eta*(if dp >= 0 then Re else -Re);
end massFlowRate_dp_WallFriction;
