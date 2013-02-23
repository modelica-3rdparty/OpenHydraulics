within OpenHydraulics.Basic;
model GenericPressureLoss
  // the sizing parameters
  parameter SI.Diameter D_a "Diameter at port_a"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Diameter D_b "Diameter at port_b"
    annotation (Dialog(tab="Sizing"));

  // the flow behavior parameters
  parameter Real zeta1 = 2 "Loss factor for flow of port_a -> port_b"
    annotation (Dialog(tab="Flow Behavior"));
  parameter Real zeta2 = 2 "Loss factor for flow of port_a -> port_b"
    annotation (Dialog(tab="Flow Behavior"));
  parameter SI.ReynoldsNumber Re_turbulent = 1000
    "Loss factors suited for Re >= Re_turbulent"
    annotation (Dialog(tab="Flow Behavior"));
  parameter SI.Diameter D_Re = D_a "Diameter used to compute Re"
    annotation (Dialog(tab="Flow Behavior"));
  parameter Boolean zetaLaminarKnown=false
    "= true, if zeta = c0/Re in laminar region"
    annotation (Dialog(tab="Flow Behavior"));
  parameter Real c0=1
    "zeta = c0/Re; dp = zeta*d_Re*v_Re^2/2, Re=v_Re*D_Re*d_Re/eta_Re)"
    annotation(Dialog(enable=zetaLaminarKnown,tab="Flow Behavior"));

  extends BaseClasses.PartialPressureLoss;
equation
  data.D_a=D_a;
  data.D_b=D_b;
  data.kinv1=BaseClasses.lossConstant_D_zeta(D_a, zeta1);
  data.kinv2=BaseClasses.lossConstant_D_zeta(D_a, zeta2);
  data.Re_turbulent=Re_turbulent;
  data.D_Re=D_Re;
  data.zetaLaminarKnown=zetaLaminarKnown;
  data.c0=c0;
end GenericPressureLoss;
