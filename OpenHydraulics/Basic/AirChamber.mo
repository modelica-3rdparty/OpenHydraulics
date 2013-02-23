within OpenHydraulics.Basic;
model AirChamber
  extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;

  // parameterization and initialization are kept to minimum
  // the user of this basic building block is expected to be
  // familiar with its use

  parameter SI.Area A = 1 "Area of piston";
  parameter SI.AbsolutePressure p_precharge = 1e6 "precharge pressure";
  parameter SI.Volume V_precharge = 0.5 "initial precharge volume";
  parameter SI.Volume residualVolume = 0
    "Volume when chamber is fully compressed";
  parameter Real stopStiffness(
    final unit="N/m",
    final min=0) = 1e9 "stiffness when piston reaches stop";

  parameter Boolean initializePressure = true "true = pressure; false = volume"
    annotation(Dialog(tab="Initialization",evaluate=true));
  parameter SI.AbsolutePressure p_init "Initial pressure"
    annotation(Dialog(tab="Initialization",enable=initializePressure));
  parameter SI.Volume V_init = V_precharge "Initial volume"
    annotation(Dialog(tab="Initialization",enable= not initializePressure));

  SI.AbsolutePressure p(start=p_precharge) "pressure of air in chamber";
  SI.Volume V "Volume of air in chamber";
protected
  outer OpenHydraulics.Circuits.Environment environment;
  Boolean empty "true when chamber is empty";
  SI.Force f_stop "contact force when chamber is empty";
  Real pV "p*V";
initial equation
  if initializePressure then
    p = p_init;
    V = p_precharge*V_precharge/p_init;
  else
    p = p_precharge*V_precharge/V_init;
    V = V_init;
  end if;
equation
  // behavior of the gas: p*V = constant
  // NOTE: needs to be replaced by more sophisticated gas model!
  pV = p*V;
  der(pV) = 0;
  V = s_rel*A + residualVolume;
  0 = A*(p - environment.p_ambient) + f + f_stop;

  // the relation between gas state and cylinder behavior
  empty = s_rel<0;
  f_stop = if empty then -s_rel*stopStiffness-der(s_rel)*10 else 0;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-80,40},{80,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
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
          extent={{-40,40},{-30,-40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,4},{-100,-4}},
          lineColor={0,0,0},
          fillColor={175,175,175},
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
          textString="%name")}));
end AirChamber;
