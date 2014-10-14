within Lib.Example_IDEAS;
model Structure "Building envelope model"
  extends IDEAS.Interfaces.BaseClasses.Structure( final nZones=2, final nEmb = 2);

public
IDEAS.Buildings.Components.Zone north(                  V=39.2, nSurf=6)
    "north zone of office area"
  annotation (Placement(transformation(extent={{60,28},{80,48}})));
IDEAS.Buildings.Components.Zone south(                  V=39.2, nSurf=6)
    "south zone of office area"
  annotation (Placement(transformation(extent={{60,-52},{80,-32}})));
IDEAS.Buildings.Components.OuterWall north_ext(
     AWall=3.51,
     inc=IDEAS.Constants.Wall,
     azi=IDEAS.Constants.North,
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.ExtWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType)
    "Exterior wall of the north zone"
  annotation (Placement(transformation(extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={-29.5,26.5})));
IDEAS.Buildings.Components.Window north_win(
     A=5.4,
     inc=IDEAS.Constants.Wall,
     azi=IDEAS.Constants.North,
    redeclare Lib.Example_IDEAS.Data.Materials.Glazing glazing,
    redeclare Lib.Example_IDEAS.Data.Materials.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    "Window of the north zone"                                              annotation (Placement(transformation(
      extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={10.5,26.5})));
IDEAS.Buildings.Components.OuterWall south_ext(
     AWall=3.51,
     inc=IDEAS.Constants.Wall,
     azi=IDEAS.Constants.South,
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.ExtWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType)
    "Exterior wall of the south zone"
  annotation (Placement(transformation(extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={-29.5,-53.5})));
IDEAS.Buildings.Components.Window south_win(
     A=5.4,
     inc=IDEAS.Constants.Wall,
     azi=IDEAS.Constants.South,
    redeclare Lib.Example_IDEAS.Data.Materials.Glazing glazing,
    redeclare Lib.Example_IDEAS.Data.Materials.Frame fraType,
    redeclare IDEAS.Buildings.Components.Shading.None shaType)
    "Window of the south zone"                                              annotation (Placement(transformation(
      extent={{-5.5,-10.5},{5.5,10.5}},
      rotation=90,
      origin={10.5,-53.5})));
IDEAS.Buildings.Components.InternalWall wall(
  azi=IDEAS.Constants.South,
    AWall=8.1,
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.IntWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    inc=IDEAS.Constants.Wall)
                             annotation (Placement(transformation(
      extent={{-5,-10},{5,10}},
      rotation=0,
      origin={37,-20})));
IDEAS.Buildings.Components.InternalWall south_floor(
  inc=IDEAS.Constants.Floor,
  azi=IDEAS.Constants.South,
    AWall=11.88,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.IntFloorHeaFh
      constructionType) "Floor as well as roof of the south zone"
                                                               annotation (Placement(transformation(
      extent={{5,-10},{-5,10}},
      rotation=90,
      origin={-69,-54})));
IDEAS.Buildings.Components.InternalWall north_floor(
  inc=IDEAS.Constants.Floor,
  azi=IDEAS.Constants.South,
    AWall=11.88,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.IntFloorHeaFh
      constructionType) "Floor as well as roof of the north zone"
                                                               annotation (Placement(transformation(
      extent={{5,-10},{-5,10}},
      rotation=90,
      origin={-69,26})));
  IDEAS.Buildings.Components.BoundaryWall north_common(
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.IntWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    AWall=2*14.52,
    inc=IDEAS.Constants.Wall,
    azi=IDEAS.Constants.East,
    use_T_in=false,
    use_Q_in=false)
    "Common (adiabatic) walls to neighboring offices of the north zone"
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-109,26})));
  IDEAS.Buildings.Components.BoundaryWall south_common(
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.IntWall constructionType,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    AWall=2*14.52,
    inc=IDEAS.Constants.Wall,
    azi=IDEAS.Constants.East,
    use_T_in=false,
    use_Q_in=false)
    "Common (adiabatic) walls to neighboring offices of the south zone"
    annotation (Placement(transformation(
        extent={{-5,-10},{5,10}},
        rotation=90,
        origin={-109,-54})));

equation
  connect(north_win.propsBus_a, north.propsBus[1]) annotation (Line(
      points={{6.3,32},{6,32},{6,43.6667},{60,43.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_ext.propsBus_a, north.propsBus[2]) annotation (Line(
      points={{-33.7,32},{-34,32},{-34,43},{60,43}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_floor.propsBus_b, north.propsBus[3]) annotation (Line(
      points={{-73,31},{-73,42.3333},{60,42.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_floor.propsBus_a, north.propsBus[4]) annotation (Line(
      points={{-73,21},{-73,16},{-86,16},{-86,41.6667},{60,41.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_b, north.propsBus[5]) annotation (Line(
      points={{32,-16},{28,-16},{28,10},{52,10},{52,41},{60,41}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_win.propsBus_a, south.propsBus[1]) annotation (Line(
      points={{6.3,-48},{6,-48},{6,-36.3333},{60,-36.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_ext.propsBus_a, south.propsBus[2]) annotation (Line(
      points={{-33.7,-48},{-34,-48},{-34,-37},{60,-37}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_floor.propsBus_b, south.propsBus[3]) annotation (Line(
      points={{-73,-49},{-73,-37.6667},{60,-37.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_floor.propsBus_a, south.propsBus[4]) annotation (Line(
      points={{-73,-59},{-73,-64},{-88,-64},{-88,-38.3333},{60,-38.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wall.propsBus_a, south.propsBus[5]) annotation (Line(
      points={{42,-16},{54,-16},{54,-39},{60,-39}},
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

  connect(north_floor.port_emb, heatPortEmb[1]) annotation (Line(
      points={{-59,26},{-50,26},{-50,55},{150,55}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(south_floor.port_emb, heatPortEmb[2]) annotation (Line(
      points={{-59,-54},{-50,-54},{-50,65},{150,65}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(north_common.propsBus_a, north.propsBus[6]) annotation (Line(
      points={{-113,31},{-113,40.3333},{60,40.3333}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(south_common.propsBus_a, south.propsBus[6]) annotation (Line(
      points={{-113,-49},{-113,-39.6667},{60,-39.6667}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north.flowPort_Out, flowPort_Out[1]) annotation (Line(
      points={{68,48},{68,76},{-20,76},{-20,95}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(south.flowPort_Out, flowPort_Out[2]) annotation (Line(
      points={{68,-32},{68,22},{86,22},{86,76},{-20,76},{-20,105}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(north.flowPort_In, flowPort_In[1]) annotation (Line(
      points={{72,48},{72,82},{20,82},{20,95}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(south.flowPort_In, flowPort_In[2]) annotation (Line(
      points={{72,-32},{74,-32},{74,22},{86,22},{86,82},{20,82},{20,105}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
            -100},{150,100}}), graphics));
end Structure;
