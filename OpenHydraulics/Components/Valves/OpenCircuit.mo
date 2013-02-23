within OpenHydraulics.Components.Valves;
model OpenCircuit "Open connection for use in reconfigurable components"
  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  // main variables
  SI.Pressure dp = port_a.p - port_b.p "Pressure drop from port_a to port_b";
  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}},
          rotation=0)));

  OpenHydraulics.Basic.ConstVolumeSource noFlowA(q=0)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}},
          rotation=0)));
  OpenHydraulics.Basic.ConstVolumeSource noFlowB(q=0)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}},
          rotation=0)));
equation
  // flow is zero
  port_a.m_flow = 0;
  port_b.m_flow = 0;

  connect(port_a, noFlowA.port) annotation (Line(points={{-100,0},{-50,0},{
          -50,-20}}, color={255,0,0}));
  connect(noFlowB.port, port_b) annotation (Line(points={{50,-20},{50,0},{
          100,0}}, color={255,0,0}));
  annotation (
    Diagram(graphics={Text(
          extent={{-90,40},{-60,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "A"), Text(
          extent={{60,40},{90,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "B")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-88,44},{88,-48}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-100,0}}, color={0,0,0}),
        Line(points={{100,0},{40,0}}, color={0,0,0}),
        Text(
          extent={{60,40},{90,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-98,40},{-50,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{0,74},{0,44}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(points={{-40,20},{-40,-20}}, color={0,0,0}),
        Line(points={{40,20},{40,-20}}, color={0,0,0})}),
    DymolaStoredErrors);
end OpenCircuit;
