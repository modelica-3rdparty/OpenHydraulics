within OpenHydraulics.Types;
type RevoluteInit = enumeration(
    Free
       "Free (no initialization)",
    PositionVelocity
                   "Initialize generalized position and velocity variables",
    SteadyState
              "Initialize in steady state (velocity and acceleration are zero)",
    Position
           "Initialize only generalized position variable(s)",
    Velocity
           "Initialize only generalized velocity variable(s)",
    VelocityAcceleration
                       "Initialize generalized velocity and acceleration variables",
    PositionVelocityAcceleration
                               "Initialize generalized position, velocity and acceleration variables") "Enumeration defining initialization for MultiBody components"
annotation (
  Documentation(info="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th><strong>Types.Init.</strong></th><th><strong>Meaning</strong></th></tr>
<tr><td>Free</td>
    <td>No initialization</td></tr>

<tr><td>PositionVelocity</td>
    <td>Initialize generalized position and velocity variables</td></tr>

<tr><td>SteadyState</td>
    <td>Initialize in steady state (velocity and acceleration are zero)</td></tr>

<tr><td>Position </td>
    <td>Initialize only generalized position variable(s)</td></tr>

<tr><td>Velocity</td>
    <td>Initialize only generalized velocity variable(s)</td></tr>

<tr><td>VelocityAcceleration</td>
    <td>Initialize generalized velocity and acceleration variables</td></tr>

<tr><td>PositionVelocityAcceleration</td>
    <td>Initialize generalized position, velocity and acceleration variables</td></tr>
</table>
</html>"));
