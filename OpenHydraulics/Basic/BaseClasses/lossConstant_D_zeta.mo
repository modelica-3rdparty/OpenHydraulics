within OpenHydraulics.Basic.BaseClasses;
function lossConstant_D_zeta "Return the loss constant 8*zeta/(pi^2*D^4)"

  input SI.Diameter D "Diameter at port_a or port_b";
  input Real zeta
    "Constant pressure loss factor with respect to D (i.e., either port_a or port_b)";
  output Real kinv "Loss constant (= pi^2*D^4/(8*zeta))";
algorithm
  kinv := Modelica.Constants.pi*Modelica.Constants.pi*D*D*D*D/(8*zeta);
end lossConstant_D_zeta;
