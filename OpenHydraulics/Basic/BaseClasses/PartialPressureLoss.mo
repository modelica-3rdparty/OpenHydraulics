within OpenHydraulics.Basic.BaseClasses;
partial model PartialPressureLoss
  extends RestrictionInterface;

  parameter Boolean from_dp = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean use_Re = false
    "= true, if turbulent region is defined by Re, otherwise by dp_small or m_flow_small"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter SI.AbsolutePressure dp_small = 1
    "Turbulent flow if |dp| >= dp_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and from_dp));
  parameter SI.MassFlowRate m_flow_small = 0.01
    "Turbulent flow if |m_flow| >= m_flow_small"
    annotation(Dialog(tab="Advanced", enable=not use_Re and not from_dp));

  SI.ReynoldsNumber Re = ReynoldsNumber_m_flow(
        port_a.m_flow,
        (oil.dynamicViscosity(p_a) + oil.dynamicViscosity(p_b))/2,
        data.D_Re) if use_Re "Reynolds number at diameter D_Re";
  SI.Density d_a = oil.density(p_a) "Density at port a";
  SI.Density d_b = oil.density(p_b) "Density at port b";
protected
  LossFactorData data "Data";
initial equation
  assert(data.D_Re>0 or not use_Re,"If D_Re==0 then Re evaluates to infinity");
equation
  // mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

  // NOTE: the smooth and noEvent avoid events being generated.  This is important to
  // avoid going through re-initialization of the solver which sometimes take a significant
  // amount of time.
  if from_dp then
     port_a.m_flow = smooth(1,if noEvent(data.kinv1<=0) or noEvent(data.kinv2<=0) then 0 else
          if use_Re then
                 massFlowRate_dp_and_Re(
                    dp, d_a, d_b,
                    oil.dynamicViscosity(p_a),
                    oil.dynamicViscosity(p_b),
                    data) else
                 massFlowRate_dp(dp, d_a, d_b, data, dp_small));
  else
     assert(not (data.kinv1<=0 or data.kinv2<=0),
       "Pressure drop cannot be determined when restriction is completely closed;  set from_dp=true");
     dp = if use_Re then
             pressureLoss_m_flow_and_Re(
                 port_a.m_flow, d_a, d_b,
                 oil.dynamicViscosity(p_a),
                 oil.dynamicViscosity(p_b),
                 data) else
             pressureLoss_m_flow(port_a.m_flow, d_a, d_b, data, m_flow_small);
  end if;
end PartialPressureLoss;
