within Lib.Example_IDEAS;
model Office "Model of the whole office including HVAC and occupants"
  extends IDEAS.Interfaces.Building(redeclare
      IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem, building(
      nZones=2,
      nEmb=1,
      AZones={11.88,11.88}),
    redeclare IDEAS.Buildings.Validation.BaseClasses.HeatingSystem.None
      heatingSystem);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Office;
