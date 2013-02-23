within OpenHydraulics.Interfaces;
connector FluidPort
  "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"

SI.AbsolutePressure p(stateSelect = StateSelect.prefer)
    "Pressure in the connection point";
flow SI.MassFlowRate m_flow(start=0)
    "Mass flow rate from the connection point into the component";

annotation (defaultComponentName="port",
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics={
      Ellipse(
        extent={{-40,40},{40,-40}},
        lineColor={255,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{-40,40},{40,-40}},
        lineColor={0,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-160,110},{40,50}},
        lineColor={255,0,0},
        textString="%name")}),
     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics={Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={255,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid), Ellipse(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid)}));
end FluidPort;
