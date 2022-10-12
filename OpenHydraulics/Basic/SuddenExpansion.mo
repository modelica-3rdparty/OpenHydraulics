within OpenHydraulics.Basic;
model SuddenExpansion "Sudden expansion in flow diameter from port_a to port_b"
  // the sizing parameters
  parameter SI.Diameter D_a "Diameter at port_a"
    annotation (Dialog(tab="Sizing"));
  parameter SI.Diameter D_b "Diameter at port_b"
    annotation (Dialog(tab="Sizing"));

  extends BaseClasses.PartialPressureLoss;

initial equation
  assert(D_a <= D_b, "D_a must be smaller than D_b");
equation
  data.D_a=D_a;
  data.D_b=D_b;
  data.kinv1=BaseClasses.lossConstant_D_zeta(
          D_a, (1 - (D_a/D_b)^2)^2);
  data.kinv2=BaseClasses.lossConstant_D_zeta(
          D_a, 0.5*(1 - (D_a/D_b)^2)^0.75);
  data.Re_turbulent=100;
  data.D_Re=D_a;
  data.zetaLaminarKnown=true;
  data.c0=30;

end SuddenExpansion;
