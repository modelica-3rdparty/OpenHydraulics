within OpenHydraulics.Basic;
model VariableLaminarRestriction

  // sizing parameters
  parameter SI.VolumeFlowRate q_nom = 0.001 "Nominal flow rate at dp_nom"
    annotation(Dialog(tab="Sizing"));
  parameter SI.Pressure dp_nom = 1e6 "Nominal dp for metering curve"
    annotation(Dialog(tab="Sizing"));

  // the metering curve parameters
  parameter Real table[:, :]=[0,0; 1,1]
    "Metering curve (control = 1st col; fraction of q_nom = 2nd col)"
       annotation(Dialog(tab="Metering Curve",group="Table"));
  parameter Modelica.Blocks.Types.Smoothness smoothness=
    Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation"
    annotation(Dialog(tab="Metering Curve",group="Table"));
  parameter SI.Density d_nom = 850 "Nominal fluid density for metering curve"
    annotation(Dialog(tab="Metering Curve",group="Nominal values"));

  // advanced parameters
  parameter Real min_contr = 0 "Lower bound on control input"
    annotation(Dialog(tab="Metering Curve",group="Control"));
  parameter Real max_contr = 1 "Upper bound on control input"
    annotation(Dialog(tab="Metering Curve",group="Control"));

  extends BaseClasses.PartialLaminarRestriction(
    d=d_nom);

  Modelica.Blocks.Interfaces.RealInput control
    "control inside [min_contr,max_contr]"
    annotation (Placement(transformation(
        origin={0,-80},
        extent={{-20,20},{20,-20}},
        rotation=90)));

  Modelica.Blocks.Tables.CombiTable1Ds MeteringTable(
    tableOnFile=false,table=table,smoothness=smoothness)
    annotation (Placement(transformation(extent={{18,-32},{-2,-12}})));

protected
  Real opening = max(min(MeteringTable.y[1],1),0)
    "clip the output of the Metering table to [0,1]";

equation
  conductance = d_nom*opening*q_nom/dp_nom "Loss factor (function of control input)";
  MeteringTable.u =  max(min(control,max_contr),min_contr);
  annotation (Diagram(graphics={
        Line(
          points={{0,-60},{0,-60},{40,-60},{40,-22},{22,-22}},
          color={0,0,255},
          pattern=LinePattern.Dash),
        Polygon(
          points={{20,40},{4,24},{16,18},{20,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-20,-40},{20,40}}, color={0,0,0}),
        Line(
          points={{-20,-40},{-8,-40},{-8,-22},{-2,-22}},
          color={0,0,0},
          pattern=LinePattern.Dash)}),
                            Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{20,40},{4,24},{16,18},{20,40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Line(points={{-20,-40},{20,40}},
            color={0,0,0})}));
end VariableLaminarRestriction;
