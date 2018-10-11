within Lib.Example_IDEAS;
model Office
  "Model of the whole office including HVAC and occupants, with radiators"
  extends IDEAS.Interfaces.Building(redeclare package Medium =
        Lib.Example_IDEAS.Data.Medium,redeclare IDEAS.VentilationSystems.None
      ventilationSystem(redeclare package Medium = Medium),
    redeclare IDEAS.HeatingSystems.IdealRadiatorHeating
      heatingSystem(QNom=Q_design, VZones=building.VZones),
    redeclare Structure building(
      AZones={11.88,11.88},
      VZones=building.AZones .* 3.3,
      redeclare package Medium = Medium),
    redeclare Occupant_ISO13790 occupant(nLoads=0, AZones=building.AZones));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Office;
