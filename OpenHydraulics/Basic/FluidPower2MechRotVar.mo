within OpenHydraulics.Basic;
model FluidPower2MechRotVar
  "Ideal variable displacement pump with mechanical connector for the shaft"

  // parameters in sizing tab
  parameter SI.Volume Dmax = 0.001 "Maximum pump displacement"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Volume Dmin = 0 "Minimum pump displacement"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Volume Dlimit = max(abs(Dmax),abs(Dmin)) "Displacement of pump"
    annotation(Dialog(tab="Sizing"));

  extends BaseClasses.PartialPumpMotor;

  Modelica.Blocks.Interfaces.RealInput dispFraction
    annotation (Placement(transformation(extent={{-100,-94},{-70,-64}})));
equation
  D = min(max(dispFraction*Dlimit,Dmin),Dmax);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{80,80},{52,66},{66,52},{80,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{80,80}}, color={0,0,0}),
        Polygon(
          points={{-10,52},{0,42},{-10,32},{10,32},{0,42},{10,52},{-10,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-32},{0,-42},{-10,-52},{10,-52},{0,-42},{10,-32},{-10,
              -32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(graphics={
        Line(points={{-80,-80},{80,80}}, color={0,0,0}),
        Polygon(
          points={{80,80},{52,66},{66,52},{80,80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,52},{0,42},{-10,32},{10,32},{0,42},{10,52},{-10,52}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-32},{0,-42},{-10,-52},{10,-52},{0,-42},{10,-32},{
              -10,-32}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}));
end FluidPower2MechRotVar;
