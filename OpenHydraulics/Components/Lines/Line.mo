within OpenHydraulics.Components.Lines;
model Line "Short line with one volume and wall friction"

  // sizing parameters
  parameter SI.Length L "Length of line"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Diameter D "Inner (hydraulic) diameter of line"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Length roughness(min=0) = 2.5e-5
    "Absolute roughness of pipe (default = smooth steel pipe)"
    annotation(Dialog(tab="Sizing"));
  parameter SI.BulkModulus lineBulkMod = 1e7 "Bulk Modulus of the line"
    annotation(Dialog(tab="Sizing"));

  // initialization parameters
  parameter Boolean uniformPressure = true
    "True if initial pressure is equal throughout line"
  annotation(Dialog(tab="Initialization"));

  // the connectors
  OpenHydraulics.Interfaces.FluidPort port_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
            rotation=0)));
  OpenHydraulics.Interfaces.FluidPort port_b
    annotation (Placement(transformation(extent={{110,-10},{90,10}}, rotation=
             0)));

  Basic.WallFriction wallFriction_a(
      L=L/2,
      D=D,
      roughness=roughness)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
            rotation=0)));
  Basic.VolumeClosed volumeMiddle(
    volBulkMod=lineBulkMod,
    n_ports=2,
    V=Modelica.Constants.pi*(D/2)^2*L/2)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=
             0)));
  Basic.WallFriction wallFriction_b(
      L=L/2,
      D=D,
      roughness=roughness)
      annotation (Placement(transformation(extent={{40,-10},{60,10}},
            rotation=0)));

  extends OpenHydraulics.Interfaces.PartialFluidComponent;

  Basic.VolumeClosed volumeA(
    volBulkMod=lineBulkMod,
    n_ports=2,
    V=Modelica.Constants.pi*(D/2)^2*L/4)
    annotation (Placement(transformation(extent={{-90,10},{-70,-10}},
            rotation=0)));
  Basic.VolumeClosed volumeB(
    volBulkMod=lineBulkMod,
    n_ports=2,
    V=Modelica.Constants.pi*(D/2)^2*L/4)
    annotation (Placement(transformation(extent={{70,10},{90,-10}}, rotation=
              0)));
initial equation
  if uniformPressure then
    volumeMiddle.p_vol = port_a.p;
    volumeMiddle.p_vol = port_b.p;
  end if;
equation

  connect(wallFriction_a.port_b, volumeMiddle.port[1])
                                                   annotation (Line(points={{-40,0},
            {0,0},{0,0.575}},        color={255,0,0}));
  connect(wallFriction_b.port_a, volumeMiddle.port[2])
                                                    annotation (Line(points={
            {40,0},{0,0},{0,-0.475}}, color={255,0,0}));
  connect(port_a, volumeA.port[1]) annotation (Line(points={{-100,0},{-80,0},
            {-80,0.575}}, color={255,0,0}));
  connect(wallFriction_a.port_a, volumeA.port[2]) annotation (Line(points={{
            -60,0},{-80,0},{-80,-0.475}}, color={255,0,0}));
  connect(port_b, volumeB.port[1]) annotation (Line(points={{100,0},{80,0},{
            80,0.575}}, color={255,0,0}));
  connect(wallFriction_b.port_b, volumeB.port[2]) annotation (Line(points={{
            60,0},{80,0},{80,-0.475}}, color={255,0,0}));
  annotation (defaultComponentName="line",Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
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
            extent={{-100,-14},{100,-54}},
            lineColor={0,0,255},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%name"),
          Text(
            extent={{70,54},{100,14}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="B"),
          Text(
            extent={{-100,54},{-70,14}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="A")}),             Documentation(info="<html>
<p>
Simple pipe model consisting of one volume,
wall friction (with different friction correlations)
and gravity effect. This model is mostly used to demonstrate how
to build up more detailed models from the basic components.
Note, if the \"thermalPort\" is not connected, then the pipe
is totally insulated (= no thermal flow from the fluid to the
pipe wall/environment).
</p>
</html>"),
    Diagram(graphics));
end Line;
