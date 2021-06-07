within OpenHydraulics.DevelopmentTests;
model DoubleChamberTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.OpenTank tank(p_const=200000)
                        annotation (Placement(transformation(extent={{-30,-40},
            {-10,-20}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=100)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  OpenHydraulics.Basic.OpenTank tank1          annotation (Placement(transformation(extent={{30,0},{
            50,20}})));
  Components.Cylinders.DoubleActingCylinder doubleActingCylinder(
    s_init=1,
    strokeLength=2,
    closedLength=3,
    damping=0,
    initType=ObsoleteModelica4.Mechanics.MultiBody.Types.Init.PositionVelocity,
    v_init=-0.1) annotation (Placement(transformation(extent={{-22,40},{-2,60}})));

equation
  connect(fixed.flange,   doubleActingCylinder.flange_a)
    annotation (Line(points={{-40,50},{-22,50}}, color={0,127,0}));
  connect(doubleActingCylinder.flange_b, slidingMass.flange_a)
    annotation (Line(points={{-2,50},{20,50}}, color={0,127,0}));
  connect(doubleActingCylinder.port_a, tank.port)
    annotation (Line(points={{-20,42},{-20,-20}}, color={255,0,0}));
  connect(doubleActingCylinder.port_b, tank1.port) annotation (Line(points={{
          -4,42},{-4,20},{40,20}}, color={255,0,0}));
annotation ( Diagram(graphics));
end DoubleChamberTest;
