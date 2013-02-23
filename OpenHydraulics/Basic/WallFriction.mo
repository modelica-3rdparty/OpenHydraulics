within OpenHydraulics.Basic;
model WallFriction

  // the sizing parameters
  parameter SI.Length L "Length of pipe"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Diameter D "Inner (hydraulic) diameter of pipe"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation(Dialog(tab="Sizing"));

  parameter Boolean from_dp = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));

  extends BaseClasses.RestrictionInterface;

equation
  // mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

  // energy balance
//  0 = port_a.H_flow + port_b.H_flow "Energy balance";

  if from_dp then
    port_a.m_flow =
      BaseClasses.massFlowRate_dp_WallFriction(
        dp,
        oil.density(p_a),
        oil.density(p_b),
        oil.dynamicViscosity(p_a),
        oil.dynamicViscosity(p_b),
        L,
        D,
        roughness);
  else
    dp =
      BaseClasses.pressureLoss_m_flow_WallFriction(
        port_a.m_flow,
        oil.density(p_a),
        oil.density(p_b),
        oil.dynamicViscosity(p_a),
        oil.dynamicViscosity(p_b),
        L,
        D,
        roughness);
  end if;

  annotation (Documentation(info="<html>
<p>
This component defines the complete regime of wall friction.
The details are described in the
<a href=\"Modelica://Modelica_Fluid.UsersGuide.ComponentDefinition.WallFriction\">UsersGuide</a>.
The functional relationship of the friction loss factor &lambda; is
displayed in the next figure. Function massFlowRate_dp() defines the \"red curve\"
(\"Swamee and Jain\"), where as function pressureLoss_m_flow() defines the
\"blue curve\" (\"Colebrook-White\"). The two functions are inverses from 
each other and give slightly different results in the transition region
between Re = 1500 .. 4000, in order to get explicit equations without
solving a non-linear equation.
</p>
 
<img src=\"../Images/Components/PipeFriction1.png\">
</html>"));
end WallFriction;
