within OpenHydraulics.DevelopmentTests;
model AirChamberTest

  extends OpenHydraulics.Interfaces.PartialFluidCircuit(redeclare
      OpenHydraulics.Fluids.GenericOilSimple oil);

  OpenHydraulics.Basic.AirChamber airChamber(
    A=0.01,
    V_precharge=0.005,
    residualVolume=0.001,
    p_precharge=101325,
    p_init=2000000) annotation (Placement(transformation(extent={{-50,-10},{
            -30,10}})));
  Modelica.Mechanics.Translational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Mechanics.Translational.Components.Mass slidingMass(
                                                           m=100, v(start=-10))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(fixed.flange,   airChamber.flange_a)      annotation (Line(points={
          {-60,0},{-50,0}}, color={0,127,0}));
  connect(airChamber.flange_b, slidingMass.flange_a)
    annotation (Line(points={{-30,0},{0,0}}, color={0,127,0}));

end AirChamberTest;
