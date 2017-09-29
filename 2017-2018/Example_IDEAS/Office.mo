within Example_IDEAS;
model Office "Model of the whole office including HVAC and occupants"
  extends IDEAS.Templates.Interfaces.Building(
    redeclare Ventilation ventilationSystem(recupEff=0.65, n={36,36}),
    redeclare IDEAS.Templates.Heating.IdealEmbeddedHeating
      heatingSystem(VZones=building.AZones .* 3.3,
      nLoads=0,
      QNom=building.Q_design),
    redeclare Structure building(
      AZones={11.88,11.88}, VZones=building.AZones .* 3.3,
      Q_design={building.north.Q_design,building.south.Q_design}),
    redeclare Occupant occupant(AZones=building.AZones, nLoads=0));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), experiment(
      StopTime=864000,
      Interval=600,
      Tolerance=1e-005,
      __Dymola_Algorithm="Radau"));
end Office;
