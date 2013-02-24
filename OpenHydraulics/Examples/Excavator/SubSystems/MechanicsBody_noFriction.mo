within OpenHydraulics.Examples.Excavator.SubSystems;
model MechanicsBody_noFriction
  import MB = Modelica.Mechanics.MultiBody;

  // the swing parameters
  parameter Modelica.Mechanics.MultiBody.Types.Init swing_initType=
      Modelica.Mechanics.MultiBody.Types.Init.Free
    "Type of initialization (defines usage of start values below)"
    annotation (Dialog(group="Swing",tab="Initialization"));
  parameter SI.Angle
    swing_phi_start=0
    "Initial value of rotation angle phi (fixed or guess value)"
    annotation (Evaluate=false, Dialog(group="Swing",tab="Initialization"));
  parameter SI.AngularVelocity
    swing_w_start =                                     0
    "Initial value of relative angular velocity w = der(phi)"
    annotation (Evaluate=false, Dialog(group="Swing",tab="Initialization"));
  parameter SI.AngularAcceleration
    swing_a_start =                                          0
    "Initial value of relative angular acceleration a = der(w)"
    annotation (Evaluate=false, Dialog(group="Swing",tab="Initialization"));

  // the boom parameters
  parameter Modelica.Mechanics.MultiBody.Types.Init boom_initType=
      Modelica.Mechanics.MultiBody.Types.Init.Free
    "Type of initialization (defines usage of start values below)"
    annotation (Dialog(group="Boom",tab="Initialization"));
  parameter SI.Angle
    boom_phi_start=0
    "Initial value of rotation angle phi (fixed or guess value)"
    annotation (Evaluate=false, Dialog(group="Boom",tab="Initialization"));
  parameter SI.AngularVelocity
    boom_w_start =                                     0
    "Initial value of relative angular velocity w = der(phi)"
    annotation (Evaluate=false, Dialog(group="Boom",tab="Initialization"));
  parameter SI.AngularAcceleration
    boom_a_start =                                          0
    "Initial value of relative angular acceleration a = der(w)"
    annotation (Evaluate=false, Dialog(group="Boom",tab="Initialization"));

  // the arm parameters
  parameter Modelica.Mechanics.MultiBody.Types.Init arm_initType=
      Modelica.Mechanics.MultiBody.Types.Init.Free
    "Type of initialization (defines usage of start values below)"
    annotation (Dialog(group="Arm",tab="Initialization"));
  parameter SI.Angle
    arm_phi_start=0
    "Initial value of rotation angle phi (fixed or guess value)"
    annotation (Evaluate=false, Dialog(group="Arm",tab="Initialization"));
  parameter SI.AngularVelocity
    arm_w_start = 0 "Initial value of relative angular velocity w = der(phi)"
    annotation (Evaluate=false, Dialog(group="Arm",tab="Initialization"));
  parameter SI.AngularAcceleration
    arm_a_start =                                          0
    "Initial value of relative angular acceleration a = der(w)"
    annotation (Evaluate=false, Dialog(group="Arm",tab="Initialization"));

  // the bucket parameters
  parameter Modelica.Mechanics.MultiBody.Types.Init bucket_initType=
      Modelica.Mechanics.MultiBody.Types.Init.Free
    "Type of initialization (defines usage of start values below)"
    annotation (Dialog(group="Bucket",tab="Initialization"));
  parameter SI.Angle
    bucket_phi_start=0
    "Initial value of rotation angle phi (fixed or guess value)"
    annotation (Evaluate=false, Dialog(group="Bucket",tab="Initialization"));
  parameter SI.AngularVelocity
    bucket_w_start =                                     0
    "Initial value of relative angular velocity w = der(phi)"
    annotation (Evaluate=false, Dialog(group="Bucket",tab="Initialization"));
  parameter SI.AngularAcceleration
    bucket_a_start =                                          0
    "Initial value of relative angular acceleration a = der(w)"
    annotation (Evaluate=false, Dialog(group="Bucket",tab="Initialization"));

  outer MB.World world;

  // the joints
  Modelica.Mechanics.MultiBody.Joints.Revolute swingRevolute(
    n={0,1,0},
    useAxisFlange=true,
    a(start=swing_a_start, fixed=if ((
          swing_initType) == 3 or (swing_initType) == 6 or (
          swing_initType) == 7) then true else false),
    phi(fixed=if ((swing_initType) == 2 or (swing_initType) == 4 or (
          swing_initType) == 7) then true else false, start=
          swing_phi_start),
    w(fixed=if ((swing_initType) == 2 or (swing_initType) == 3 or (
          swing_initType) == 5 or (swing_initType) == 6 or (
          swing_initType) == 7) then true else false, start=
          swing_w_start))
    "revolute joint (plus motor) representing the swing function"
    annotation (Placement(transformation(
        origin={-110,-100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute boomRevolute(
    a(start=boom_a_start, fixed=if (
          boom_initType == 3 or boom_initType == 6 or boom_initType
           == 7) then true else false),
    phi(fixed=if (boom_initType == 2 or boom_initType == 4 or
          boom_initType == 7) then true else false, start=
          boom_phi_start),
    w(fixed=if (boom_initType == 2 or boom_initType == 3 or
          boom_initType == 5 or boom_initType == 6 or boom_initType
           == 7) then true else false, start=boom_w_start))
    annotation (Placement(transformation(extent={{-133,12},{-113,32}},
          rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute armRevolute(
    a(start=arm_a_start, fixed=if (
          arm_initType == 3 or arm_initType == 6 or arm_initType ==
          7) then true else false),
    phi(fixed=if (arm_initType == 2 or arm_initType == 4 or
          arm_initType == 7) then true else false, start=arm_phi_start),
    w(fixed=if (arm_initType == 2 or arm_initType == 3 or
          arm_initType == 5 or arm_initType == 6 or arm_initType ==
          7) then true else false, start=arm_w_start))
    annotation (Placement(transformation(extent={{3,12},{23,32}},
          rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute bucketRevolute(
    a(start=bucket_a_start, fixed=if (
          bucket_initType == 3 or bucket_initType == 6 or
          bucket_initType == 7) then true else false),
    phi(fixed=if (bucket_initType == 2 or bucket_initType == 4 or
          bucket_initType == 7) then true else false, start=
          bucket_phi_start),
    w(fixed=if (bucket_initType == 2 or bucket_initType == 3 or
          bucket_initType == 5 or bucket_initType == 6 or
          bucket_initType == 7) then true else false, start=
          bucket_w_start))
    annotation (Placement(transformation(extent={{159,12},{179,32}},
          rotation=0)));
  MB.Joints.Assemblies.JointRRR jointRRR1(
    rRod2_ib={-0.67,
                   0.07,
                       0},
    rRod1_ia={0.62,0.36,0},
    phi_guess=0,
    phi_offset=-45) annotation (Placement(transformation(extent={{170,-71},
            {199,-40}}, rotation=0)));

  // joint friction

  // the outside interface
  Modelica.Mechanics.Rotational.Interfaces.Flange_a swingFlange
    "input connector for rotation of swing function revolute joint"
    annotation (Placement(transformation(extent={{-211,-133},{-191,-113}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b cylBoomRightBase
    "flange a of force in cylinder 1 (between carriage and boom)"
    annotation (Placement(transformation(extent={{-24,-151},{-4,-131}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a cylBoomRightRod
    "flange b of force in cylinder 1 (between carriage and boom )"
    annotation (Placement(transformation(extent={{-4,-151},{16,-131}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b cylBoomLeftBase
    annotation (Placement(transformation(extent={{-210,17},{-190,37}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a cylBoomLeftRod
    annotation (Placement(transformation(extent={{-210,37},{-190,57}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b cylArmBase
    "flange a of force in cylinder 2 (between boom and arm)"
    annotation (Placement(transformation(extent={{-35,129},{-15,149}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a cylArmRod
    "flange b of force in cylinder 2 (between boom and arm)"
    annotation (Placement(transformation(extent={{-15,129},{5,149}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_b cylBucketBase
    annotation (Placement(transformation(extent={{135,129},{155,149}},
          rotation=0)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a cylBucketRod
    annotation (Placement(transformation(extent={{155,129},{175,149}},
          rotation=0)));
  MB.Interfaces.Frame_a baseFrame
    annotation (Placement(transformation(
        origin={-72,-136},
        extent={{-16,-16},{16,16}},
        rotation=90)));

  // the actuators
  MB.Forces.LineForceWithMass cylBoomRight(lineShapeWidth=0.095)
    "hydraulic force in cylinder 1 (between carriage and boom)"
    annotation (Placement(transformation(
        origin={-33,-21},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  MB.Forces.LineForceWithMass cylBoomLeft(lineShapeWidth=0.095)
    "hydraulic force in cylinder 1 (between carriage and boom)"
    annotation (Placement(transformation(
        origin={-167,41},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  MB.Forces.LineForceWithMass cylArm(lineShapeType="cylinder", lineShapeWidth=0.095)
    "hydraulic force in cylinder 2 (between boom and arm)"
    annotation (Placement(transformation(extent={{-21,69},{-1,89}},
          rotation=0)));
  MB.Forces.LineForceWithMass cylBucket(lineShapeType="cylinder",
      lineShapeWidth=0.095)
    "hydraulic force in cylinder 2 (between boom and arm)"
    annotation (Placement(transformation(
        origin={155.5,90},
        extent={{15.5,15},{-15.5,-15}},
        rotation=180)));

  // the linkages
  MB.Parts.FixedTranslation base(
    lengthDirection={1,0,0},
    r={0,1.70,0},
    shapeType="4",
    color={0,0,0}) "object model for the base of the excavator"
    annotation (Placement(transformation(
        origin={-110,-129},
        extent={{-11,-13},{11,13}},
        rotation=90)));
  MB.Parts.FixedTranslation carriage(
    shapeType="1",
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    r_shape={0,0,0},
    color={255,255,0},
    r={-0.164,1.428,0}) "object model for the carriage of the excavator"
    annotation (Placement(transformation(
        origin={-141.5,-23},
        extent={{-26,-13.5},{26,13.5}},
        rotation=90)));
  MB.Parts.FixedTranslation boom(       r={7.11,0,0}, shapeType="2",
    color={155,0,0}) "object model for the boom of the excavator"
    annotation (Placement(transformation(extent={{-79,7},{-20,37}},
          rotation=0)));
  MB.Parts.FixedTranslation boom1LinkRight(r={0.655,
                                                   0.703,
                                                        0.296})
    "from swing motor to lifting cylinder cap side pivot"
    annotation (Placement(transformation(
        origin={-33.5,-57},
        extent={{-20,-8.5},{20,8.5}},
        rotation=90)));
  MB.Parts.FixedTranslation boom1LinkLeft(r={0.655,
                                                  0.703,
                                                       -0.296})
    "from swing motor to lifting cylinder cap side pivot"
    annotation (Placement(transformation(
        origin={-167.5,-17},
        extent={{-20,-8.5},{20,8.5}},
        rotation=90)));
  MB.Parts.FixedTranslation boom2LinkRight(r={2.85,1.18,0.3})
    "from boom-lift pivot to lifting cylinder rod side pivot"
    annotation (Placement(transformation(extent={{-77,-7},{-32,12}},
          rotation=0)));
  MB.Parts.FixedTranslation boom2LinkLeft(r={2.85,1.18,-0.3})
    "from boom-lift pivot to lifting cylinder rod side pivot"
    annotation (Placement(transformation(
        origin={-131,75.5},
        extent={{-28,-8.5},{28,8.5}},
        rotation=180)));
  MB.Parts.FixedTranslation boom3Link(r={4.22,1.33,0})
    "from boom-lift pivot to arm cylinder cap side pivot"
    annotation (Placement(transformation(extent={{-78,71},{-31,85}},
          rotation=0)));
  MB.Parts.FixedTranslation boom4LinkX(r={-0.920,
                                                0,0})
    annotation (Placement(transformation(
        origin={21.5,79},
        extent={{-17.5,-9},{17.5,9}},
        rotation=180)));
  MB.Parts.FixedTranslation boom4LinkY(r={0,0.217,
                                                 0})
    annotation (Placement(transformation(
        origin={60.5,53},
        extent={{-20,-8.5},{20,8.5}},
        rotation=90)));
  MB.Parts.FixedTranslation armLink(
    r_shape={0,0,0},
    r={3.654,0,0},
    animation=true,
    color={0,180,0},
    shapeType="3") "object model for the arm of the excavator"
    annotation (Placement(transformation(extent={{86,11},{129,33}},
          rotation=0)));
  MB.Parts.FixedTranslation arm1Link(
    r_shape={0,0,0},
    animation=true,
    color={0,180,0},
    r={0.49,0.96,0},
    shapeType="cylinder",
    width=0.1) "object model for the arm of the excavator"
    annotation (Placement(transformation(extent={{91,82},{126,98}},
          rotation=0)));
  MB.Parts.FixedTranslation arm2Link(
    r_shape={0,0,0},
    animation=true,
    color={0,180,0},
    r={2.97,0.13,0},
    shapeType="cylinder",
    width=0.1) "object model for the arm of the excavator"
    annotation (Placement(transformation(extent={{86,-63},{129,-46}},
          rotation=0)));
  MB.Parts.FixedTranslation bucketLink(
    color={0,0,255},
    width=0.1,
    r={0.52,
           0.07,0},
    shapeType="5") annotation (Placement(transformation(
        origin={231,7.5},
        extent={{-14.5,-11},{14.5,11}},
        rotation=270)));
  MB.Parts.Body bCarriage(
    m=11312.161,
    I_11=9667,
    I_22=34850,
    I_33=30686,
    I_21=-3756,
    I_31=0,
    I_32=0,
    r_CM={-2.555,1.169,0},
    sphereDiameter=world.defaultBodyDiameter)
    "mass/inertia properties for carriage"
    annotation (Placement(transformation(extent={{-123,-59},{-103,-39}},
          rotation=0)));
  MB.Parts.Body bBoom(
    r_CM={3.44,0.65,
                   0},
    I_11=390.5,
    I_22=7803,
    I_33=8060,
    I_21=-150.1,
    I_31=0,
    I_32=0,
    m=1307) "mass/inertia properties for boom"
    annotation (Placement(transformation(extent={{-58,38},{-38,58}},
          rotation=0)));
  MB.Parts.Body bArm(
    r_CM={1.176,0.296,
                     0},
    I_11=130.4,
    I_22=2110,
    I_33=2191,
    I_21=-214,
    I_31=0,
    I_32=0,
    animation=true,
    m=700.5) "mass/inertia properties for arm"
    annotation (Placement(transformation(
        origin={60,-6},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  MB.Parts.Body bBucket(
    I_31=0,
    I_32=0,
    r_CM={0.5,
             -0.6,
                 0},
    m=50,
    I_11=0.1304,
    I_22=2.11,
    I_33=2.191,
    I_21=-0.214) "mass/inertia properties for arm"
    annotation (Placement(transformation(
        origin={230,54},
        extent={{-10,-10},{10,10}},
        rotation=90)));

equation
  connect(swingRevolute.frame_a,base. frame_b)              annotation (Line(
      points={{-110,-110},{-110,-118}},
      color={0,0,0},
      thickness=0.5));
  connect(boom1LinkRight.frame_a, swingRevolute.frame_b)    annotation (Line(
      points={{-33.5,-77},{-34,-77},{-34,-82},{-110,-82},{-110,-90}},
      color={0,0,0},
      thickness=0.5));
  connect(boom4LinkX.frame_a, boom4LinkY.frame_b)       annotation (Line(
      points={{39,79},{61,79},{61,73},{60.5,73}},
      color={0,0,0},
      thickness=0.5));
  connect(cylArm.frame_a, boom3Link.frame_b)                  annotation (Line(
      points={{-21,79},{-26,79},{-26,78},{-31,78}},
      color={0,0,0},
      thickness=0.5));
  connect(cylArm.frame_b, boom4LinkX.frame_b)                annotation (Line(
      points={{-1,79},{4,79}},
      color={0,0,0},
      thickness=0.5));
  connect(boom2LinkRight.frame_b, cylBoomRight.frame_b)      annotation (Line(
      points={{-32,2.5},{-32,-11},{-33,-11}},
      color={0,0,0},
      thickness=0.5));
  connect(boom1LinkRight.frame_b, cylBoomRight.frame_a)      annotation (Line(
      points={{-33.5,-37},{-33,-37},{-33,-31}},
      color={0,0,0},
      thickness=0.5));
  connect(carriage.frame_a,swingRevolute. frame_b)
                                              annotation (Line(
      points={{-141.5,-49},{-141,-49},{-141,-82},{-110,-82},{-110,-90}},
      color={0,0,0},
      thickness=0.5));
  connect(cylBoomRight.flange_a, cylBoomRightBase)
                                          annotation (Line(points={{-23,
          -27},{-14,-27},{-14,-141}}, color={0,191,0}));
  connect(cylBoomRight.flange_b, cylBoomRightRod)
                                          annotation (Line(points={{-23,
          -15},{6,-15},{6,-141}}, color={0,191,0}));
  connect(cylArm.flange_b, cylArmRod)     annotation (Line(points={{-5,89},
          {-5,139}}, color={0,191,0}));
  connect(bCarriage.frame_a,carriage. frame_a) annotation (Line(
      points={{-123,-49},{-141.5,-49}},
      color={0,0,0},
      thickness=0.5));
  connect(bBoom.frame_a,boom. frame_a) annotation (Line(
      points={{-58,48},{-78,48},{-78,22},{-79,22}},
      color={0,0,0},
      thickness=0.5));
  connect(boom1LinkLeft.frame_a, swingRevolute.frame_b)
                                          annotation (Line(
      points={{-167.5,-37},{-167,-37},{-167,-82},{-110,-82},{-110,-90}},
      color={0,0,0},
      thickness=0.5));
  connect(cylBoomLeft.frame_a, boom1LinkLeft.frame_b)
                                        annotation (Line(
      points={{-167,31},{-167,3},{-167.5,3}},
      color={0,0,0},
      thickness=0.5));
  connect(boom2LinkLeft.frame_b, cylBoomLeft.frame_b)
                                        annotation (Line(
      points={{-159,75.5},{-159,75.75},{-167,75.75},{-167,51}},
      color={0,0,0},
      thickness=0.5));
  connect(cylBoomLeft.flange_b, cylBoomLeftRod)
                                            annotation (Line(points={{
          -177,47},{-200,47}}, color={0,191,0}));
  connect(cylBoomLeft.flange_a, cylBoomLeftBase)
                                            annotation (Line(points={{
          -177,35},{-177,27},{-200,27}}, color={0,191,0}));
  connect(bArm.frame_a, armLink.frame_a)
                                     annotation (Line(
      points={{60,4},{60,22},{86,22}},
      color={0,0,0},
      thickness=0.5));
  connect(armLink.frame_a, arm1Link.frame_a)
                                     annotation (Line(
      points={{86,22},{86,90},{91,90}},
      color={0,0,0},
      thickness=0.5));
  connect(jointRRR1.frame_a, arm2Link.frame_b)
                                           annotation (Line(
      points={{170,-55.5},{170,-55},{129,-55},{129,-54.5}},
      color={0,0,0},
      thickness=0.5));
  connect(cylBucket.frame_b, jointRRR1.frame_im)
                                             annotation (Line(
      points={{171,90},{171,91},{184.5,91},{184.5,-40}},
      color={0,0,0},
      thickness=0.5));
  connect(cylBucket.frame_a, arm1Link.frame_b)
                                       annotation (Line(
      points={{140,90},{126,90}},
      color={0,0,0},
      thickness=0.5));
  connect(arm2Link.frame_a, armLink.frame_a)
                                     annotation (Line(
      points={{86,-54.5},{86,22}},
      color={0,0,0},
      thickness=0.5));
  connect(bucketLink.frame_b, jointRRR1.frame_b)
                                          annotation (Line(
      points={{231,-7},{231,-54},{199,-54},{199,-55.5}},
      color={0,0,0},
      thickness=0.5));
  connect(bBucket.frame_a, bucketLink.frame_a)
                                        annotation (Line(
      points={{230,44},{230,22},{231,22}},
      color={0,0,0},
      thickness=0.5));
  connect(cylBucket.flange_b, cylBucketRod)
                                     annotation (Line(points={{164.8,105},
          {164.8,128.25},{165,128.25},{165,139}}, color={0,191,0}));
  connect(cylBucket.flange_a, cylBucketBase)
                                     annotation (Line(points={{146.2,105},
          {146.2,139.25},{145,139.25},{145,139}}, color={0,191,0}));
  connect(boom.frame_b,armRevolute. frame_a)      annotation (Line(
      points={{-20,22},{3,22}},
      color={95,95,95},
      thickness=0.5));
  connect(armRevolute.frame_b, boom4LinkY.frame_a)
                                                 annotation (Line(
      points={{23,22},{60,22},{60,33},{60.5,33}},
      color={95,95,95},
      thickness=0.5));
  connect(armRevolute.frame_b, armLink.frame_a)  annotation (Line(
      points={{23,22},{86,22}},
      color={95,95,95},
      thickness=0.5));
  connect(armLink.frame_b, bucketRevolute.frame_a)
                                                  annotation (Line(
      points={{129,22},{159,22}},
      color={95,95,95},
      thickness=0.5));
  connect(bucketRevolute.frame_b, bucketLink.frame_a)
                                                  annotation (Line(
      points={{179,22},{205,22},{205,22},{231,22}},
      color={95,95,95},
      thickness=0.5));
  connect(base.frame_a, baseFrame)
                                  annotation (Line(
      points={{-110,-140},{-110,-136},{-72,-136}},
      color={95,95,95},
      thickness=0.5));
  connect(boomRevolute.frame_b,boom. frame_a)      annotation (Line(
      points={{-113,22},{-79,22}},
      color={95,95,95},
      thickness=0.5));
  connect(boom2LinkLeft.frame_a, boomRevolute.frame_b)
                                                   annotation (Line(
      points={{-103,75.5},{-102,75.5},{-102,22},{-113,22}},
      color={95,95,95},
      thickness=0.5));
  connect(boom3Link.frame_a, boomRevolute.frame_b)
                                                 annotation (Line(
      points={{-78,78},{-78,22},{-113,22}},
      color={95,95,95},
      thickness=0.5));
  connect(boomRevolute.frame_a,carriage. frame_b)      annotation (Line(
      points={{-133,22},{-141.5,22},{-141.5,3}},
      color={95,95,95},
      thickness=0.5));
  connect(boom2LinkRight.frame_a, boomRevolute.frame_b)
                                                   annotation (Line(
      points={{-77,2.5},{-77,22},{-113,22}},
      color={95,95,95},
      thickness=0.5));
  connect(cylArmBase, cylArm.flange_a)    annotation (Line(points={{-25,
          139},{-25,89},{-17,89}}, color={0,127,0}));

  connect(swingRevolute.axis, swingFlange) annotation (Line(points={{-120,
          -100},{-177,-100},{-177,-123},{-201,-123}}, color={0,0,0}));

  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{250,200}},
        grid={1,1}), graphics={Text(
          extent={{50,-90},{205,-125}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString=
               "Mechanical model of complete excavator"), Rectangle(
            extent={{-200,140},{250,-141}}, lineColor={0,0,255})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{250,200}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-200,140},{250,-140}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Bitmap(extent={{-197,219},{248,-223}}, fileName=
              "modelica://OpenHydraulics/Resources/Images/excavator.png"),
        Line(
          points={{-190,37},{-14,-1}},
          color={0,127,0},
          thickness=0.5),
        Line(
          points={{-15,129},{23,92}},
          color={0,127,0},
          thickness=0.5),
        Line(
          points={{155,129},{126,88}},
          color={0,127,0},
          thickness=0.5),
        Line(
          points={{-30,-10},{-4,-131}},
          color={0,127,0},
          thickness=0.5),
        Ellipse(
          extent={{-18,4},{-8,-6}},
          lineColor={0,127,0},
          lineThickness=0.5,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,97},{28,87}},
          lineColor={0,127,0},
          lineThickness=0.5,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{122,94},{132,84}},
          lineColor={0,127,0},
          lineThickness=0.5,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-3},{-26,-13}},
          lineColor={0,127,0},
          lineThickness=0.5,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-55,-57},{-45,-67}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-200,-122},{-50,-60}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{-72,-137},{-72,-127}},
          color={95,95,95},
          thickness=0.5)}));
end MechanicsBody_noFriction;
