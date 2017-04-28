within ;
package BuildingExample
  model Model "complete model"

    BuildingEnvelope.Building building
      annotation (Placement(transformation(extent={{-80,-20},{-20,40}})));
    Occupancy.Occup occup
      annotation (Placement(transformation(extent={{-96,-56},{-76,-36}})));
    HeatingSystems.Radiator radiator
      annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    Control.Controller controller
      annotation (Placement(transformation(extent={{-46,-48},{-26,-28}})));
    VentilationSystem.Ventilation ventilation
      annotation (Placement(transformation(extent={{-2,64},{18,84}})));
    inner IDEAS.BoundaryConditions.SimInfoManager sim
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  equation
    connect(radiator.heatPortCon[1], building.gainCon[1]) annotation (Line(
          points={{50.6,-30.5},{50.6,28.9},{-19.4,28.9}}, color={191,0,0}));
    connect(radiator.heatPortCon[2], building.gainCon[2]) annotation (Line(
          points={{50.6,-29.5},{52,-29.5},{52,28},{52,31.9},{-19.4,31.9}},
          color={191,0,0}));
    connect(radiator.heatPortRad[1], building.gainRad[1]) annotation (Line(
          points={{53.4,-30.5},{56,-30.5},{56,22},{56,17.5},{-19.4,17.5}},
          color={191,0,0}));
    connect(radiator.heatPortRad[2], building.gainRad[2]) annotation (Line(
          points={{53.4,-29.5},{54,-29.5},{54,16},{54,20.5},{-19.4,20.5}},
          color={191,0,0}));
    connect(controller.SignalRadiators, radiator.u) annotation (Line(points={{
            -25.2,-37.6},{6.4,-37.6},{6.4,-34},{40,-34}}, color={0,0,127}));
    connect(building.TSensor[1], controller.TSensor[1]) annotation (Line(points
          ={{-18.8,-0.5},{-18.8,-20},{-46,-20},{-46,-32}}, color={0,0,127}));
    connect(building.TSensor[2], controller.TSensor[2]) annotation (Line(points
          ={{-18.8,2.5},{-18.8,-20},{-46,-20},{-46,-30}}, color={0,0,127}));
    connect(occup.y, controller.TSet) annotation (Line(points={{-75.4,-43},{-56,
            -43},{-56,-35},{-46,-35}}, color={0,0,127}));
    connect(occup.gainOcc[1], building.occGains[1]) annotation (Line(points={{
            -76,-52.5},{-6,-52.5},{-6,-9.5},{-20,-9.5}}, color={191,0,0}));
    connect(occup.gainOcc[2], building.occGains[2]) annotation (Line(points={{
            -76,-51.5},{-42,-51.5},{-6,-51.5},{-6,-6.5},{-20,-6.5}}, color={191,
            0,0}));
    connect(ventilation.ventOut[1], building.ventIn[1]) annotation (Line(points
          ={{2,63.5},{2,38.5},{-47,38.5}}, color={0,127,255}));
    connect(ventilation.ventOut[1], building.ventIn[1]) annotation (Line(points
          ={{2,63.5},{2,63.5},{2,38},{-47,38},{-47,38.5}}, color={0,127,255}));
    connect(ventilation.ventIn[1], building.ventOut[1]) annotation (Line(points
          ={{6,63.5},{6,46},{-54,46},{-54,38.5},{-53,38.5}}, color={0,127,255}));
    connect(ventilation.ventIn[2], building.ventOut[2]) annotation (Line(points
          ={{6,64.5},{6,64.5},{6,46},{-53,46},{-53,41.5}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Model;

  package BuildingEnvelope

    model Building

      IDEAS.Buildings.Components.Zone north(
        redeclare package Medium = IDEAS.Media.Air,
        V=strPar.Vol_North,
        hZone=strPar.h,
        n50=strPar.n50,
        nSurf=5)        "north zone"
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      IDEAS.Buildings.Components.Zone south(
        redeclare package Medium = IDEAS.Media.Air,
        V=strPar.Vol_South,
        hZone=strPar.h,
        n50=strPar.n50,
        nSurf=5)        "south zone"
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      IDEAS.Buildings.Components.InternalWall internalWall_NorthSouth(
        redeclare Data.Constructions.InteriorWall constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=0,
        A=strPar.A_NorthSouth)   "internal wall between north and south zone"
        annotation (Placement(transformation(extent={{-6,0},{6,20}})));
      Data.Parameters.StrPar strPar
        annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
      IDEAS.Buildings.Components.Window southWindow(
        redeclare Data.Glazing.Ins2 glazing,
        inc=IDEAS.Types.Tilt.Wall,
        azi=IDEAS.Types.Azimuth.S,
        A=strPar.A_Windows,
        frac=0.15,
        redeclare Data.Frames.Frame fraType,
        redeclare IDEAS.Buildings.Components.Shading.None shaType)
        "window of the south zone" annotation (Placement(transformation(
            extent={{-6,10},{6,-10}},
            rotation=180,
            origin={66,30})));
      IDEAS.Buildings.Components.Zone garage(
        redeclare package Medium = IDEAS.Media.Air,
        V=strPar.Vol_Garage,
        hZone=strPar.hGar,
        n50=strPar.n50,
        nSurf=5)                             "garage of the building"
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      IDEAS.Buildings.Components.Window northWindow(
        redeclare Data.Glazing.Ins2 glazing,
        inc=IDEAS.Types.Tilt.Wall,
        azi=IDEAS.Types.Azimuth.N,
        frac=0.15,
        redeclare Data.Frames.Frame fraType,
        A=strPar.A_Windows,
        redeclare IDEAS.Buildings.Components.Shading.None shaType)
        "window of the north zone"
        annotation (Placement(transformation(extent={{-72,20},{-60,40}})));
      IDEAS.Buildings.Components.OuterWall northWall(
        redeclare Data.Constructions.ExteriorWall constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=IDEAS.Types.Azimuth.N,
        A=strPar.A_NorthWall)                        "outer wall of the north zone"
        annotation (Placement(transformation(extent={{-72,0},{-60,20}})));
      IDEAS.Buildings.Components.OuterWall southWall(
        redeclare Data.Constructions.ExteriorWall constructionType,
        inc=IDEAS.Types.Tilt.Wall,
        azi=IDEAS.Types.Azimuth.S,
        A=strPar.A_SouthWall)                        "outer wall of the south zone"
        annotation (Placement(transformation(extent={{72,0},{60,20}})));
      IDEAS.Buildings.Components.InternalWall internalWall_NorthGarage(
        azi=0,
        inc=IDEAS.Types.Tilt.Floor,
        A=strPar.A_NorthGarage,
        redeclare Data.Constructions.Floor constructionType)
        "internal wall between north zone and garage"
        annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=-90,
            origin={-30,-16})));
      IDEAS.Buildings.Components.InternalWall internalWall_SouthGarage(
        azi=0,
        redeclare Data.Constructions.Floor constructionType,
        inc=IDEAS.Types.Tilt.Floor,
        A=strPar.A_SouthGarage) "internal wall between south zone and garage"
        annotation (Placement(transformation(
            extent={{-6,-10},{6,10}},
            rotation=-90,
            origin={30,-16})));
      IDEAS.Buildings.Components.SlabOnGround slabOnGround(redeclare
          Data.Constructions.Slab constructionType, A=strPar.A_GarageSlab)
        "slab of building"
        annotation (Placement(transformation(extent={{-32,-80},{-20,-60}})));
      IDEAS.Buildings.Components.OuterWall[2] ceiling(
        inc=IDEAS.Types.Tilt.Ceiling,
        azi=0,
        A=strPar.A_Cei,
        redeclare Data.Constructions.Ceiling constructionType)
        "ceiling of the building"                     annotation (Placement(
            transformation(
            extent={{-6,-10},{6,10}},
            rotation=-90,
            origin={-2,66})));
      IDEAS.Buildings.Components.BoundaryWall[2] garageWall(redeclare
          Data.Constructions.ExteriorWall constructionType, use_T_in=true,
        inc=IDEAS.Types.Tilt.Wall,
        azi={IDEAS.Types.Azimuth.N,IDEAS.Types.Azimuth.S},
        A=strPar.A_GarageWall)
        "wall of the garage against the ground"
        annotation (Placement(transformation(extent={{-52,-60},{-40,-40}})));
      Modelica.Blocks.Sources.Constant[2] soil(k=273.15 + 12) "soil temperature"
        annotation (Placement(transformation(extent={{-90,-58},{-72,-40}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[2] gainCon
        "convective heat gains of each zone"
        annotation (Placement(transformation(extent={{92,58},{112,78}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[2] gainRad
        "radiative heat gains of each zone"
        annotation (Placement(transformation(extent={{92,20},{112,40}})));
      Modelica.Blocks.Interfaces.RealOutput TSensor[2]
        annotation (Placement(transformation(extent={{94,-40},{114,-20}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[2] embHeat
        "radiative heat gains of each zone"
        annotation (Placement(transformation(extent={{92,-10},{112,10}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[2] occGains
        "radiative heat gains of each zone"
        annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      Modelica.Fluid.Interfaces.FluidPort_a ventIn[2](redeclare package Medium
          = IDEAS.Media.Air)
        annotation (Placement(transformation(extent={{0,90},{20,110}})));
      Modelica.Fluid.Interfaces.FluidPort_b ventOut[2](redeclare package Medium
          = IDEAS.Media.Air)
        annotation (Placement(transformation(extent={{-20,90},{0,110}})));
      outer IDEAS.BoundaryConditions.SimInfoManager sim
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    equation
      connect(north.propsBus[1], northWall.propsBus_a) annotation (Line(
          points={{-40,15.6},{-50,15.6},{-50,12},{-61,12}},
          color={255,204,51},
          thickness=0.5));
      connect(north.propsBus[2], northWindow.propsBus_a) annotation (Line(
          points={{-40,14.8},{-40,14.8},{-40,32},{-61,32}},
          color={255,204,51},
          thickness=0.5));
      connect(north.propsBus[3], internalWall_NorthSouth.propsBus_b) annotation (
          Line(
          points={{-40,14},{-40,14},{-40,24},{-10,24},{-10,12},{-5,12}},
          color={255,204,51},
          thickness=0.5));
      connect(north.propsBus[4], ceiling[1].propsBus_a) annotation (Line(
          points={{-40,13.2},{-40,13.2},{-40,60},{0,60},{0,61}},
          color={255,204,51},
          thickness=0.5));
      connect(north.propsBus[5], internalWall_NorthGarage.propsBus_b) annotation (
          Line(
          points={{-40,12.4},{-40,-6},{-28,-6},{-28,-11}},
          color={255,204,51},
          thickness=0.5));
      connect(south.propsBus[1], southWall.propsBus_a) annotation (Line(
          points={{20,15.6},{20,15.6},{20,20},{20,26},{48,26},{48,12},{61,12}},
          color={255,204,51},
          thickness=0.5));
      connect(south.propsBus[2], southWindow.propsBus_a) annotation (Line(
          points={{20,14.8},{20,14.8},{20,32},{61,32}},
          color={255,204,51},
          thickness=0.5));
      connect(south.propsBus[3], internalWall_NorthSouth.propsBus_a) annotation (
          Line(
          points={{20,14},{14,14},{14,12},{5,12}},
          color={255,204,51},
          thickness=0.5));
      connect(south.propsBus[4], ceiling[2].propsBus_a) annotation (Line(
          points={{20,13.2},{18,13.2},{18,60},{0,60},{0,61}},
          color={255,204,51},
          thickness=0.5));
      connect(south.propsBus[5], internalWall_SouthGarage.propsBus_b) annotation (
          Line(
          points={{20,12.4},{20,-11},{32,-11}},
          color={255,204,51},
          thickness=0.5));
      connect(garage.propsBus[1], garageWall[1].propsBus_a) annotation (Line(
          points={{-10,-44.4},{-26,-44.4},{-26,-48},{-41,-48}},
          color={255,204,51},
          thickness=0.5));
      connect(garage.propsBus[2], garageWall[2].propsBus_a) annotation (Line(
          points={{-10,-45.2},{-22,-45.2},{-22,-48},{-41,-48}},
          color={255,204,51},
          thickness=0.5));
      connect(garage.propsBus[3], internalWall_NorthGarage.propsBus_a) annotation (
          Line(
          points={{-10,-46},{-28,-46},{-28,-21}},
          color={255,204,51},
          thickness=0.5));
      connect(garage.propsBus[4], internalWall_SouthGarage.propsBus_a) annotation (
          Line(
          points={{-10,-46.8},{-10,-21},{32,-21}},
          color={255,204,51},
          thickness=0.5));
      connect(garage.propsBus[5], slabOnGround.propsBus_a) annotation (Line(
          points={{-10,-47.6},{-10,-68},{-21,-68}},
          color={255,204,51},
          thickness=0.5));
      connect(soil[1].y, garageWall[1].T) annotation (Line(points={{-71.1,-49},{-64.55,
              -49},{-64.55,-48},{-56.6,-48}}, color={0,0,127}));
      connect(soil[2].y, garageWall[2].T) annotation (Line(points={{-71.1,-49},{-64.55,
              -49},{-64.55,-48},{-56.6,-48}}, color={0,0,127}));
      connect(north.gainCon, gainCon[1]);
      connect(south.gainCon, gainCon[2]);
      connect(south.gainRad, gainRad[2]);
      connect(north.gainRad, gainRad[1]);
      connect(south.TSensor, TSensor[2]);
      connect(north.TSensor, TSensor[1]);
      connect(gainCon[1], north.gainCon);
      connect(gainCon[2], south.gainCon);
      connect(gainRad[1], north.gainRad);
      connect(gainRad[2], south.gainRad);
      connect(internalWall_NorthGarage.port_emb[1], embHeat[1]) annotation (Line(
            points={{-40,-16},{-40,-16},{-40,-8},{-40,-5},{102,-5}}, color={191,0,
              0}));
      connect(internalWall_SouthGarage.port_emb[1], embHeat[2])
        annotation (Line(points={{20,-16},{20,5},{102,5}}, color={191,0,0}));
      connect(occGains[1], north.gainRad) annotation (Line(points={{100,-65},{40,-65},
              {40,-62},{-20,-62},{-20,4}}, color={191,0,0}));
      connect(occGains[2], south.gainRad)
        annotation (Line(points={{100,-55},{40,-55},{40,4}}, color={191,0,0}));
      connect(ventIn[1], north.port_a) annotation (Line(points={{10,95},{10,34},{-28,
              34},{-28,20}}, color={0,127,255}));
      connect(ventIn[2], south.port_a) annotation (Line(points={{10,105},{10,105},{10,
              34},{32,34},{32,20}}, color={0,127,255}));
      connect(ventOut[1], north.port_b) annotation (Line(points={{-10,95},{-10,95},{
              -10,28},{-10,26},{-32,26},{-32,20}}, color={0,127,255}));
      connect(ventOut[2], south.port_b) annotation (Line(points={{-10,105},{-10,105},
              {-10,26},{26,26},{26,20},{28,20}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-60,20},{60,-80}}, lineColor={28,108,200}), Line(
                points={{-60,20},{0,80},{60,20}}, color={28,108,200})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Building;
  end BuildingEnvelope;

  package HeatingSystems

    model Radiator "heating system"

      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radNorth(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.05,
        dp_nominal=1000,
        Q_flow_nominal=600,
        T_a_nominal=328.15,
        T_b_nominal=308.15) "radiator for the north zone"
        annotation (Placement(transformation(extent={{36,26},{56,46}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
            IDEAS.Media.Water, m_flow_nominal=0.1) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-54,30})));
      IDEAS.Fluid.Sources.Boundary_pT bou(
        redeclare package Medium = IDEAS.Media.Water,
        nPorts=1,
        p=200000)
        annotation (Placement(transformation(extent={{-96,-16},{-76,4}})));
      IDEAS.Fluid.HeatExchangers.HeaterCooler_u hea(
        redeclare package Medium = IDEAS.Media.Water,
        dp_nominal=0,
        m_flow_nominal=0.1,
        Q_flow_nominal=1500)
        annotation (Placement(transformation(extent={{-32,44},{-12,64}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[2] heatPortCon
        annotation (Placement(transformation(extent={{-4,90},{16,110}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[2] heatPortRad
        annotation (Placement(transformation(extent={{24,90},{44,110}})));
      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
      Data.Parameters.StrPar strPar
        annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
      IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radSouth(
        redeclare package Medium = IDEAS.Media.Water,
        m_flow_nominal=0.05,
        dp_nominal=1000,
        Q_flow_nominal=600,
        T_a_nominal=328.15,
        T_b_nominal=308.15) "radiator for the south zone"
        annotation (Placement(transformation(extent={{54,58},{74,78}})));
      Modelica.Blocks.Math.Gain gain(k=0.6) annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={-72,46})));
      outer IDEAS.BoundaryConditions.SimInfoManager sim
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    equation
      connect(fan.port_b, hea.port_a) annotation (Line(points={{-54,40},{-52,40},
              {-52,54},{-32,54}}, color={0,127,255}));
      connect(u, hea.u)
        annotation (Line(points={{-100,60},{-68,60},{-34,60}}, color={0,0,127}));
      connect(bou.ports[1], fan.port_a) annotation (Line(points={{-76,-6},{-54,
              -6},{-54,20}},        color={0,127,255}));
      connect(radNorth.heatPortCon, heatPortCon[1]) annotation (Line(points={{44,43.2},
              {22,43.2},{22,95},{6,95}}, color={191,0,0}));
      connect(radNorth.heatPortRad, heatPortRad[1]) annotation (Line(points={{48,43.2},
              {38,43.2},{38,95},{34,95}}, color={191,0,0}));
      connect(radSouth.heatPortCon, heatPortCon[2]) annotation (Line(points={{62,75.2},
              {34,75.2},{34,84},{6,84},{6,105}},color={191,0,0}));
      connect(radSouth.heatPortRad, heatPortRad[2]) annotation (Line(points={{66,75.2},
              {74,75.2},{74,105},{34,105}}, color={191,0,0}));
      connect(hea.port_b, radNorth.port_a) annotation (Line(points={{-12,54},{
              10,54},{10,36},{36,36}}, color={0,127,255}));
      connect(radNorth.port_b, fan.port_a) annotation (Line(points={{56,36},{86,
              36},{86,20},{-54,20}}, color={0,127,255}));
      connect(radSouth.port_a, hea.port_b) annotation (Line(points={{54,68},{22,
              68},{22,54},{-12,54}}, color={0,127,255}));
      connect(radSouth.port_b, fan.port_a) annotation (Line(points={{74,68},{86,
              68},{86,20},{-54,20}}, color={0,127,255}));
      connect(gain.u, hea.u) annotation (Line(points={{-72,53.2},{-72,60},{-34,
              60}}, color={0,0,127}));
      connect(gain.y, fan.m_flow_in) annotation (Line(points={{-72,39.4},{-72,
              39.4},{-72,29.8},{-66,29.8}}, color={0,0,127}));
        annotation (Line(points={{6,100},{6,100}},        color={191,0,0}),
                  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Ellipse(
              extent={{-40,40},{50,-48}},
              lineColor={255,0,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end Radiator;

    model TABS

      IDEAS.Fluid.Production.HP_WaterWater_OnOff heatPumpOnOff(
        onOff=true,
        use_scaling=true,
        use_onOffSignal=true,
        redeclare
          IDEAS.Fluid.Production.Data.PerformanceMaps.VitoCal300GBWS301dotA08
          heatPumpData,
        redeclare package Medium2 = IDEAS.Media.Water,
        redeclare package Medium1 = IDEAS.Media.Water,
        P_the_nominal=3000)
                         annotation (Placement(transformation(
            extent={{15,-17},{-15,17}},
            rotation=180,
            origin={15,25})));

      IDEAS.Fluid.Movers.FlowControlled_m_flow evaporatorPump(      m_flow_nominal=0.6,
          redeclare package Medium = IDEAS.Media.Water)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-44,-34})));
      IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe TABSSouth(
        redeclare package Medium = IDEAS.Media.Water,
        A_floor=strPar.A_SouthGarage,
        redeclare
          IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
          RadSlaCha,
        m_flow_nominal=0.6)
        annotation (Placement(transformation(extent={{32,66},{52,86}})));
      IDEAS.Fluid.HeatExchangers.RadiantSlab.EmbeddedPipe TABSNorth(
        redeclare package Medium = IDEAS.Media.Water,
        A_floor=strPar.A_NorthGarage,
        redeclare
          IDEAS.Fluid.HeatExchangers.RadiantSlab.BaseClasses.FH_Standard1
          RadSlaCha,
        m_flow_nominal=0.6)
        annotation (Placement(transformation(extent={{-28,66},{-8,86}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow condenserPump(m_flow_nominal=0.6,
          redeclare package Medium = IDEAS.Media.Water) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-42,54})));
      Data.Parameters.StrPar strPar
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[2] embHeat
        annotation (Placement(transformation(extent={{-10,88},{10,108}})));
      IDEAS.Fluid.Sources.Boundary_pT water(
        redeclare package Medium = IDEAS.Media.Water,
        nPorts=1,
        p=200000)
        annotation (Placement(transformation(extent={{-100,26},{-80,46}})));
      IDEAS.Fluid.Sources.Boundary_pT glycol(
        nPorts=1,
        p=150000,
        redeclare package Medium = IDEAS.Media.Water)
        annotation (Placement(transformation(extent={{-100,-18},{-80,2}})));
      IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.MultipleBoreHolesUTube
                             multipleBoreholes(
        bfData=bfData,
        dp_nominal=0,
        redeclare package Medium = IDEAS.Media.Water)
                         "borefield"
        annotation (Placement(transformation(extent={{26,-78},{-14,-38}})));
      parameter IDEAS.Fluid.HeatExchangers.GroundHeatExchangers.Borefield.Data.BorefieldData.SandStone_Bentonite_c8x1_h110_b5_d600_T283
        bfData
        annotation (Placement(transformation(extent={{80,60},{100,80}})));
      Modelica.Blocks.Interfaces.BooleanInput Signal
        annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
      Modelica.Blocks.Math.BooleanToReal booleanToReal
        annotation (Placement(transformation(extent={{-100,72},{-80,92}})));
      Modelica.Blocks.Math.Gain gain(k=0.6)
        annotation (Placement(transformation(extent={{-74,76},{-62,88}})));
      outer IDEAS.BoundaryConditions.SimInfoManager sim
        annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
    equation
      connect(evaporatorPump.port_b, heatPumpOnOff.port_a1) annotation (Line(points={{-44,-24},
              {-44,-24},{-44,12},{-44,14.8},{0,14.8}},             color={0,127,255}));
      connect(heatPumpOnOff.port_b2, condenserPump.port_a) annotation (Line(points={{0,35.2},
              {-42,35.2},{-42,44}},            color={0,127,255}));
      connect(condenserPump.port_b, TABSNorth.port_a) annotation (Line(points={{-42,64},
              {-42,64},{-42,76},{-28,76}},     color={0,127,255}));
      connect(TABSNorth.port_b, TABSSouth.port_a)
        annotation (Line(points={{-8,76},{12,76},{32,76}},  color={0,127,255}));
      connect(TABSSouth.port_b, heatPumpOnOff.port_a2) annotation (Line(points={{52,76},
              {60,76},{70,76},{70,35.2},{30,35.2}},     color={0,127,255}));
      connect(TABSNorth.heatPortEmb[1], embHeat[1]) annotation (Line(points={{
              -18,86},{-18,86},{-18,93},{0,93}}, color={191,0,0}));
      connect(glycol.ports[1], heatPumpOnOff.port_a1) annotation (Line(points={
              {-80,-8},{-44,-8},{-44,14.8},{0,14.8}}, color={0,127,255}));
      connect(water.ports[1], condenserPump.port_a) annotation (Line(points={{
              -80,36},{-42,36},{-42,44}}, color={0,127,255}));
      connect(TABSSouth.heatPortEmb[1], embHeat[2]) annotation (Line(points={{
              42,86},{28,86},{28,103},{0,103}}, color={191,0,0}));
      connect(multipleBoreholes.port_b, evaporatorPump.port_a) annotation (Line(
            points={{-14,-58},{-28,-58},{-44,-58},{-44,-44}}, color={0,127,255}));
      connect(multipleBoreholes.port_a, heatPumpOnOff.port_b1) annotation (Line(
            points={{26,-58},{40,-58},{40,-56},{40,14.8},{30,14.8}}, color={0,
              127,255}));
      connect(heatPumpOnOff.on, Signal) annotation (Line(points={{12,6.64},{12,
              6.64},{12,-38},{12,-40},{-100,-40}}, color={255,0,255}));
      connect(Signal, booleanToReal.u) annotation (Line(points={{-100,-40},{
              -116,-40},{-116,82},{-102,82}}, color={255,0,255}));
      connect(booleanToReal.y, gain.u) annotation (Line(points={{-79,82},{-76,
              82},{-75.2,82}}, color={0,0,127}));
      connect(gain.y, condenserPump.m_flow_in) annotation (Line(points={{-61.4,
              82},{-54,82},{-54,53.8}}, color={0,0,127}));
      connect(gain.y, evaporatorPump.m_flow_in) annotation (Line(points={{-61.4,
              82},{-60,82},{-60,-34.2},{-56,-34.2}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Polygon(points={{74,80},{-80,48},{74,80}}, lineColor={28,108,200}),
            Line(points={{-80,48},{78,20},{-80,-10},{78,-48},{-80,-80}}, color=
                  {28,108,200})}),                                   Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end TABS;
  end HeatingSystems;

  package VentilationSystem

    model Ventilation

      IDEAS.Fluid.Sources.Boundary_pT bouAir(
        nPorts=2,
        redeclare package Medium = IDEAS.Media.Air,
        use_T_in=true)                        "Boundary for air model"
        annotation (Placement(transformation(extent={{88,52},{68,72}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow fanRet(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        inputType=IDEAS.Fluid.Types.InputType.Constant,
        tau=0,
        filteredSpeed=false,
        redeclare package Medium = IDEAS.Media.Air,
        constantMassFlowRate=2*36*1.2/3600,
        m_flow_nominal=2*36*1.2/3600,
        dp_nominal=100)                       "Return fan"
        annotation (Placement(transformation(extent={{28,62},{48,82}})));
      IDEAS.Fluid.Movers.FlowControlled_m_flow fanSup(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        inputType=IDEAS.Fluid.Types.InputType.Constant,
        tau=0,
        filteredSpeed=false,
        redeclare package Medium = IDEAS.Media.Air,
        constantMassFlowRate=2*36*1.2/3600,
        m_flow_nominal=2*36*1.2/3600,
        dp_nominal=100)                       "Supply fan"
        annotation (Placement(transformation(extent={{50,22},{30,42}})));
      IDEAS.Fluid.HeatExchangers.ConstantEffectiveness
                                                 hex(
        redeclare package Medium1 = IDEAS.Media.Air,
        redeclare package Medium2 = IDEAS.Media.Air,
        eps=0.65,
        m1_flow_nominal=2*36*1.2/3600,
        m2_flow_nominal=2*36*1.2/3600,
        dp1_nominal=500,
        dp2_nominal=500) "Heat recovery unit"
        annotation (Placement(transformation(extent={{-2,42},{18,62}})));
      IDEAS.Fluid.FixedResistances.Junction splitter(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        redeclare package Medium = IDEAS.Media.Air,
        m_flow_nominal={2*36*1.2/3600,-36*1.2/3600,-36*1.2/3600},
        dp_nominal={1000,-500,-500})
        annotation (Placement(transformation(extent={{-30,10},{-50,30}})));
      Modelica.Fluid.Interfaces.FluidPort_a[2] ventIn(redeclare package Medium
          = IDEAS.Media.Air)
        annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b[2] ventOut(redeclare package Medium
          = IDEAS.Media.Air)
        annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
      IDEAS.Fluid.FixedResistances.Junction splitter1(
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
        portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
        redeclare package Medium = IDEAS.Media.Air,
        m_flow_nominal={-2*36*1.2/3600,36*1.2/3600,36*1.2/3600},
        dp_nominal={-1000,500,500})
        annotation (Placement(transformation(extent={{0,-42},{-20,-22}})));
      outer IDEAS.BoundaryConditions.SimInfoManager sim
        annotation (Placement(transformation(extent={{40,-20},{60,0}})));
      IDEAS.Buildings.Components.Interfaces.WeaBus
                                             weaBus1(numSolBus=sim.numIncAndAziInBus,
          outputAngles=sim.outputAngles)
        annotation (Placement(transformation(extent={{70,8},{90,28}})));
    equation
      connect(bouAir.ports[1], fanSup.port_a) annotation (Line(points={{68,64},{62,64},
              {62,52},{50,52},{50,32}}, color={0,127,255}));
      connect(fanSup.port_b, hex.port_a2)
        annotation (Line(points={{30,32},{30,46},{18,46}}, color={0,127,255}));
      connect(hex.port_b2, splitter.port_1) annotation (Line(points={{-2,46},{-12,46},
              {-12,44},{-12,20},{-30,20}}, color={0,127,255}));
      connect(hex.port_b1, fanRet.port_a)
        annotation (Line(points={{18,58},{28,58},{28,72}}, color={0,127,255}));
      connect(fanRet.port_b, bouAir.ports[2]) annotation (Line(points={{48,72},{50,72},
              {50,64},{50,60},{68,60}}, color={0,127,255}));
      connect(splitter.port_3, ventOut[2]) annotation (Line(points={{-40,10},{-40,10},
              {-40,-95},{-60,-95}}, color={0,127,255}));
      connect(splitter.port_2, ventOut[1]) annotation (Line(points={{-50,20},{-60,20},
              {-60,-105}}, color={0,127,255}));
      connect(splitter1.port_1, hex.port_a1) annotation (Line(points={{0,-32},{
              -2,-32},{-2,58}}, color={0,127,255}));
      connect(splitter1.port_3, ventIn[2]) annotation (Line(points={{-10,-42},{
              -10,-42},{-10,-100},{-10,-95},{-20,-95}}, color={0,127,255}));
      connect(splitter1.port_2, ventIn[1]) annotation (Line(points={{-20,-32},{
              -20,-105},{-20,-105}}, color={0,127,255}));
      connect(sim.weaBus, weaBus1) annotation (Line(
          points={{56,-7.2},{80,-7.2},{80,18}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(weaBus1.Te, bouAir.T_in) annotation (Line(
          points={{80.05,18.05},{96,18.05},{96,66},{90,66}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Ellipse(
              extent={{-40,40},{50,-48}},
              lineColor={0,127,0},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Ventilation;
  end VentilationSystem;

  package Control

    model Controller

      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=-1, uHigh=1)
               annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Modelica.Blocks.Logical.Not not1
        annotation (Placement(transformation(extent={{22,40},{42,60}})));
      Modelica.Blocks.Interfaces.RealInput[2] TSensor
        annotation (Placement(transformation(extent={{-120,50},{-80,90}})));

      Modelica.Blocks.Interfaces.RealInput TSet
        annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=(TSensor[1] +
            TSensor[2])/2 - TSet)
        annotation (Placement(transformation(extent={{-64,40},{-44,60}})));
      Modelica.Blocks.Interfaces.BooleanOutput SignalTABS
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Modelica.Blocks.Math.BooleanToReal booleanToReal
        annotation (Placement(transformation(extent={{58,-6},{78,14}})));
      Modelica.Blocks.Interfaces.RealOutput SignalRadiators
        annotation (Placement(transformation(extent={{98,-6},{118,14}})));
      outer IDEAS.BoundaryConditions.SimInfoManager sim
        annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
    equation

      connect(hysteresis.y, not1.u)
        annotation (Line(points={{1,50},{20,50}}, color={255,0,255}));
      connect(realExpression.y, hysteresis.u)
        annotation (Line(points={{-43,50},{-32,50},{-22,50}}, color={0,0,127}));
      connect(not1.y, SignalTABS)
        annotation (Line(points={{43,50},{110,50}}, color={255,0,255}));
      connect(SignalTABS, SignalTABS) annotation (Line(points={{110,50},{107,50},
              {110,50}}, color={255,0,255}));
      connect(booleanToReal.y, SignalRadiators)
        annotation (Line(points={{79,4},{108,4}}, color={0,0,127}));
      connect(booleanToReal.u, SignalTABS) annotation (Line(points={{56,4},{52,
              4},{52,50},{110,50}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-40,40},{40,-40}}, lineColor={28,108,200}),
            Line(points={{-20,26},{-20,58}}, color={28,108,200}),
            Line(points={{0,26},{0,58}}, color={28,108,200}),
            Line(points={{20,26},{20,58}}, color={28,108,200}),
            Line(points={{20,-56},{20,-24}}, color={28,108,200}),
            Line(points={{0,-56},{0,-24}}, color={28,108,200}),
            Line(points={{-20,-56},{-20,-24}}, color={28,108,200}),
            Line(points={{-54,-10},{-28,-10}}, color={28,108,200}),
            Line(points={{-54,10},{-28,10}}, color={28,108,200}),
            Line(points={{28,10},{54,10}}, color={28,108,200}),
            Line(points={{28,-10},{54,-10}}, color={28,108,200})}), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Controller;
  end Control;

  package Occupancy

    model Occup

    public
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{96,20},{116,40}})));
      IDEAS.Controls.SetPoints.OccupancySchedule occSch(occupancy=3600*{7,17})
        annotation (Placement(transformation(extent={{-86,22},{-66,42}})));
      Modelica.Blocks.Math.BooleanToReal booleanToReal
        annotation (Placement(transformation(extent={{-50,16},{-30,36}})));
      Modelica.Blocks.Math.Gain TSetOcc(k=273.15 + 21)
        annotation (Placement(transformation(extent={{32,22},{52,42}})));
      Modelica.Blocks.Sources.Constant TSetNoOcc(k=273.15 + 15)
        annotation (Placement(transformation(extent={{30,-14},{50,6}})));
      IDEAS.Utilities.Math.Max max(nin=2)
        annotation (Placement(transformation(extent={{62,2},{82,22}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow[2] prescribedHeatFlow
        annotation (Placement(transformation(extent={{66,-70},{86,-50}})));
      Modelica.Blocks.Sources.Constant[2] heatGainNoOcc(k=2*{strPar.A_NorthGarage,
            strPar.A_SouthGarage})
        annotation (Placement(transformation(extent={{-10,-88},{10,-68}})));
      Modelica.Blocks.Math.Gain[2] heatGainOcc(k=20*{strPar.A_NorthGarage,strPar.A_SouthGarage})
        annotation (Placement(transformation(extent={{-8,-52},{12,-32}})));
      IDEAS.Utilities.Math.Max[2] max1(nin=2)
        annotation (Placement(transformation(extent={{32,-70},{52,-50}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b[2] gainOcc
        annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      Data.Parameters.StrPar strPar
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
    equation

      connect(occSch.occupied, booleanToReal.u)
        annotation (Line(points={{-65,26},{-52,26}}, color={255,0,255}));
      connect(booleanToReal.y, TSetOcc.u)
        annotation (Line(points={{-29,26},{-29,32},{30,32}}, color={0,0,127}));
      connect(TSetNoOcc.y, max.u[2]) annotation (Line(points={{51,-4},{54,-4},{54,13},
              {60,13}}, color={0,0,127}));
      connect(TSetOcc.y, max.u[1])
        annotation (Line(points={{53,32},{60,32},{60,11}}, color={0,0,127}));
      connect(max.y, y) annotation (Line(points={{83,12},{83,20},{106,20},{106,30}},
            color={0,0,127}));
      connect(booleanToReal.y, heatGainOcc[1].u) annotation (Line(points={{-29,26},{
              -30,26},{-30,-42},{-10,-42}}, color={0,0,127}));
      connect(heatGainOcc[1].y, max1[1].u[1]) annotation (Line(points={{13,-42},{20,
              -42},{20,-61},{30,-61}}, color={0,0,127}));
      connect(heatGainNoOcc[1].y, max1[1].u[2]) annotation (Line(points={{11,-78},{20,
              -78},{20,-59},{30,-59}}, color={0,0,127}));
      connect(max1[1].y, prescribedHeatFlow[1].Q_flow)
        annotation (Line(points={{53,-60},{59.5,-60},{66,-60}}, color={0,0,127}));
      connect(prescribedHeatFlow[1].port, gainOcc[1])
        annotation (Line(points={{86,-60},{100,-60},{100,-65}}, color={191,0,0}));
      connect(booleanToReal.y, heatGainOcc[2].u) annotation (Line(points={{-29,26},{
              -30,26},{-30,-42},{-10,-42}}, color={0,0,127}));
      connect(heatGainOcc[2].y, max1[2].u[1]) annotation (Line(points={{13,-42},{20,
              -42},{20,-61},{30,-61}}, color={0,0,127}));
      connect(heatGainNoOcc[2].y, max1[2].u[2]) annotation (Line(points={{11,-78},{20,
              -78},{20,-59},{30,-59}}, color={0,0,127}));
      connect(max1[2].y, prescribedHeatFlow[2].Q_flow)
        annotation (Line(points={{53,-60},{60,-60},{66,-60}}, color={0,0,127}));
      connect(prescribedHeatFlow[2].port, gainOcc[2])
        annotation (Line(points={{86,-60},{100,-60},{100,-55}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Ellipse(extent={{-24,72},{26,20}}, lineColor={0,0,0}), Line(points={{0,
                  20},{0,-38},{-40,-80},{0,-38},{40,-80},{0,-38},{0,0},{40,0},{-40,0}},
                color={0,0,0})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Occup;
  end Occupancy;

  package Data
    package Parameters
      record StrPar

        extends Modelica.Icons.Record;

        //Zone Parameters
        parameter Modelica.SIunits.Height h = 0.7+2+0.3 "height of upper zones";
        parameter Modelica.SIunits.Length l = 4.4 "length of upper zones";
        parameter Modelica.SIunits.Height hGar = 2.5 "height of the garage zone";
        parameter Modelica.SIunits.Length lGar = 2*4.4 + 0.14 "length of garage zone";
        parameter Modelica.SIunits.Length w = 2.7 "width of ALL zones";
        parameter Real n50 = 0.6 "infiltration ratio";

        //Zone Volumes
        parameter Modelica.SIunits.Volume Vol_North = 4.4*2.7*(0.7+2+0.3) "volume of north zone";
        parameter Modelica.SIunits.Volume Vol_South = h*l*w "volume of south zone";
        parameter Modelica.SIunits.Volume Vol_Garage = hGar*lGar*w "volume of the garage zone";

        //Internal Wall Areas
        parameter Modelica.SIunits.Area A_NorthSouth = w*h "area of internal wall between north and south zone";
        parameter Modelica.SIunits.Area A_NorthGarage = w*l "area of internal wall between north zone and garage";
        parameter Modelica.SIunits.Area A_SouthGarage = w*l "area of internal wall between south zone and garage";

        //Outer Wall Areas
        parameter Modelica.SIunits.Area A_NorthWall = w*h - A_Windows "area of north zone outer wall";
        parameter Modelica.SIunits.Area A_NorthCei = w*l "area of north zone ceiling";
        parameter Modelica.SIunits.Area A_SouthWall = w*h - A_Windows "area of south zone outer wall";
        parameter Modelica.SIunits.Area A_SouthCei = w*l "area of south zone ceiling";
        parameter Modelica.SIunits.Area A_GarageWall[2] = {w*h, w*h} "area of garage boundary walls";
        parameter Modelica.SIunits.Area A_GarageSlab = lGar*w "area of garage slab floor";
        parameter Modelica.SIunits.Area A_Cei[2] = {A_NorthCei, A_SouthCei} "area of ceiling";

        //Windows
        parameter Modelica.SIunits.Area A_Windows = 2*1 "area of windows";

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end StrPar;
    end Parameters;

    package Constructions "Library of building envelope constructions"

    extends Modelica.Icons.MaterialPropertiesPackage;

      record InteriorWall
        "Interior wall example model"
        extends IDEAS.Buildings.Data.Interfaces.Construction(
        incLastLay = IDEAS.Types.Tilt.Wall,
          mats={Data.Materials.Plaster(d=0.02),
                Data.Materials.Brick(d=0.1),
                Data.Materials.Plaster(d=0.02)});

        annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
      end InteriorWall;

      record ExteriorWall "Exterior wall example model"
        extends IDEAS.Buildings.Data.Interfaces.Construction(
        incLastLay = IDEAS.Types.Tilt.Wall,
          mats={Data.Materials.Brick(d=0.1),
                Data.Insulation.Mineralwool(d=0.16),
                Data.Materials.Brick(d=0.14),
                Data.Materials.Plaster(d=0.02)});

        annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
      end ExteriorWall;

      record Floor "Floor example model"
        extends IDEAS.Buildings.Data.Interfaces.Construction(
        locGain={2},
        incLastLay = IDEAS.Types.Tilt.Floor,
          mats={Data.Materials.Tile(d=0.01),
                Data.Materials.Screed(d=0.06),
                Data.Insulation.Pur(d=0.04),
                Data.Materials.Concrete(d=0.2),
                Data.Materials.Plaster(d=0.02)});

        annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
      end Floor;

      record Slab "Slab example model"
        extends IDEAS.Buildings.Data.Interfaces.Construction(
        locGain={2},
        incLastLay = IDEAS.Types.Tilt.Floor,
          mats={Data.Materials.Concrete(d=0.35),
                Data.Materials.Screed(d=0.05)});

        annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
      end Slab;

      record Ceiling "Ceiling example model"
        extends IDEAS.Buildings.Data.Interfaces.Construction(
        locGain={2},
        incLastLay = IDEAS.Types.Tilt.Ceiling,
          mats={Data.Materials.Slate(d=0.01),
                Data.Insulation.Pur(d=0.18),
                Data.Materials.Concrete(d=0.2)});

        annotation (Documentation(info="<html>
<p>
Example implementation of a cavity wall.
</p>
<ul>
<li>
November 14, 2016, by Filip Jorissen:<br/>
Revised implementation: removed insulationType.
</li>
</ul>
</html>"));
      end Ceiling;
    annotation (Documentation(info="<html>
<p>By convention the last material layer of a construction type is connected to propsBus_a of the building component.</p>
</html>"));
    end Constructions;

    package Materials "Library of construction materials"

    extends Modelica.Icons.MaterialPropertiesPackage;

      record Brick = IDEAS.Buildings.Data.Interfaces.Material (
          k=1.10,
          c=840,
          rho=1850,
          epsLw=0.88,
          epsSw=0.55) "Heavy masonry for exterior applications" annotation (
          Documentation(info="<html>
<p>
Thermal properties of heavy bricks for exterior masonry.
</p>
</html>"));
      record Concrete = IDEAS.Buildings.Data.Interfaces.Material (
          k=1.4,
          c=840,
          rho=2100,
          epsLw=0.88,
          epsSw=0.55) "Dense cast concrete, also for finishing" annotation (
          Documentation(info="<html>
<p>
Thermal properties of concrete.
</p>
</html>"));
      record Plaster = IDEAS.Buildings.Data.Interfaces.Material (
          k=0.6,
          c=840,
          rho=975,
          epsLw=0.85,
          epsSw=0.65) "Gypsum plaster for finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of gypsum.
</p>
</html>"));
      record Screed = IDEAS.Buildings.Data.Interfaces.Material (
          k=0.6,
          c=840,
          rho=1100,
          epsLw=0.88,
          epsSw=0.55) "Light cast concrete" annotation (Documentation(info="<html>
<p>
Thermal properties of screed.
</p>
</html>"));
      record Tile = IDEAS.Buildings.Data.Interfaces.Material (
          k=1.4,
          c=840,
          rho=2100,
          epsLw=0.88,
          epsSw=0.55) "Ceramic tile for finishing" annotation (Documentation(info="<html>
<p>
Thermal properties of tiles.
</p>
</html>"));
      record Slate =IDEAS.Buildings.Data.Interfaces.Material (
          k=2.01,
          c=760,
          rho=2700,
          epsLw=0.97,
          epsSw=0.9) "Natural slate for roof tiles" annotation (Documentation(
            revisions="", info="<html>
<p>
Thermal properties of slate.
</p>
</html>"));
    end Materials;

    package Insulation "Library of thermal insulation materials"

    extends Modelica.Icons.MaterialPropertiesPackage;

      record Mineralwool = IDEAS.Buildings.Data.Interfaces.Insulation (
          k=0.036,
          c=840,
          rho=110,
          epsLw=0.8,
          epsSw=0.8) "Rockwool" annotation (Documentation(info="<html>
<p>
Rockwool insulation thermal properties.
</p>
</html>",       revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
      record Pur = IDEAS.Buildings.Data.Interfaces.Insulation (
          k=0.020,
          c=1470,
          rho=30,
          epsLw=0.8,
          epsSw=0.8) "Polyurethane foam, PUR" annotation (Documentation(info="<html>
<p>
Polyurethane (PUR) insulation thermal properties.
</p>
</html>",       revisions="<html>
<ul>
<li>
November 15, 2016, by Filip Jorissen:<br/>
Revised documentation for IDEAS 1.0.
</li>
</ul>
</html>"));
    end Insulation;

    package Glazing

      record Ins2 = IDEAS.Buildings.Data.Interfaces.Glazing (
          final nLay=3,
          final mats={
            IDEAS.Buildings.Data.Materials.Glass(
                            d=0.004,epsLw_a=0.04),
            IDEAS.Buildings.Data.Materials.Air(
                          d=0.015),
            IDEAS.Buildings.Data.Materials.Glass(
                            d=0.004, epsLw_b=0.04)},
          final SwTrans=[0, 0.521;
                        10, 0.524;
                        20, 0.517;
                        30, 0.508;
                        40, 0.495;
                        50, 0.472;
                        60, 0.418;
                        70, 0.312;
                        80, 0.153;
                        90, 0.000],
          final SwAbs=[0, 0.102, 0.0, 0.022;
                      10, 0.104, 0.0, 0.022;
                      20, 0.112, 0.0, 0.023;
                      30, 0.117, 0.0, 0.023;
                      40, 0.119, 0.0, 0.025;
                      50, 0.123, 0.0, 0.026;
                      60, 0.135, 0.0, 0.027;
                      70, 0.142, 0.0, 0.029;
                      80, 0.105, 0.0, 0.031;
                      90, 0.000, 0.0, 0.000],
          final SwTransDif=0.418,
          final SwAbsDif={0.135,0.0,0.027},
          final U_value=1.4,
          final g_value=0.755)
        "Saint Gobain ClimaPlus Futur AR 1.4 4/15/4 (U = 1.4 W/m2K, g = 0.755)"
        annotation (Documentation(revisions="<html>
<ul>
<li>
September 2, 2015, by Filip Jorissen:<br/>
Moved epsLw definition to solid layer to be consistent 
with changed implementation of MultiLayerLucent.
</li>
</ul>
</html>",       info="<html>
<p>
Double insulated glazing system.
</p>
</html>"));
    end Glazing;

    package Frames

      record Frame "Example frame"
        extends IDEAS.Buildings.Data.Interfaces.Frame(
          U_value=2.5);
            annotation (Documentation(info="<html>
<p>
Wooden window frame. U value may vary.
</p>
</html>"));
      end Frame;
    end Frames;
  end Data;
annotation (uses(IDEAS(version="1.0.0"), Modelica(version="3.2.2")));
end BuildingExample;
