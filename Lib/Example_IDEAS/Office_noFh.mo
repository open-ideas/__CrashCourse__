within Lib.Example_IDEAS;
model Office_noFh "Model of the whole office including HVAC and occupants"
  extends IDEAS.Interfaces.Building(redeclare IDEAS.VentilationSystems.None
      ventilationSystem,
    redeclare IDEAS.HeatingSystems.Heating_Radiators
      heatingSystem(nLoads=0),
    redeclare Structure_noFH building(
      AZones={11.88,11.88}),
    redeclare Occupant_ISO13790 occupant(nLoads=0, AZones=building.AZones));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Office_noFh;
