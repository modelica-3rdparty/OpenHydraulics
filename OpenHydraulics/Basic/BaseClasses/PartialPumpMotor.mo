within OpenHydraulics.Basic.BaseClasses;
partial model PartialPumpMotor "Partial model for displacement pumps or motors"

  // the variables
  SI.Volume D "Pump displacement";
  // the rotational variables
  SI.AngularVelocity omega "Shaft angular velocity";
  NonSI.AngularVelocity_rpm N=Cv.to_rpm(omega) "Shaft rotational speed";
  SI.Torque tau "Torque needed for pumping fluid";
  SI.Power Wmech "Mechanical power applied to fluid";

  extends PumpMotorInterface;

equation
  // rotational equations
  omega = der(phi);
  tau = flange_a.tau + flange_b.tau;
  Wmech = omega*tau "Mechanical work";

  // relate torque to pressure
  tau = -D*dp/(2*Modelica.Constants.pi);

  // relate flow to rotational velocity
  q_flow_a = D*N/60;

  // mass balance
  0 = port_a.m_flow + port_b.m_flow "Mass balance";

  // energy balance
//  0 = port_a.H_flow + port_b.H_flow + Wmech "Energy balance";

end PartialPumpMotor;
