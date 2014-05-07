within OpenHydraulics.Interfaces;
partial model PartialFluidCircuit
  "Base model for any component involving fluid"

  inner replaceable OpenHydraulics.Fluids.GenericOilSimple oil "Oil model"
                annotation(choicesAllMatching=true,Placement(transformation(extent={{-98,78},
            {-78,98}})));

  inner OpenHydraulics.Circuits.Environment environment
                                annotation (Placement(transformation(extent={
            {-100,-100},{-80,-80}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end PartialFluidCircuit;
