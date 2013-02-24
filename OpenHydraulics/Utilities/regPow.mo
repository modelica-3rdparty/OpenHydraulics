within OpenHydraulics.Utilities;
function regPow
  "Anti-symmetric power approximation with non-zero derivative in the origin"
  extends Modelica.Icons.Function;

  input Real x;
  input Real a;
  input Real delta=0.01 "Range of significant deviation from x^a*sgn(x)";
  output Real y;
algorithm
  y := x*(x*x+delta*delta)^((a-1)/2);

  annotation(Documentation(info="<html>
This function approximates abs(x)^a*sign(x), such that the derivative is positive, finite and smooth in x=0. 
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2> 
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = regPow(x)</td><td>y ~= abs(x)^a*sgn(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = regPow(x)</td><td>y ~= x*delta^(a-1)</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
</html>",
      revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"),  Documentation(info="<html>
This function approximates sqrt(x)*sign(x), such that the derivative is finite and smooth in x=0. 
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2> 
<tr><th>Function</th><th>Approximation</th><th>Range</th></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= sqrt(abs(x))*sign(x)</td><td>abs(x) &gt;&gt delta</td></tr>
<tr><td>y = sqrtReg(x)</td><td>y ~= x/delta</td><td>abs(x) &lt;&lt  delta</td></tr>
</table>
<p>
With the default value of delta=0.01, the difference between sqrt(x) and sqrtReg(x) is 0.5% around x=0.1 and 0.005% around x=1.
</p> 
</html>",
      revisions="<html>
<ul>
<li><i>15 Mar 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created. </li>
</ul>
</html>"));
end regPow;
