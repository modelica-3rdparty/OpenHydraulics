within ;
package OpenHydraulics "A free Modelica library that can be used to model hydraulic components and circuits."
  extends Modelica.Icons.Package;
import SI = Modelica.SIunits;
import Cv = Modelica.SIunits.Conversions;
import NonSI = Modelica.SIunits.Conversions.NonSIunits;











  annotation (
  version="1.0",
  versionDate="2013-02-19",
  preferedView="info",
  Settings(NewStateSelection=true),
  uses(Modelica(version="3.2")),
  classOrder={"UsersGuide","Examples","Environment", "BasicModels","Components","Circuits","Fluids","Icons",
      "TemporaryTests", "*"});
end OpenHydraulics;
