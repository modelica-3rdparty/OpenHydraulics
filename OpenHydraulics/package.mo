within ;
package OpenHydraulics "A free Modelica library that can be used to model hydraulic components and circuits."
  extends Modelica.Icons.Package;
import      Modelica.Units.SI;
import Cv = Modelica.Units.Conversions;
import         Modelica.Units.NonSI;











  annotation (
  version="1.1",
  versionDate="2013-02-19",
  preferedView="info",
  Settings(NewStateSelection=true),
  uses(Modelica(version="4.0.0")),
  classOrder={"UsersGuide","Examples","Environment", "BasicModels","Components","Circuits","Fluids","Icons",
      "TemporaryTests", "*"});
end OpenHydraulics;
