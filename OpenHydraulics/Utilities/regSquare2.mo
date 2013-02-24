within OpenHydraulics.Utilities;
function regSquare2
  "Anti-symmetric approximation of square with discontinuous factor so that the first derivative is non-zero and is continuous"
  extends Modelica.Icons.Function;

  input Real x "abscissa value";
  input Real x_small(min=0)=0.01 "approximation of function for |x| <= x_small";
  input Real k1(min=0)=1 "y = (if x>=0 then k1 else k2)*x*|x|";
  input Real k2(min=0)=1 "y = (if x>=0 then k1 else k2)*x*|x|";
  input Boolean use_yd0 = false "= true, if yd0 shall be used";
  input Real yd0(min=0)=1 "Desired derivative at x=0: dy/dx = yd0";
  output Real y "ordinate value";
protected
  encapsulated function regSquare2_utility
    "Interpolating with two 3-order polynomials with a prescribed derivative at x=0"
    import OpenHydraulics.Utilities.evaluatePoly3_derivativeAtZero;
     input Real x;
     input Real x1 "approximation of function abs(x) < x1";
     input Real k1 "y = (if x>=0 then k1 else -k2)*x*|x|; k1 >= k2";
     input Real k2 "y = (if x>=0 then k1 else -k2)*x*|x|";
     input Boolean use_yd0 = false "= true, if yd0 shall be used";
     input Real yd0(min=0)=1 "Desired derivative at x=0: dy/dx = yd0";
     output Real y;
  protected
     Real x2;
     Real y1;
     Real y2;
     Real y1d;
     Real y2d;
     Real w;
     Real w1;
     Real w2;
     Real y0d;
  algorithm
     // x2 :=-x1*(k2/k1)^2;
     x2 := -x1;
     if x <= x2 then
        y := -k2*x^2;
     else
         y1 := k1*x1^2;
         y2 :=-k2*x2^2;
        y1d := k1*2*x1;
        y2d :=-k2*2*x2;
        if use_yd0 then
           y0d :=yd0;
        else
           /* Determine derivative, such that first and second derivative
              of left and right polynomial are identical at x=0:
              see derivation in function regRoot2
           */
           w :=x2/x1;
           y0d := ( (3*y2 - x2*y2d)/w - (3*y1 - x1*y1d)*w) /(2*x1*(1 - w));
        end if;

        /* Modify derivative y0d, such that the polynomial is 
           monotonically increasing. A sufficient condition is
             0 <= y0d <= sqrt(5)*k_i*|x_i|
        */
        w1 :=sqrt(5)*k1*x1;
        w2 :=sqrt(5)*k2*abs(x2);
        y0d :=min(y0d, 0.9*min(w1, w2));

        y := if x >= 0 then evaluatePoly3_derivativeAtZero(x,x1,y1,y1d,y0d) else
                            evaluatePoly3_derivativeAtZero(x,x2,y2,y2d,y0d);
     end if;
     annotation(smoothOrder=2);
  end regSquare2_utility;
algorithm
  y := smooth(2,if x >= x_small then k1*x^2 else
                if x <= -x_small then -k2*x^2 else
                if k1 >= k2 then regSquare2_utility(x,x_small,k1,k2,use_yd0,yd0) else
                                -regSquare2_utility(-x,x_small,k2,k1,use_yd0,yd0));
  annotation(smoothOrder=2, Documentation(info="<html>
<p>
Approximates the function
</p>
<pre>
   y = <b>if</b> x &ge; 0 <b>then</b> k1*x*x <b>else</b> -k2*x*x, with k1, k2 > 0
</pre>
<p>
in such a way that within the region -x_small &le; x &le; x_small, 
the function is described by two polynomials of third order
(one in the region -x_small .. 0 and one within the region 0 .. x_small)
such that
</p>
 
<ul>
<li> The derivative at x=0 is non-zero (in order that the
     inverse of the function does not have an infinite derivative). </li>
<li> The overall function is continuous with a
     continuous first derivative everywhere.</li>
<li> If parameter use_yd0 = <b>false</b>, the two polynomials
     are constructed such that the second derivatives at x=0
     are identical. If use_yd0 = <b>true</b>, the derivative
     at x=0 is explicitly provided via the additional argument
     yd0. If necessary, the derivative yd0 is automatically 
     reduced in order that the polynomials are strict monotonically  
     increasing <i>[Fritsch and Carlson, 1980]</i>.</li>
</ul>
</ul>
<p>
A typical screenshot for k1=1, k2=3 is shown in the next figure:
</p>
<p>
<img src=\"../Images/Components/regSquare2_b.png\">
</p>
 
<p>
The (smooth, non-zero) derivative of the function with
k1=1, k2=3 is shown in the next figure:
</p>
 
<p>
<img src=\"../Images/Components/regSquare2_c.png\">
</p>
 
<p>
<b>Literature</b>
</p>
 
<dl>
<dt> Fritsch F.N. and Carlson R.E. (1980):</dt>
<dd> <b>Monotone piecewise cubic interpolation</b>.
     SIAM J. Numerc. Anal., Vol. 17, No. 2, April 1980, pp. 238-246</dd>
</dl>
</html>",
        revisions="<html>
<ul>
<li><i>Nov., 2005</i>
    by <a href=\"mailto:Martin.Otter@DLR.de\">Martin Otter</a>:<br>
    Designed and implementated.</li>
</ul>
</html>"));
end regSquare2;
