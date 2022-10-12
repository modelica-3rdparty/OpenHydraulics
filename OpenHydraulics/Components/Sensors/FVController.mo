within OpenHydraulics.Components.Sensors;
model FVController
  "Given inputs of Force profile and desired velocity profile, controls a valve to match velocity"

  Modelica.Mechanics.Translational.Sources.Force force
    annotation (Placement(transformation(
        origin={-80,50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Tables.CombiTable1Ds ForceProfile(table=[0.0,0; 1,3000; 2,
        10000; 3,20000; 4,20000; 5,5000; 6,-1000; 7,-3000; 8,0; 9,0; 10,6000;
        11,10000; 12,10000; 13,12000; 14,0; 15,0; 16,-2000; 17,-4050; 18,-8000;
        19,-8000; 20,-5000; 21,-1000; 22,100; 23,0; 24,0])
    annotation (                                    Dialog, Placement(
        transformation(extent={{0,60},{-20,80}})));
  Modelica.Blocks.Sources.ContinuousClock clock annotation (Placement(transformation(
        origin={20,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
        origin={-8,-24},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Tables.CombiTable1Ds VelocityProfile(table=[0.0,0; 1,0; 2,0;
        3,0.01;4,0.03;5,0.1;6,0.04;7,0.0;8,0.0;9,-0.01;10,-0.02;11,-0.02;12,-0.025;
              13,-0.015;14,-0.05;15,0; 16,0; 17,0.11;18,0.14;19,0.13;20,0; 21,-0.01;
             22,-0.01;23,0; 24,0], smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (                                      Dialog, Placement(
        transformation(
        origin={20,-14},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Continuous.LimPID PID(
    Td=Td,
    k=k,
    Ti=0.1,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMax=1)
          annotation (Placement(transformation(extent={{2,-56},{-18,-76}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
        transformation(extent={{40,-40},{60,-20}})));
  parameter Real Td(  final min=0)
    "Derivative time constant coefficient for PID controller";
  parameter Real k( final min=0)
    "Proportional gain coefficient for PID controller";

  Modelica.Mechanics.Translational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(VelocityProfile.u, clock.y) annotation (Line(points={{20,-2},{20,
          18.25},{20,18.25},{20,38.5},{20,79},{20,79}}, color={0,0,127}));
  connect(speedSensor.v, PID.u_m) annotation (Line(points={{-8,-35},{-8,-44.5},
          {-8,-44.5},{-8,-54}},        color={0,0,127}));
  connect(PID.u_s, VelocityProfile.y[1]) annotation (Line(points={{4,-66},{
          20,-66},{20,-25}}, color={0,0,127}));
  connect(PID.y, y) annotation (Line(points={{-19,-66},{-26,-66},{-26,-84},
          {86,-84},{86,-30},{50,-30}}, color={0,0,127}));
  connect(force.f, ForceProfile.y[1]) annotation (Line(points={{-92,50},{
          -92,70},{-21,70}}, color={0,0,127}));
  connect(force.flange,   flange_a) annotation (Line(points={{-70,50},{-50,
          50}}, color={0,127,0}));
  connect(speedSensor.flange,   flange_a) annotation (Line(points={{-8,-14},
          {-8,10},{-50,10},{-50,50}}, color={0,127,0}));
  connect(ForceProfile.u, clock.y) annotation (Line(points={{2,70},{20,70},
          {20,79}}, color={0,0,127}));
  annotation (Diagram(graphics),
                       Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-130,104},{124,74}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%Force Velocity Controller"),
        Rectangle(
          extent={{-60,80},{60,20}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Rectangle(
          extent={{-60,0},{60,-60}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,215,215}),
        Rectangle(
          extent={{-2,20},{4,0}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={135,135,135})}));
end FVController;
