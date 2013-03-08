within OpenHydraulics.Basic;
model FluidPower2MechTrans

  // parameterization and initialization are kept to minimum
  // the user of this basic building block is expected to be
  // familiar with its use

  parameter SI.Area A = 0.01 "Area of piston"
    annotation(Dialog(tab="Sizing"));
  parameter SI.AbsolutePressure maxPressure = 3e7 "Maximum rated pressure"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Volume residualVolume = 1e-6 "Volume remaining when s_rel<=0"
    annotation(Dialog(tab="Sizing"));
  parameter Real stopStiffness(
    final unit="N/m",
    final min=0) = maxPressure*A*A/residualVolume
    "stiffness when chamber becomes empty"
    annotation(Dialog(tab="Dynamics"));
  parameter Real stopDamping(
    final unit="N.s/m",
    final min=-1000) = stopStiffness/10 "damping when chamber becomes empty"
    annotation(Dialog(tab="Dynamics"));
  // note: the default stiffness is such that the residual volume is reduced by
  // at most 10 percent

  SI.Volume V(start=residualVolume) "Volume of oil inside chamber";
  SI.Mass m(start=residualVolume*oil.density(p_init))
    "Mass of oil inside chamber";
  SI.Power Wmech "Mechanical work performed onto chamber";
  SI.Velocity v_rel(start=0) "relative velocity";

  // the media properties
  SI.AbsolutePressure p_vol(start=p_init) "Oil pressure in the chamber";

  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
  extends OpenHydraulics.Interfaces.NPort;
protected
  parameter SI.Position s_relMin = -0.001
    "the s_rel value at which the volume is zero";
  Boolean empty "true when chamber reaches end of travel";
  SI.Force f_stop "contact force when chamber is empty";
  SI.Force f_damping "damping force when chamber is empty";
  SI.Force f_contact "contact force when the end of travel is reached";

algorithm
  assert(V>0,"Volume in fluid chamber is negative or zero.\n"+
              "Increase the residualVolume or the stopStiffness");
  assert(p_vol<maxPressure or s_rel<0,"Maxiumum pressure in chamber has been exceeded");
  assert(not empty, "CylinderChamber has reached end of travel.\n\tThis could cause erratic behavior of the simulation.\n\t(time = "+String(time)+")", AssertionLevel.warning);

equation
  // medium equations
  // the pressure is the same everywhere
  for i in 1:n_ports loop
    p_vol = p[i];
  end for;

  // state of the volume
  V = max(s_rel,0)*A + residualVolume;
  m = V*oil.density(p_vol);

  v_rel = der(s_rel);
  empty = s_rel<0;

  // energy flows: work done by fluid
  Wmech = v_rel*(f + f_contact);

  // force equilibrium
  0 = A*(p_vol - environment.p_ambient) + f_contact + f;

  // NOTE: the nonlinear spring force is most likely not physically accurate
  // but since impact is such a complex phenomenon, most other models would not be
  // accurate either.  The advantage of this model is that it is stable and smooth.
  if empty then
     f_stop = -stopStiffness*s_rel*(s_relMin/(s_relMin-s_rel)); // nonlinear spring force
     f_damping = -stopDamping*v_rel; // damper force
     f_contact = if (f_stop+f_damping <= 0) then 0 else f_stop+f_damping;
  else
     f_stop = 0; // spring force
     f_damping = 0; // damper force
     f_contact = 0;
  end if;

  // conservation of mass
  der(m) = sum(port.m_flow);

  annotation (Diagram(graphics={
        Rectangle(extent={{-80,40},{80,-40}}, lineColor={0,0,0}),
        Rectangle(
          extent={{100,4},{40,-4}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,40},{30,-40}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{-30,-40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,4},{-100,-4}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,16},{16,-16}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                                         Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,4},{44,-4}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{34,39},{44,-39}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,40},{34,-40}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,39},{-34,-39}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,4},{-100,-4}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,100},{0,60}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Ellipse(
          extent={{-16,16},{16,-16}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end FluidPower2MechTrans;
