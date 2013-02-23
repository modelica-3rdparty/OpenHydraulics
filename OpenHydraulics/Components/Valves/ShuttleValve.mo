within OpenHydraulics.Components.Valves;
model ShuttleValve

  // sizing parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 1e6 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing",group="Nominal values"));
  parameter SI.Density d_nom = 850 "Nominal fluid density for metering curve"
    annotation(Dialog(tab="Sizing",group="Nominal values"));

  // dynamic parameters
  parameter SI.Time timeConstant=0.001 "Time constant of dynamic response"
    annotation(Dialog(tab="Dynamics"));
  parameter SI.Pressure dp_hyst(min=1)=1000
    "Deadband to avoid chattering; switch when |dp|>dp_hyst"
    annotation(Dialog(tab="Dynamics"));

  OpenHydraulics.Interfaces.FluidPort PortA
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort PortB
    annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
  OpenHydraulics.Interfaces.FluidPort PortC
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}},
          rotation=0)));
  OpenHydraulics.Basic.VarPressureSource pressC
    annotation (Placement(transformation(
        origin={0,-50},
        extent={{-10,-10},{10,10}},
        rotation=180)));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;
  OpenHydraulics.Basic.ConstVolumeSource noFlowA(q=0)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}},
          rotation=0)));
  OpenHydraulics.Basic.ConstVolumeSource noFlowB(q=0)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}},
          rotation=0)));
equation
  pressC.control = max(PortA.p,PortB.p);

  connect(pressC.port, PortC)            annotation (Line(points={{-1.22465e-015,
          -60},{0,-60},{0,-80}},               color={255,0,0}));

  connect(PortA, noFlowA.port) annotation (Line(points={{-100,0},{-50,0},{
          -50,-20}}, color={255,0,0}));
  connect(PortB, noFlowB.port) annotation (Line(points={{100,0},{50,0},{50,
          -20}}, color={255,0,0}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-88,44},{88,-48}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{26,24},{53,0},{26,-24}}, color={0,0,0}),
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
        Line(points={{-26,24},{-54,0},{-26,-24}}, color={0,0,0}),
        Ellipse(
          extent={{-3,3},{3,-3}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,0}}, color={0,0,0}),
        Line(points={{100,0},{-100,0}}, color={0,0,0}),
        Ellipse(
          extent={{18,14},{46,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-60,28},{60,-28}}, lineColor={0,0,0}),
        Text(
          extent={{-4,-38},{38,-78}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="C")}));
end ShuttleValve;
