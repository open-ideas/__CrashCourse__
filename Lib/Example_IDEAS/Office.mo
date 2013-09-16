within Lib.Example_IDEAS;
model Office "2-zone office building with TABS"

  import SI =
            Modelica.SIunits;

  inner IDEAS.SimInfoManager sim(redeclare IDEAS.Climate.Meteo.Files.min15
      detail, redeclare IDEAS.Climate.Meteo.Locations.Uccle city)
    annotation (Placement(transformation(extent={{-86,72},{-66,92}})));

    parameter Integer nZones = building.building.nZones;
    parameter SI.Area[nZones] AZones = {building.building.north_floor.AWall, building.building.south_floor.AWall};
    parameter IDEAS.Thermal.Components.BaseClasses.FH_Characteristics[nZones] FHCharsArray(
      A_Floor=AZones,
      each S_1=0.15,
      each S_2=0.15,
      each d_a=0.015,
      each T=0.2,
      each lambda_b=1.4,
      each rho_b=2100);

  IDEAS.Interfaces.Building building(
    redeclare structure                         building(north(linear=true,TOpStart=293), south(linear=true,TOpStart=293)),
    redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
    redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
      ventilationSystem,
    redeclare SimpleOccupant                         occupant,
    standAlone=true,
    redeclare IDEAS.Thermal.HeatingSystems.Heating_Embedded heatingSystem(
      FHChars=FHCharsArray,
      QNom={1000,1000},
      redeclare IDEAS.Thermal.Components.Production.HP_AirWater heater(
          modulation_min=30, modulation_start=40)))
    annotation (Placement(transformation(extent={{-38,14},{-18,34}})));
   annotation (experiment(StopTime=86400), __Dymola_experimentSetupOutput);
end Office;
