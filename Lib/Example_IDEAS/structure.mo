within Lib.Example_IDEAS;
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
  redeclare IDEAS.Buildings.Components.Shading.None shaType,
     A=5.4,
     inc=IDEAS.Constants.Wall,
     azi=IDEAS.Constants.North)                                             annotation (Placement(transformation(
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
connect(wall.surfRad_a, south.surfRad[3])  annotation (Line(
    points={{-51,-5},{-51,26},{30,26}},
    color={191,0,0},
    smooth=Smooth.None));
connect(wall.surfCon_a, south.surfCon[3])  annotation (Line(
    points={{-54,-5},{-54,29},{30,29}},
    color={191,0,0},
    smooth=Smooth.None));
connect(wall.iEpsSw_a, south.epsSw[3])  annotation (Line(
    points={{-57,-4.4},{-57,32},{29.6,32}},
    color={0,0,127},
    smooth=Smooth.None));
connect(wall.iEpsLw_a, south.epsLw[3])  annotation (Line(
    points={{-60,-4.4},{-60,35},{29.6,35}},
    color={0,0,127},
    smooth=Smooth.None));
connect(wall.area_a, south.area[3])  annotation (Line(
    points={{-63,-4.4},{-63,38},{29.6,38}},
    color={0,0,127},
    smooth=Smooth.None));

  //Connection of the gF floor
connect(north_ext.area_a, north.area[1])
                                      annotation (Line(
    points={{-33.8,-47.34},{-33.8,-22.8},{29.6,-22.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_ext.iEpsLw_a, north.epsLw[1])
                                        annotation (Line(
    points={{-30.65,-47.34},{-30.65,-25.8},{29.6,-25.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_ext.iEpsSw_a, north.epsSw[1])
                                        annotation (Line(
    points={{-27.5,-47.34},{-27.5,-28.8},{29.6,-28.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_win.area_a, north.area[2])
                                     annotation (Line(
    points={{-5.8,-47.34},{-5.8,-22.4},{29.6,-22.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_win.iEpsLw_a, north.epsLw[2])
                                        annotation (Line(
    points={{-2.65,-47.34},{-2.65,-25.4},{29.6,-25.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_win.iEpsSw_a, north.epsSw[2])
                                        annotation (Line(
    points={{0.5,-47.34},{0.5,-28.4},{29.6,-28.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_ext.surfCon_a, north.surfCon[1])
                                           annotation (Line(
    points={{-24.35,-48},{-24,-48},{-24,-32},{4,-32},{4,-31.8},{30,-31.8}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_ext.surfRad_a, north.surfRad[1])
                                           annotation (Line(
    points={{-21.2,-48},{-22,-48},{-22,-34},{6,-34},{6,-34.8},{30,-34.8}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_win.surfCon_a, north.surfCon[2])
                                           annotation (Line(
    points={{3.65,-48},{4,-48},{4,-32},{18,-32},{18,-31.4},{30,-31.4}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_win.surfRad_a, north.surfRad[2])
                                           annotation (Line(
    points={{6.8,-48},{6,-48},{6,-34},{18,-34},{18,-34.4},{30,-34.4}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_win.iSolDif, north.iSolDif)
                                       annotation (Line(
    points={{11,-50.2},{42,-50.2},{42,-38}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_win.iSolDir, north.iSolDir)
                                       annotation (Line(
    points={{11,-53.5},{38,-53.5},{38,-38}},
    color={191,0,0},
    smooth=Smooth.None));
connect(wall.surfRad_b, north.surfRad[3])  annotation (Line(
    points={{-51,-15},{-51,-34},{30,-34}},
    color={191,0,0},
    smooth=Smooth.None));
connect(wall.surfCon_b, north.surfCon[3])  annotation (Line(
    points={{-54,-15},{-54,-31},{30,-31}},
    color={191,0,0},
    smooth=Smooth.None));
connect(wall.area_b, north.area[3])  annotation (Line(
    points={{-63,-15.6},{-63,-22},{29.6,-22}},
    color={0,0,127},
    smooth=Smooth.None));
connect(wall.iEpsLw_b, north.epsLw[3])  annotation (Line(
    points={{-60,-15.6},{-60,-25},{29.6,-25}},
    color={0,0,127},
    smooth=Smooth.None));
connect(wall.iEpsSw_b, north.epsSw[3])  annotation (Line(
    points={{-57,-15.6},{-57,-28},{29.6,-28}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.area_b, north.area[4]) annotation (Line(
    points={{-109,-45.6},{-109,-50},{-72,-50},{-72,-21.6},{29.6,-21.6}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.area_a, north.area[5]) annotation (Line(
    points={{-109,-34.4},{-109,-21.2},{29.6,-21.2}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.iEpsLw_b, north.epsLw[4]) annotation (Line(
    points={{-106,-45.6},{-106,-52},{-76,-52},{-76,-24.6},{29.6,-24.6}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.iEpsSw_b, north.epsSw[4]) annotation (Line(
    points={{-103,-45.6},{-103,-54},{-70,-54},{-70,-27.6},{29.6,-27.6}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.iEpsLw_a, north.epsLw[5]) annotation (Line(
    points={{-106,-34.4},{-106,-24.2},{29.6,-24.2}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.iEpsSw_a, north.epsSw[5]) annotation (Line(
    points={{-103,-34.4},{-103,-27.2},{29.6,-27.2}},
    color={0,0,127},
    smooth=Smooth.None));
connect(north_floor.surfCon_a, north.surfCon[5]) annotation (Line(
    points={{-100,-35},{-100,-30.2},{30,-30.2}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_floor.surfCon_b, north.surfCon[4]) annotation (Line(
    points={{-100,-45},{-100,-58},{-80,-58},{-80,-30.6},{30,-30.6}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_floor.surfRad_a, north.surfRad[5]) annotation (Line(
    points={{-97,-35},{-32.5,-35},{-32.5,-33.2},{30,-33.2}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north_floor.surfRad_b, north.surfRad[4]) annotation (Line(
    points={{-97,-45},{-97,-62},{-84,-62},{-84,-33.6},{30,-33.6}},
    color={191,0,0},
    smooth=Smooth.None));

  //Connection of the fF floor
connect(south_ext.iEpsLw_a, south.epsLw[1])
                                        annotation (Line(
    points={{-30.65,12.66},{-30.65,34.2},{29.6,34.2}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_ext.iEpsSw_a, south.epsSw[1])
                                        annotation (Line(
    points={{-27.5,12.66},{-27.5,31.2},{29.6,31.2}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_win.area_a, south.area[2]) annotation (Line(
    points={{-5.8,12.66},{-5.8,37.6},{29.6,37.6}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_win.iEpsLw_a, south.epsLw[2])
                                        annotation (Line(
    points={{-2.65,12.66},{-2.65,34.6},{29.6,34.6}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_win.iEpsSw_a, south.epsSw[2])
                                        annotation (Line(
    points={{0.5,12.66},{0.5,31.6},{29.6,31.6}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_ext.surfCon_a, south.surfCon[1])
                                           annotation (Line(
    points={{-24.35,12},{-24,12},{-24,28},{4,28},{4,28.2},{30,28.2}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_ext.surfRad_a, south.surfRad[1])
                                           annotation (Line(
    points={{-21.2,12},{-22,12},{-22,26},{4,26},{4,25.2},{30,25.2}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_win.surfCon_a, south.surfCon[2])
                                           annotation (Line(
    points={{3.65,12},{2,12},{2,28},{16,28},{16,28.6},{30,28.6}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_win.surfRad_a, south.surfRad[2])
                                           annotation (Line(
    points={{6.8,12},{6,12},{6,26},{18,26},{18,25.6},{30,25.6}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_win.iSolDif, south.iSolDif)
                                       annotation (Line(
    points={{11,9.8},{42,9.8},{42,22}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_win.iSolDir, south.iSolDir)
                                      annotation (Line(
    points={{11,6.5},{38,6.5},{38,22}},
    color={191,0,0},
    smooth=Smooth.None));

connect(north.gainCon, heatPortCon[1])
                                    annotation (Line(
    points={{50,-31},{94,-31},{94,15},{150,15}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south.gainCon, heatPortCon[2])
                                    annotation (Line(
    points={{50,29},{94,29},{94,25},{150,25}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north.gainRad, heatPortRad[1])
                                    annotation (Line(
    points={{50,-34},{96,-34},{96,-25},{150,-25}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south.gainRad, heatPortRad[2])
                                    annotation (Line(
    points={{50,26},{94,26},{94,-15},{150,-15}},
    color={191,0,0},
    smooth=Smooth.None));
connect(north.TSensor, TSensor[1])
                                annotation (Line(
    points={{50.6,-28},{94,-28},{94,-65},{156,-65}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south.TSensor, TSensor[2])
                                annotation (Line(
    points={{50.6,32},{94,32},{94,-55},{156,-55}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.area_b, south.area[4]) annotation (Line(
    points={{-109,14.4},{-109,12},{-72,12},{-72,38.4},{29.6,38.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.area_a, south.area[5]) annotation (Line(
    points={{-109,25.6},{-109,38.8},{29.6,38.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.iEpsLw_b, south.epsLw[4]) annotation (Line(
    points={{-106,14.4},{-106,8},{-74,8},{-74,35.4},{29.6,35.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.iEpsSw_b, south.epsSw[4]) annotation (Line(
    points={{-103,14.4},{-103,6},{-70,6},{-70,32.4},{29.6,32.4}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.iEpsLw_a, south.epsLw[5]) annotation (Line(
    points={{-106,25.6},{-106,35.8},{29.6,35.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.iEpsSw_a, south.epsSw[5]) annotation (Line(
    points={{-103,25.6},{-103,32.8},{29.6,32.8}},
    color={0,0,127},
    smooth=Smooth.None));
connect(south_floor.surfCon_a, south.surfCon[5]) annotation (Line(
    points={{-100,25},{-100,29.8},{30,29.8}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_floor.surfRad_a, south.surfRad[5]) annotation (Line(
    points={{-97,25},{-97,26.8},{30,26.8}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_floor.surfCon_b, south.surfCon[5]) annotation (Line(
    points={{-100,15},{-100,4},{-76,4},{-76,29.8},{30,29.8}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_floor.surfRad_b, south.surfRad[4]) annotation (Line(
    points={{-97,15},{-97,0},{-80,0},{-80,26.4},{30,26.4}},
    color={191,0,0},
    smooth=Smooth.None));
connect(south_ext.area_a, south.area[1])
                                     annotation (Line(
    points={{-33.8,12.66},{-33.8,37.2},{29.6,37.2}},
    color={0,0,127},
    smooth=Smooth.None));

   connect(north_floor.port_emb, heatPortEmb[1]) annotation (Line(
       points={{-93,-40},{-88,-40},{-88,60},{150,60}},
       color={191,0,0},
       smooth=Smooth.None));
   connect(south_floor.port_emb, heatPortEmb[2]) annotation (Line(
       points={{-93,20},{-92,20},{-92,60},{150,60}},
       color={191,0,0},
       smooth=Smooth.None));
annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
             -100},{150,100}}),
                             graphics));
end structure;
