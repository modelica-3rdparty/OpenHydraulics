within OpenHydraulics.DevelopmentTests;
model ChamberTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  Components.Volumes.Tank         tank(       p_const=200000)
                        annotation (Placement(transformation(extent={{-30,-40},
            {-10,-20}}, rotation=0)));
  OpenHydraulics.Basic.FluidPower2MechTrans cylinderChamber(s_rel(start=1,
        fixed=true), n_ports=2)
                    annotation (Placement(transformation(extent={{-30,40},{
            -10,60}}, rotation=0)));
  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-50,40},{-30,60}}, rotation=
           0)));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=100, v(start=-10,
        fixed=false))
    annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=0)));
  Components.Volumes.Tank         tank1         annotation (Placement(transformation(extent={{30,0},{
            50,20}}, rotation=0)));
  OpenHydraulics.Basic.LaminarRestriction leakage_A2B(L=0.01, D=1e-5)
    annotation (Placement(transformation(extent={{0,10},{20,30}}, rotation=0)));
equation
  connect(fixed.flange,   cylinderChamber.flange_a) annotation (Line(points={
          {-40,50},{-30,50}}, color={0,127,0}));
  connect(cylinderChamber.flange_b, slidingMass.flange_a) annotation (Line(
        points={{-10,50},{20,50}}, color={0,127,0}));
  connect(tank.port, cylinderChamber.port[1]) annotation (Line(points={{-20,
          -20},{-20,49.425}}, color={255,0,0}));
  connect(leakage_A2B.port_b, tank1.port)
    annotation (Line(points={{20,20},{40,20}}, color={255,0,0}));
  connect(leakage_A2B.port_a, cylinderChamber.port[2]) annotation (Line(
        points={{0,20},{-18,20},{-18,50.475},{-20,50.475}}, color={255,0,0}));
annotation ( Diagram(graphics),
    experiment(Tolerance=1e-008),
    experimentSetupOutput);
end ChamberTest;
