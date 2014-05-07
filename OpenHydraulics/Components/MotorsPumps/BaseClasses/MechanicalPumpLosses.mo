within OpenHydraulics.Components.MotorsPumps.BaseClasses;
model MechanicalPumpLosses "Coulomb and viscous friction in pump "
  extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport;

  parameter Real Cv = 0.1 "Coefficient of viscous drag";
  parameter Real Cf = 0.01
    "Coefficient of Coulomb friction (fraction of full stroke torque)";
  parameter SI.Volume Dmax = 1e-4 "Full stroke pump Displacement";
  parameter SI.DynamicViscosity mu = 0.036 "Dynamic Viscosity of liquid";

  extends Modelica.Mechanics.Rotational.Interfaces.PartialFriction;

  SI.Torque tau;
  SI.Angle phi;
  SI.AngularVelocity w "Absolute angular velocity of flange_a and flange_b";
  SI.AngularAcceleration a
    "Absolute angular acceleration of flange_a and flange_b";
protected
  parameter Real b = Cv*Dmax*mu "Viscous friction constant";
public
  Modelica.Blocks.Interfaces.RealInput dp
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
equation
  // Constant auxiliary variables
  tau0 = Cf*dp*Dmax;
  tau0_max = tau0;
  free = false;

  phi = flange_a.phi;
  phi = flange_b.phi;

  // Angular velocity and angular acceleration of flanges
  w = der(phi);
  a = der(w);
  w_relfric = w;
  a_relfric = a;

  // Equilibrium of torques
  0 = flange_a.tau + flange_b.tau - tau;

  // Friction torque
  tau = if locked then sa else
            (if startForward then tau0+b*w else
             if startBackward then -tau0+b*w else
             if pre(mode) == Forward then tau0+b*w else
             -tau0+b*w);
  annotation (
    Documentation(info="<html>
<p>
This element describes <b>frictional losses</b> in a <b>hydraulic pump or motor</b>.
</p>
<p>The model is based on the paper:<br>
<dl>
<dt>McCandlish, D., and Dorey, R. E.,
<dd>'The Mathematical Modelling of Hydrostatic Pumps and Motors,'
<i>Proceedings of the Institution of Mechanical Engineers</i>,
Part B, Vol. 198, No. 10, 1984, pp 165-174.
</dl></p>
<p>
The model implementation is derived from the bearing friction
model in the standard Modelica library.
</p>
</html>"),    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-96,20},{96,-21}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-30,-40},{30,-40}}, color={0,0,0}),
        Line(points={{0,-40},{0,-90}}, color={0,0,0}),
        Polygon(
          points={{-30,-20},{60,-20},{60,-80},{70,-80},{50,-100},{30,-80},
              {40,-80},{40,-30},{-30,-30},{-30,-20},{-30,-20}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{30,-50},{20,-60}}, color={0,0,0}),
        Line(points={{30,-40},{10,-60}}, color={0,0,0}),
        Line(points={{20,-40},{0,-60}}, color={0,0,0}),
        Line(points={{10,-40},{-10,-60}}, color={0,0,0}),
        Line(points={{0,-40},{-20,-60}}, color={0,0,0}),
        Line(points={{-10,-40},{-30,-60}}, color={0,0,0}),
        Line(points={{-20,-40},{-30,-50}}, color={0,0,0}),
        Text(extent={{-150,80},{150,40}}, textString="%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-96,20},{96,-21}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(points={{-30,-40},{30,-40}}, color={0,0,0}),
        Line(points={{0,60},{0,40}}, color={0,0,0}),
        Line(points={{-30,40},{29,40}}, color={0,0,0}),
        Line(points={{0,-40},{0,-90}}, color={0,0,0}),
        Polygon(
          points={{-30,-20},{60,-20},{60,-80},{70,-80},{50,-100},{30,-80},
              {40,-80},{40,-30},{-30,-30},{-30,-20},{-30,-20}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{16,83},{84,70}},
          lineColor={128,128,128},
          textString="rotation axis"),
        Polygon(
          points={{12,76},{-8,81},{-8,71},{12,76}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Line(points={{-78,76},{-7,76}}, color={128,128,128}),
        Line(points={{30,-50},{20,-60}}, color={0,0,0}),
        Line(points={{30,-40},{10,-60}}, color={0,0,0}),
        Line(points={{20,-40},{0,-60}}, color={0,0,0}),
        Line(points={{10,-40},{-10,-60}}, color={0,0,0}),
        Line(points={{0,-40},{-20,-60}}, color={0,0,0}),
        Line(points={{-10,-40},{-30,-60}}, color={0,0,0}),
        Line(points={{-20,-40},{-30,-50}}, color={0,0,0})}));
end MechanicalPumpLosses;
