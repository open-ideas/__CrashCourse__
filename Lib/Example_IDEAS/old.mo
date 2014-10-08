within Lib.Example_IDEAS;
package old "old stuff and models"
  model IntFloHeaFh "Int. concrete floor, insulated for floor heating"

    extends IDEAS.Buildings.Data.Interfaces.Construction(
      nLay=5, locGain=2,
      mats={IDEAS.Buildings.Data.Materials.Tile(d=0.012),
      IDEAS.Buildings.Data.Materials.Screed(d=0.14),
      IDEAS.Buildings.Data.Insulation.Pur(d=0.06),
       IDEAS.Buildings.Data.Materials.Concrete(d=0.20),
       IDEAS.Buildings.Data.Materials.Gypsum(d=0.012)});

  end IntFloHeaFh;

  model structure

  extends IDEAS.Interfaces.BaseClasses.Structure(nZones=2, ATrans=211, VZones={north.V,south.V});

    //Definition of the thermal zones
  IDEAS.Buildings.Components.Zone north(         nSurf=5, V=39.2)
      "north zone of office area"
    annotation (Placement(transformation(extent={{30,-38},{50,-18}})));
  IDEAS.Buildings.Components.Zone south(         nSurf=5, V=39.2)
      "south zone of office area"
    annotation (Placement(transformation(extent={{30,22},{50,42}})));
    //Definition of the building envelope for gF
  IDEAS.Buildings.Components.OuterWall north_ext(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
       AWall=3.51,
       insulationThickness=0.16,
       inc=IDEAS.Constants.Wall,
       azi=IDEAS.Constants.North)
    annotation (Placement(transformation(extent={{-5.5,-10.5},{5.5,10.5}},
        rotation=90,
        origin={-27.5,-53.5})));
  IDEAS.Buildings.Components.Window north_win(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
       A=5.4,
       inc=IDEAS.Constants.Wall,
       azi=IDEAS.Constants.North,
      redeclare IDEAS.Buildings.Components.Shading.Screen shaType)            annotation (Placement(transformation(
        extent={{-5.5,-10.5},{5.5,10.5}},
        rotation=90,
        origin={0.5,-53.5})));
    //Definition of the building envelope for fF
  IDEAS.Buildings.Components.OuterWall south_ext(
    redeclare IDEAS.Buildings.Data.Constructions.CavityWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.Rockwool insulationType,
       AWall=3.51,
       insulationThickness=0.16,
       inc=IDEAS.Constants.Wall,
       azi=IDEAS.Constants.South)
    annotation (Placement(transformation(extent={{-5.5,-10.5},{5.5,10.5}},
        rotation=90,
        origin={-27.5,6.5})));
  IDEAS.Buildings.Components.Window south_win(
    redeclare IDEAS.Buildings.Data.Glazing.Ins2Kr glazing,
    redeclare IDEAS.Buildings.Components.Shading.None shaType,
       A=5.4,
       inc=IDEAS.Constants.Wall,
       azi=IDEAS.Constants.South)                                             annotation (Placement(transformation(
        extent={{-5.5,-10.5},{5.5,10.5}},
        rotation=90,
        origin={0.5,6.5})));

  IDEAS.Buildings.Components.InternalWall wall(
    redeclare IDEAS.Buildings.Data.Insulation.Pur insulationType,
    insulationThickness=0.04,
    inc=IDEAS.Constants.Floor,
    azi=IDEAS.Constants.South,
       redeclare IDEAS.Buildings.Validation.Data.Constructions.HeavyWall
         constructionType,
      AWall=8.1)               annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-57,-10})));

  IDEAS.Buildings.Components.InternalWall south_floor(
    redeclare IDEAS.Buildings.Data.Insulation.Pur insulationType,
    insulationThickness=0.04,
    inc=IDEAS.Constants.Floor,
    azi=IDEAS.Constants.South,
       redeclare Example_IDEAS.IntFloHeaFh constructionType,
      AWall=11.9)                                                annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-103,20})));
  IDEAS.Buildings.Components.InternalWall north_floor(
    redeclare IDEAS.Buildings.Data.Insulation.Pur insulationType,
    insulationThickness=0.04,
    inc=IDEAS.Constants.Floor,
    azi=IDEAS.Constants.South,
       redeclare Example_IDEAS.IntFloHeaFh constructionType,
      AWall=11.9)                                                annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-103,-40})));
  equation
    //Connection to the connectors of the partial type

    //Connection of the gF floor

    //Connection of the fF floor

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
              -100},{150,100}}),
                               graphics));
  end structure;

  model Office "2-zone office building with TABS"

    import SI = Modelica.SIunits;

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
      redeclare .Lib.Example_IDEAS.SimpleOccupant      occupant,
      standAlone=true,
      redeclare IDEAS.Thermal.HeatingSystems.Heating_Embedded heatingSystem(
        FHChars=FHCharsArray,
        QNom={1000,1000},
        redeclare IDEAS.Thermal.Components.Production.HP_AirWater heater(
            modulation_min=30, modulation_start=40)))
      annotation (Placement(transformation(extent={{-38,14},{-18,34}})));
     annotation (experiment(StopTime=86400), __Dymola_experimentSetupOutput);
  end Office;

  model SimpleOccupant "Simple office occupant"
    extends IDEAS.Interfaces.BaseClasses.Occupant(
                                      nLoads=1);

  equation
  wattsLawPlug.P[1] = 0;
  wattsLawPlug.Q[1] = 0;
  for i in 1:nZones loop
    heatPortCon[i].Q_flow =  0;
    heatPortRad[i].Q_flow =  0;
    TSet[i] =  290.15;
  end for;
  mDHW60C = 0;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}),
                        graphics));
  end SimpleOccupant;

  model OfficeExtended "2-zone office building with TABS"

    import SI = Modelica.SIunits;

  //   inner IDEAS.SimInfoManager sim(redeclare IDEAS.Climate.Meteo.Files.min15
  //       detail, redeclare IDEAS.Climate.Meteo.Locations.Uccle city)
  //     annotation (Placement(transformation(extent={{-86,72},{-66,92}})));

      parameter Integer nZones = building.nZones;
      parameter SI.Area[nZones] AZones = {building.north_floor.AWall, building.south_floor.AWall};
      parameter IDEAS.Thermal.Components.BaseClasses.FH_Characteristics[nZones] FHCharsArray(
        A_Floor=AZones,
        each S_1=0.15,
        each S_2=0.15,
        each d_a=0.015,
        each T=0.2,
        each lambda_b=1.4,
        each rho_b=2100);

    extends IDEAS.Interfaces.Building(
      sim(redeclare IDEAS.Climate.Meteo.Files.min15 detail, redeclare
          IDEAS.Climate.Meteo.Locations.Uccle                                                             city),
      redeclare structure                         building(north(linear=true,TOpStart=293), south(linear=true,TOpStart=293)),
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.Buildings.Validation.BaseClasses.VentilationSystem.None
        ventilationSystem,
      redeclare SimpleOccupant                         occupant,
      standAlone=true,
      redeclare IDEAS.HeatingSystems.IdealRadiatorHeating     heatingSystem(
        QNom={1000,1000}))
      annotation (Placement(transformation(extent={{-38,14},{-18,34}})));
     annotation (experiment(StopTime=864000),__Dymola_experimentSetupOutput);
  end OfficeExtended;
end old;
