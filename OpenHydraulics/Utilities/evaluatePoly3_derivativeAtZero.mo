within OpenHydraulics.Utilities;
function evaluatePoly3_derivativeAtZero
  "Evaluate polynomial of order 3 that passes the origin with a predefined derivative"

  input Real x "Value for which polynomial shall be evaluated";
  input Real x1 "Abscissa value";
  input Real y1 "y1=f(x1)";
  input Real y1d "First derivative at y1";
  input Real y0d "First derivative at f(x=0)";
  output Real y;
protected
  Real a1;
  Real a2;
  Real a3;
  Real xx;
algorithm
  a1 := x1*y0d;
  a2 := 3*y1 - x1*y1d - 2*a1;
  a3 := y1 - a2 - a1;
  xx := x/x1;
  y  := xx*(a1 + xx*(a2 + xx*a3));
  annotation(smoothOrder=3);
end evaluatePoly3_derivativeAtZero;
