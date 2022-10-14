within OpenHydraulics.Basic;
model FluidPower2MechRotConst
  "Ideal constant displacement pump with mechanical connector for the shaft"
  extends BaseClasses.PartialPumpMotor;

  // parameters in default tab
  parameter SI.Volume Dconst = 0.001 "Constant pump displacement";

equation
  D = Dconst;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Polygon(
          points={{-10,52},{0,42},{-10,32},{10,32},{0,42},{10,52},{-10,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-10,-32},{0,-42},{-10,-52},{10,-52},{0,-42},{10,-32},{-10,
              -32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Polygon(
          points={{-10,52},{0,42},{-10,32},{10,32},{0,42},{10,52},{-10,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-10,-32},{0,-42},{-10,-52},{10,-52},{0,-42},{10,-32},{-10,
              -32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end FluidPower2MechRotConst;
