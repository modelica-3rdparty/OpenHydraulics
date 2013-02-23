within OpenHydraulics.Examples.Excavator.SubSystems;
model DigCycleSeq
  import Modelica.Constants.pi;

  // the parameters
  parameter Modelica.SIunits.Frequency bandwidth=10;
  parameter Modelica.SIunits.Time startTime=1
    "Time before excavator starts moving";
  parameter Real swingAmplitude = -1 "Amplitude of swing command";
  parameter Real boomAmplitude1 = -0.9 "Amplitude of first boom command";
  parameter Real boomAmplitude2 = 0.5 "Amplitude of second boom command";
  parameter Real armAmplitude1 = -1 "Amplitude of arm command";
  parameter Real armAmplitude2 = 0.3 "Amplitude of bucket command";
//  parameter Real armAmplitude2 = 1 "Amplitude of bucket command";
  parameter Real bucketAmplitude1 = -0.7 "Amplitude of bucket command";
  parameter Real bucketAmplitude2 = 0.45 "Amplitude of bucket command";
  parameter Real bucketAmplitude3 = -1 "Amplitude of bucket command";

  // the components
  Modelica.Blocks.Tables.CombiTable1D swingTimeTable(                   table=[0,
        0; 1,0; 13,0; 14,swingAmplitude; 17,swingAmplitude; 18,0; 20,0])
    annotation (Placement(transformation(
        origin={-30,60},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Tables.CombiTable1D boomTimeTable(
                           table=[0,0; 1,boomAmplitude1; 2,boomAmplitude1;
        3,0; 7,0; 8,boomAmplitude2; 11.5,boomAmplitude2; 12.5,0; 20,0])
    annotation (Placement(transformation(
        origin={-30,20},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Tables.CombiTable1D armTimeTable(table=[0,0;0.5,0; 1,
        armAmplitude1; 2,armAmplitude1; 3,0; 4.5,armAmplitude2; 6.5,
        armAmplitude2; 7.5,0; 20,0])
    annotation (Placement(transformation(
        origin={-30,-20},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Tables.CombiTable1D bucketTimeTable(table=[0,0;0.5,0; 1,bucketAmplitude1; 3,bucketAmplitude1; 4,
        0; 5,0; 6,bucketAmplitude2; 7,bucketAmplitude2; 9,0; 16,0; 16.3,
        bucketAmplitude3; 17,bucketAmplitude3; 18,0; 20,0])
    annotation (Placement(transformation(
        origin={-30,-60},
        extent={{10,-10},{-10,10}},
        rotation=180)));

  Modelica.Blocks.Continuous.SecondOrder swingFilter(w=2*pi*bandwidth)
    annotation (Placement(transformation(extent={{0,50},{20,70}},
          rotation=0)));
  Modelica.Blocks.Continuous.SecondOrder boomFilter(w=2*pi*bandwidth)
    annotation (Placement(transformation(extent={{0,10},{20,30}},
          rotation=0)));
  Modelica.Blocks.Continuous.SecondOrder armFilter(w=2*pi*bandwidth)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}},
          rotation=0)));
  Modelica.Blocks.Continuous.SecondOrder bucketFilter(w=2*pi*bandwidth)
    annotation (Placement(transformation(extent={{0,-70},{20,-50}},
          rotation=0)));

  // auxiliary components
  Modelica.Blocks.Routing.Multiplex4 multiplex
    annotation (Placement(transformation(extent={{54,-16},{86,16}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y1[4]
    "Connector of Real output signals"
    annotation (Placement(transformation(
        origin={110,0},
        extent={{14,-14},{-14,14}},
        rotation=180)));
protected
  SI.Time t "Input to tables";

equation
  t = if noEvent(time>startTime) then time-startTime else 0;
  swingTimeTable.u[1] = t;
  boomTimeTable.u[1] = t;
  armTimeTable.u[1] = t;
  bucketTimeTable.u[1] = t;

  connect(multiplex.y, y1)    annotation (Line(points={{87.6,0},{98,-3.1606e-021},
          {98,1.77636e-015},{110,1.77636e-015}},               color={0,0,
          127}));
  connect(swingTimeTable.y[1], swingFilter.u)
    annotation (Line(points={{-19,60},{-2,60}}, color={0,0,127}));
  connect(swingFilter.y, multiplex.u1[1]) annotation (Line(points={{21,60},
          {34,60},{34,14.4},{50.8,14.4}}, color={0,0,127}));
  connect(boomTimeTable.y[1], boomFilter.u)
    annotation (Line(points={{-19,20},{-2,20}}, color={0,0,127}));
  connect(armTimeTable.y[1], armFilter.u)
    annotation (Line(points={{-19,-20},{-2,-20}}, color={0,0,127}));
  connect(bucketTimeTable.y[1],bucketFilter. u)
    annotation (Line(points={{-19,-60},{-2,-60}}, color={0,0,127}));
  connect(bucketFilter.y, multiplex.u4[1]) annotation (Line(points={{21,-60},
          {36,-60},{36,-14.4},{50.8,-14.4}},      color={0,0,127}));
  connect(armFilter.y, multiplex.u3[1])    annotation (Line(points={{21,
          -20},{28,-20},{28,-4.8},{50.8,-4.8}}, color={0,0,127}));
  connect(boomFilter.y, multiplex.u2[1])   annotation (Line(points={{21,
          20},{28,20},{28,4.8},{50.8,4.8}}, color={0,0,127}));

  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,60},{10,20}},
          lineColor={0,0,0},
          textString="Dig "),
        Text(
          extent={{-100,20},{10,-20}},
          lineColor={0,0,0},
          textString="Cycle"),
        Text(
          extent={{0,-12},{60,-28}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Arm"),
        Text(
          extent={{60,28},{0,12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Boom"),
        Text(
          extent={{60,68},{0,52}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Swing"),
        Text(
          extent={{0,-52},{60,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Bucket"),
        Text(
          extent={{-100,-20},{10,-60}},
          lineColor={0,0,0},
          textString="Traj"),
        Line(points={{60,60},{96,0}}, color={0,0,0}),
        Line(points={{96,0},{60,20}}, color={0,0,0}),
        Line(points={{96,0},{60,-20}}, color={0,0,0}),
        Line(points={{60,-60},{96,0}}, color={0,0,0})}));
end DigCycleSeq;
