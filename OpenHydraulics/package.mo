within ;
package OpenHydraulics "A free Modelica library that can be used to model hydraulic components and circuits."
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;
  import Cv = Modelica.Units.Conversions;
  import Modelica.Units.NonSI;

  annotation (
  version="2.0.0",
  versionDate="2022-10-12",
  preferredView="info",
  uses(Modelica(version="4.0.0")),
    Icon(graphics={
        Ellipse(
          extent={{-74,8},{6,-72}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,22},{74,-58}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-34,68},{-70,-14},{2,-14},{-34,68}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{34,82},{-2,0},{70,0},{34,82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
The <code>OpenHydraulics</code> library is a <b>free</b> Modelica package providing
components describing <strong>1-dimensional fluid flow</strong> in hydraulic circuits.
</p>
</html>"));
end OpenHydraulics;
