within OpenHydraulics.Fluids.BaseClasses;
partial model PartialFluid "Partial fluid model for FluidPower library"

  parameter String oilName = "PartialFluid";

  parameter SI.Temperature Toperating= 293.15
    "Operating temperature of the oil";
//  parameter SI.

  constant SI.Temperature T0=273.15 "Reference temperature";
  constant SI.AbsolutePressure p0 = 101325 "Reference pressure";

  replaceable function density "Return density as a function of p and T"
    extends Modelica.Icons.Function;
    input SI.AbsolutePressure p;
    output SI.Density d;
  end density;

  replaceable function dynamicViscosity
    extends Modelica.Icons.Function;
    input SI.AbsolutePressure p;
    output SI.DynamicViscosity eta;
  end dynamicViscosity;

  replaceable function approxBulkModulus
    "Bulk modulus to be used in approximate calculation; otherwise use density"
    extends Modelica.Icons.Function;

    input SI.AbsolutePressure p;
    output SI.BulkModulus B;
  algorithm
    B := if (density(p+1000)==density(p))
         then 1e9 else 1000/(density(p + 1000)/density(p) - 1);
  end approxBulkModulus;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(
          extent={{-74,20},{6,-60}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-34,80},{-70,-2},{2,-2},{-34,80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{2,-2},{-34,80},{-70,-2}}, color={0,0,0}),
        Ellipse(
          extent={{-6,34},{74,-46}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{34,94},{-2,12},{70,12},{34,94}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{70,12},{34,94},{-2,12}}, color={0,0,0}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Text(
          extent={{0,-60},{0,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          textString="%name")}));

end PartialFluid;
