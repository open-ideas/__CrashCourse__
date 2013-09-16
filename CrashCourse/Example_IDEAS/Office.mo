within CrashCourse.Example_IDEAS;
model Office "2-zone office building with TABS"

  inner IDEAS.SimInfoManager sim(redeclare IDEAS.Climate.Meteo.Files.min15
      detail, redeclare IDEAS.Climate.Meteo.Locations.Uccle city)
    annotation (Placement(transformation(extent={{-86,72},{-66,92}})));
  IDEAS.Interfaces.Building building(
    redeclare structure                         building(north(linear=true,TOpStart=293), south(linear=true,TOpStart=293)),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    redeclare SimpleOccupant                         occupant,
     redeclare HeatingOffice                  heatingSystem)
    annotation (Placement(transformation(extent={{-38,14},{-18,34}})));
   annotation (experiment(StopTime=86400), __Dymola_experimentSetupOutput);
end Office;
