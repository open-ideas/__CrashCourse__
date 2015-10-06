within Lib.Example_IDEAS;
model Office_FH
  "Model of the whole office including HVAC and occupants, with floor heating"
  extends IDEAS.Interfaces.Building(redeclare package Medium =
        Lib.Example_IDEAS.Data.Medium,redeclare IDEAS.VentilationSystems.None
      ventilationSystem(redeclare package Medium = Medium),
    redeclare IDEAS.HeatingSystems.Heating_Embedded
      heatingSystem(AEmb=building.AZones, idealCtrlMixer(dynamicValve=true, tau=
           600)),
    redeclare Structure_FH building(
      AZones={11.88,11.88},
      VZones=building.AZones .* 3.3,
      redeclare package Medium = Medium),
    redeclare Occupant_ISO13790 occupant(AZones=building.AZones, nLoads=0));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Office_FH;
