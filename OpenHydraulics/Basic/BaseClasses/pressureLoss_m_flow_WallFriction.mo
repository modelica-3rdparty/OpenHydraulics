within OpenHydraulics.Basic.BaseClasses;
function pressureLoss_m_flow_WallFriction
  "Return pressure drop from constant loss factor, mass flow rate and Re (dp = f(m_flow))"
  extends Modelica.Icons.Function;
  input SI.MassFlowRate m_flow "Mass flow rate from port_a to port_b";
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
  output SI.Pressure dp "Pressure drop (dp = port_a.p - port_b.p)";

protected
    constant Real pi = Modelica.Constants.pi;
    Real Delta = roughness/diameter "Relative roughness";
    SI.ReynoldsNumber Re1 = 745*Modelica.Math.exp(if Delta <= 0.0065 then 1 else 0.0065/Delta)
    "Re leaving laminar curve";
    SI.ReynoldsNumber Re2 = 4000 "Re entering turbulent curve";
    SI.DynamicViscosity eta "Upstream viscosity";
    SI.Density d "Upstream density";
    SI.ReynoldsNumber Re "Reynolds number";
    Real lambda2 "Modified friction coefficient (= lambda*Re^2)";

    function interpolateInRegion2
       input SI.ReynoldsNumber Re;
       input SI.ReynoldsNumber Re1;
       input SI.ReynoldsNumber Re2;
       input Real Delta;
       output Real lambda2;
       // point lg(lambda2(Re1)) with derivative at lg(Re1)
  protected
      Real x1 = Modelica.Math.log10(Re1);
      Real y1 = Modelica.Math.log10(64*Re1);
      Real yd1=1;

      // Point lg(lambda2(Re2)) with derivative at lg(Re2)
      Real aux1=(0.5/Modelica.Math.log(10))*5.74*0.9;
      Real aux2=Delta/3.7 + 5.74/Re2^0.9;
      Real aux3=Modelica.Math.log10(aux2);
      Real L2=0.25*(Re2/aux3)^2;
      Real aux4=2.51/sqrt(L2) + 0.27*Delta;
      Real aux5=-2*sqrt(L2)*Modelica.Math.log10(aux4);
      Real x2 =  Modelica.Math.log10(Re2);
      Real y2 =  Modelica.Math.log10(L2);
      Real yd2 = 2 + 4*aux1/(aux2*aux3*(Re2)^0.9);

      // Constants: Cubic polynomial between lg(Re1) and lg(Re2)
      Real diff_x=x2 - x1;
      Real m=(y2 - y1)/diff_x;
      Real c2=(3*m - 2*yd1 - yd2)/diff_x;
      Real c3=(yd1 + yd2 - 2*m)/(diff_x*diff_x);
      Real dx;
    algorithm
       dx := Modelica.Math.log10(Re/Re1);
       lambda2 := 64*Re1*(Re/Re1)^(1 + dx*(c2 + dx*c3));
       annotation(smoothOrder=1);
    end interpolateInRegion2;
algorithm
    // Determine upstream density and upstream viscosity
    d       :=if m_flow >= 0 then d_a else d_b;
    eta     :=if m_flow >= 0 then eta_a else eta_b;

    // Determine Re, lambda2 and pressure drop
    Re :=(4/pi)*abs(m_flow)/(diameter*eta);
    lambda2 := if Re <= Re1 then 64*Re else
              (if Re >= Re2 then 0.25*(Re/Modelica.Math.log10(Delta/3.7 + 5.74/Re^0.9))^2 else
               interpolateInRegion2(Re, Re1, Re2, Delta));
    dp :=length*eta*eta/(2*d*diameter*diameter*diameter)*
         (if m_flow >= 0 then lambda2 else -lambda2);
    annotation (smoothOrder=1);
end pressureLoss_m_flow_WallFriction;
