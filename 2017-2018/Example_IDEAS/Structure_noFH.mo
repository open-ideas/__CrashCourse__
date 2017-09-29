within Example_IDEAS;
model Structure_noFH "Building envelope model without floor heating"
  extends IDEAS.Templates.Interfaces.BaseClasses.Structure( final nZones=2, final nEmb=0);

public
IDEAS.Buildings.Components.Zone north(                  V=39.2, nSurf=6,
    redeclare package Medium = Medium,
    redeclare IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir airModel)
                                       "north zone of office area"
  annotation (Placement(transformation(extent={{60,28},{80,48}})));
IDEAS.Buildings.Components.Zone south(                  V=39.2, nSurf=6,
    redeclare package Medium = Medium,
    redeclare IDEAS.Buildings.Components.ZoneAirModels.WellMixedAir airModel)
                                       "south zone of office area"
  annotation (Placement(transformation(extent={{60,-52},{80,-32}})));
IDEAS.Buildings.Components.OuterWall north_ext(
     AWall=3.51,
     inc= IDEAS.Types.Tilt.Wall,
     azi= IDEAS.Types.Azimuth.N,
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.ExtWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType)
    "Exterior wall of the north zone"
  annotation (Placement(transformation(extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={-29.5,26.5})));
IDEAS.Buildings.Components.Window north_win(
     A=5.4,
     inc= IDEAS.Types.Tilt.Wall,
     azi= IDEAS.Types.Azimuth.N,
    redeclare  Example_IDEAS.Data.Materials.Glazing glazing,
    redeclare  Example_IDEAS.Data.Materials.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    "Window of the north zone"                                              annotation (Placement(transformation(
      extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={10.5,26.5})));
IDEAS.Buildings.Components.OuterWall south_ext(
     AWall=3.51,
     inc= IDEAS.Types.Tilt.Wall,
     azi= IDEAS.Types.Azimuth.S,
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.ExtWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType)
    "Exterior wall of the south zone"
  annotation (Placement(transformation(extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={-29.5,-53.5})));
IDEAS.Buildings.Components.Window south_win(
     A=5.4,
     inc= IDEAS.Types.Tilt.Wall,
     azi= IDEAS.Types.Azimuth.S,
    redeclare  Example_IDEAS.Data.Materials.Glazing glazing,
    redeclare  Example_IDEAS.Data.Materials.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    "Window of the south zone"                                              annotation (Placement(transformation(
      extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={10.5,-55.5})));
IDEAS.Buildings.Components.InternalWall wall(
  azi= IDEAS.Types.Azimuth.S,
    AWall=8.1,
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.IntWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    inc= IDEAS.Types.Tilt.Wall)
                             annotation (Placement(transformation(
      extent={{-5,-10},{5,10}},
      rotation=0,
      origin={39,-18})));
IDEAS.Buildings.Components.InternalWall south_floor(
  inc= IDEAS.Types.Tilt.Floor,
  azi= IDEAS.Types.Azimuth.S,
    AWall=11.88,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.IntFloorHeaFh
      constructionType) "Floor as well as roof of the south zone"
                                                               annotation (Placement(transformation(
      extent={{5,-10},{-5,10}},
      rotation=90,
      origin={-69,-54})));
IDEAS.Buildings.Components.InternalWall north_floor(
  inc= IDEAS.Types.Tilt.Floor,
  azi= IDEAS.Types.Azimuth.S,
    AWall=11.88,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.IntFloorHeaFh
      constructionType) "Floor as well as roof of the north zone"
                                                               annotation (Placement(transformation(
      extent={{5,-10},{-5,10}},
      rotation=90,
      origin={-69,26})));
  IDEAS.Buildings.Components.BoundaryWall north_common(
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.IntWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    AWall=2*14.52,
    inc= IDEAS.Types.Tilt.Wall,
    azi= IDEAS.Types.Azimuth.E,
    use_T_in=false,
    use_Q_in=false)
    "Common (adiabatic) walls to neighboring offices of the north zone"
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-109,28})));
  IDEAS.Buildings.Components.BoundaryWall south_common(
    insulationThickness=0,
    redeclare  Example_IDEAS.Data.Constructions.IntWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    AWall=2*14.52,
    inc= IDEAS.Types.Tilt.Wall,
    azi= IDEAS.Types.Azimuth.E,
    use_T_in=false,
    use_Q_in=false)
    "Common (adiabatic) walls to neighboring offices of the south zone"
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-109,-56})));

        //shading and schedule to be discussed

equation
  connect(north_win.propsBus_a, north.propsBus[1]) annotation (Line(
      points={{8.4,32},{6,32},{6,43.6667},{60,43.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_ext.propsBus_a, north.propsBus[2]) annotation (Line(
      points={{-31.6,32},{-34,32},{-34,43},{60,43}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_floor.propsBus_b, north.propsBus[3]) annotation (Line(
      points={{-71,30.1667},{-71,42.3333},{60,42.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_floor.propsBus_a, north.propsBus[4]) annotation (Line(
      points={{-71,21.8333},{-71,16},{-86,16},{-86,41.6667},{60,41.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_b, north.propsBus[5]) annotation (Line(
      points={{34.8333,-16},{28,-16},{28,10},{52,10},{52,41},{60,41}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_win.propsBus_a, south.propsBus[1]) annotation (Line(
      points={{8.4,-50},{6,-50},{6,-36.3333},{60,-36.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_ext.propsBus_a, south.propsBus[2]) annotation (Line(
      points={{-31.6,-48},{-34,-48},{-34,-37},{60,-37}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_floor.propsBus_b, south.propsBus[3]) annotation (Line(
      points={{-71,-49.8333},{-71,-37.6667},{60,-37.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_floor.propsBus_a, south.propsBus[4]) annotation (Line(
      points={{-71,-58.1667},{-71,-64},{-88,-64},{-88,-38.3333},{60,-38.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a, south.propsBus[5]) annotation (Line(
      points={{43.1667,-16},{54,-16},{54,-39},{60,-39}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north.TSensor, TSensor[1]) annotation (Line(
      points={{80.6,38},{100,38},{100,-65},{156,-65}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(north.gainCon, heatPortCon[1]) annotation (Line(
      points={{80,35},{106,35},{106,34},{132,34},{132,15},{150,15}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(north.gainRad, heatPortRad[1]) annotation (Line(
      points={{80,32},{100,32},{100,30},{116,30},{116,-25},{150,-25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(south.TSensor, TSensor[2]) annotation (Line(
      points={{80.6,-42},{100,-42},{100,-55},{156,-55}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(south.gainCon, heatPortCon[2]) annotation (Line(
      points={{80,-45},{106,-45},{106,24},{128,24},{128,25},{150,25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(south.gainRad, heatPortRad[2]) annotation (Line(
      points={{80,-48},{116,-48},{116,-15},{150,-15}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(north_common.propsBus_a, north.propsBus[6]) annotation (Line(
      points={{-111,33},{-111,40.3333},{60,40.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_common.propsBus_a, south.propsBus[6]) annotation (Line(
      points={{-111,-51},{-111,-39.6667},{60,-39.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north.flowPort_Out, flowPort_Out[1]) annotation (Line(
      points={{68,48},{68,72},{-20,72},{-20,95}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(north.flowPort_In, flowPort_In[1]) annotation (Line(
      points={{72,48},{72,78},{20,78},{20,95}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(south.flowPort_Out, flowPort_Out[2]) annotation (Line(
      points={{68,-32},{68,20},{30,20},{30,72},{-20,72},{-20,105}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(south.flowPort_In, flowPort_In[2]) annotation (Line(
      points={{72,-32},{72,22},{36,22},{36,78},{20,78},{20,105}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
            -100},{150,100}}), graphics));
end Structure_noFH;
