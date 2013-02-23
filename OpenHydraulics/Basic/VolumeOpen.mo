within OpenHydraulics.Basic;
model VolumeOpen "An open constant-pressure volume"

  // main parameters
  parameter SI.Volume V_max = 1 "Tank Volume"
    annotation(Dialog(tab="Sizing"));
  parameter SI.AbsolutePressure p_const = environment.p_ambient
    "preload pressure"
    annotation(Dialog(tab="Initialization"));
  parameter SI.Volume V_init = 0.1 "Initial Volume" annotation(Dialog(tab="Initialization"));

  // the variables
  SI.Volume V_actual "Volume size";
  SI.Mass m = V_actual*oil.density(p_vol) "Mass of fluid";
  SI.AbsolutePressure p_vol(start=p_init) "Pressure in the volume";

  extends OpenHydraulics.Interfaces.NPort(n_ports=1);

protected
  parameter SI.Mass m_init = V_init*oil.density(p_init) "Guess initial mass";
initial equation
  V_actual = V_init;
equation
  assert(V_actual<V_max,"Volume has exceeded limit");
  p_vol = p_const;

  // the pressures are equal throughout the volume
  for i in 1:n_ports loop
    p[i] = p_vol;
  end for;

  // Mass balances
  der(m) = sum(port.m_flow) "Mass balance";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,0,0}),
        Text(
          extent={{-100,100},{100,60}},
          lineColor={0,0,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Ellipse(
          extent={{-30,30},{30,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,60},{-60,-60},{60,-60},{60,60}}, color={0,0,0})}),
                                     Diagram(graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,0,0}),
        Ellipse(
          extent={{-30,30},{30,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,60},{-60,-60},{60,-60},{60,60}}, color={0,0,0})}));
end VolumeOpen;
