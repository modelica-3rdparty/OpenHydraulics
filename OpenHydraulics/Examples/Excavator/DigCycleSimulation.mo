within OpenHydraulics.Examples.Excavator;
model DigCycleSimulation
  extends Modelica.Icons.Example;

  SubSystems.MechanicsBody_noFriction mechanicsBody(
    swing_initType=OpenHydraulics.Types.RevoluteInit.PositionVelocity,
    swing_phi_start=0,
    boom_phi_start=0.87266462599716,
    arm_phi_start=-1.3962634015955,
    bucket_phi_start=0.34906585039887) annotation (Placement(transformation(extent={{10,-33},{98,46}})));
  OpenHydraulics.Examples.Excavator.SubSystems.HydraulicsSubSyst hydraulics(
      redeclare OpenHydraulics.Fluids.GenericOilSimple oil)
    annotation (Placement(transformation(extent={{-6,-18},{-46,22}})));
  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  OpenHydraulics.Examples.Excavator.SubSystems.DigCycleSeq digCycleSeq
    annotation (Placement(transformation(extent={{-98,-18},{-56,22}})));

equation
  connect(hydraulics.ArmCylRod, mechanicsBody.cylArmRod) annotation (Line(
        points={{-30.8,22},{-30,22},{-30,50},{48,50},{48,33.9525},{48.1333,
          33.9525}}, color={0,127,0}));
  connect(hydraulics.ArmCylBase, mechanicsBody.cylArmBase) annotation (Line(
        points={{-26.8,22},{-26,22},{-26,46},{44,46},{44,33.9525},{44.2222,
          33.9525}}, color={0,127,0}));
  connect(world.frame_b, mechanicsBody.baseFrame) annotation (Line(
      points={{30,-50},{35.0311,-50},{35.0311,-20.36}},
      color={95,95,95},
      thickness=0.5));
  connect(hydraulics.BoomCylRodL, mechanicsBody.cylBoomLeftRod)
    annotation (Line(points={{-6,14.8},{10,14.8},{10,15.7825}}, color={0,
          127,0}));
  connect(hydraulics.BoomCylBaseL, mechanicsBody.cylBoomLeftBase)
    annotation (Line(points={{-6,10.8},{10,10.8},{10,11.8325}}, color={0,
          127,0}));
  connect(hydraulics.BoomCylRodR, mechanicsBody.cylBoomRightRod)
    annotation (Line(points={{-21.2,22},{-21.2,38},{2,38},{2,-26},{50.2844,-26},
          {50.2844,-21.3475}},      color={0,127,0}));
  connect(hydraulics.BoomCylBaseR, mechanicsBody.cylBoomRightBase)
    annotation (Line(points={{-17.2,22},{-18,22},{-18,34},{0,34},{0,-30},{46,
          -30},{46,-21.3475},{46.3733,-21.3475}},    color={0,127,0}));
  connect(digCycleSeq.y1, hydraulics.Command) annotation (Line(points={{-53.9,2},
          {-50.85,2},{-47.8,2}},                     color={0,0,127}));
  connect(hydraulics.BucketCylBase, mechanicsBody.cylBucketBase)
    annotation (Line(points={{-37.2,22},{-38,22},{-38,54},{77.4667,54},{77.4667,
          33.9525}},         color={0,127,0}));
  connect(hydraulics.BucketCylRod, mechanicsBody.cylBucketRod) annotation (Line(
        points={{-41.2,22},{-42,22},{-42,58},{81.3778,58},{81.3778,33.9525}},
        color={0,127,0}));
  connect(hydraulics.SwingFlange, mechanicsBody.swingFlange) annotation (Line(
        points={{-9.2,22},{-9.2,30},{4,30},{4,-17.7925},{9.80444,-17.7925}},
        color={0,0,0}));
  annotation (Diagram(graphics),
    experiment(StopTime=20, Tolerance=1e-008));
end DigCycleSimulation;
