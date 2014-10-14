within Lib.Example_IDEAS;
model Office "Model of the whole office including HVAC and occupants"
  extends IDEAS.Interfaces.Building(redeclare IDEAS.VentilationSystems.None
      ventilationSystem,
    redeclare IDEAS.HeatingSystems.Heating_Embedded
      heatingSystem(AEmb=building.AZones, idealCtrlMixer(dynamicValve=true, tau
          =600)),
    redeclare Structure building(
      AZones={11.88,11.88}, VZones=building.AZones .* 3.3),
    redeclare Occupant_ISO13790 occupant(AZones=building.AZones, nLoads=0));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Office;
