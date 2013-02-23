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
          fillPattern=FillPattern.Solid)}),
  Icon(Rectangle(extent=[60,26; 84,12], style(
          color=10,
          rgbcolor={95,95,95},
          gradient=2,
          fillColor=10,
          rgbfillColor={95,95,95}))),
  Diagram);
end FluidPower2MechRotConst;
