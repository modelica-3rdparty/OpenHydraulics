within OpenHydraulics.Basic;
model SharpEdgedOrifice
  "Sudden expansion in flow diameter from port_a to port_b"
  // the sizing parameters
  parameter SI.Diameter D_pipe
    "Inner diameter of pipe (= same at port_a and port_b)"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Diameter D_min "Smallest diameter of orifice"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Diameter L "Length of orifice"
    annotation (Dialog(tab="Sizing"));
  parameter NonSI.Angle_deg alpha "Angle of orifice"
    annotation (Dialog(tab="Sizing"));
  extends BaseClasses.PartialPressureLoss;
protected
  parameter Real D_rel = D_min/D_pipe;
  parameter Real LD = L/D_min;
  parameter Real k = 0.13 + 0.34*10^(-(3.4*LD+88.4*LD^2.3));
equation
  data.D_a=D_pipe;
  data.D_b=D_pipe;
  data.kinv1=BaseClasses.lossConstant_D_zeta(
          D_pipe, ((1 - D_rel) + 0.707*(1 - D_rel)^0.375)^2*(1/D_rel)^2);
  data.kinv2=BaseClasses.lossConstant_D_zeta(
          D_pipe, k*(1 - D_rel)^0.75 + (1 - D_rel)^2 + 2*sqrt(k*(1 - D_rel)^
          0.375) + (1 - D_rel));
  data.Re_turbulent=1e4;
  data.D_Re=D_min;
  data.zetaLaminarKnown=false;
  data.c0=0;
end SharpEdgedOrifice;
