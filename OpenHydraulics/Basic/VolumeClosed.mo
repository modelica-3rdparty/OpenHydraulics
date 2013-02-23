within OpenHydraulics.Basic;
model VolumeClosed "A constant compressible volume"

  // main parameters
  parameter SI.Volume V = 1e-6 "Nominal volume size (at atmospheric pressure)"
    annotation(Dialog(tab="Sizing"));
  parameter Boolean compressible = true
    "=true if encclosure volume depends on pressure"
    annotation(Evaluate=true,Dialog(tab="Sizing"));
  parameter SI.BulkModulus volBulkMod = 1e7 "Bulk Modulus of the enclosure"
    annotation(Dialog(tab="Sizing",enable=compressible));

  // the variables
  SI.Volume V_actual "Volume size";
  SI.Mass m = V_actual*oil.density(p_vol) "Mass of fluid";
  SI.AbsolutePressure p_vol(start=p_init) "Pressure in the volume";

  extends OpenHydraulics.Interfaces.NPort(n_ports=1);

equation
  V_actual = V + (if compressible then V*(p_vol - environment.p_ambient)/volBulkMod else 0);

  // the pressures are equal throughout the volume
  for i in 1:n_ports loop
    p[i] = p_vol;
  end for;

  // Mass balances
  if V>0 then
    der(m) = sum(port.m_flow);
  else
    0 = sum(port.m_flow);
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
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
          fillPattern=FillPattern.Solid)}),
                                         Diagram(graphics={Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,0,0}), Ellipse(
          extent={{-30,30},{30,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}));
end VolumeClosed;
