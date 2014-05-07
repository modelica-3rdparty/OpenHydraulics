within OpenHydraulics.Components.Lines;
model LineNoVolume
  // the sizing parameters
  parameter SI.Length L "Length of pipe"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Diameter D "Inner (hydraulic) diameter of pipe"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation(Dialog(tab="Sizing"));

  parameter Boolean from_dp = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));

  // the components
  Basic.WallFriction wallFriction(
    L=L,
    D=D,
    roughness=roughness,
    from_dp = from_dp)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;
equation
  connect(port_a, wallFriction.port_a) annotation (Line(points={{-100,0},{
          -10,0}}, color={255,0,0}));
  connect(wallFriction.port_b, port_b) annotation (Line(points={{10,0},{100,
          0}}, color={255,0,0}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,6},{100,-6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Text(
          extent={{-100,54},{-70,14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="A"),
        Text(
          extent={{70,54},{100,14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="B"),
        Text(
          extent={{-100,-14},{100,-54}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}),     Diagram(graphics));
end LineNoVolume;
