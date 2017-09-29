within Example_IDEAS;
model Office_noFh "Model of the whole office including HVAC and occupants"
  extends IDEAS.Templates.Interfaces.Building(
    redeclare Ventilation ventilationSystem(recupEff=0.65, n={36,36}),
    redeclare IDEAS.Templates.Heating.IdealRadiatorHeating
      heatingSystem(nLoads=0,
      VZones=building.AZones .* 3.3,
      QNom=building.Q_design),
    redeclare Structure_noFH building(
      AZones={11.88,11.88}, VZones=building.AZones .* 3.3,
      Q_design={building.north.Q_design,building.south.Q_design}),
    redeclare Occupant occupant(nLoads=0, AZones=building.AZones));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Office_noFh;
