within Lib.Example_IDEAS;
model Structure_1zone "One zone building envelope model"
  extends IDEAS.Interfaces.BaseClasses.Structure( final nZones=1, final nEmb = 0);

public
IDEAS.Buildings.Components.Zone north(                  V=39.2,
    redeclare package Medium = Medium,
    nSurf=5) "north zone of office area"
  annotation (Placement(transformation(extent={{60,28},{80,48}})));
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
IDEAS.Buildings.Components.InternalWall north_floor(
  inc=IDEAS.Constants.Floor,
  azi=IDEAS.Constants.South,
    AWall=11.88,
    redeclare IDEAS.Buildings.Data.Insulation.none insulationType,
    insulationThickness=0,
    redeclare Lib.Example_IDEAS.Data.Constructions.IntFloorHeaFh
      constructionType) "Floor as well as roof of the north zone"
                                                               annotation (Placement(transformation(
      extent={{-5,-10},{5,10}},
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
        origin={-109,24})));

equation
  connect(north_win.propsBus_a, north.propsBus[1]) annotation (Line(
      points={{6.3,32},{6,32},{6,40},{60,40},{60,44},{60,44},{60,44},{60,43.6}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_ext.propsBus_a, north.propsBus[2]) annotation (Line(
      points={{-33.7,32},{-34,32},{-34,40},{60,40},{60,42.8}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_floor.propsBus_b, north.propsBus[3]) annotation (Line(
      points={{-73,21},{-73,16},{-88,16},{-88,40},{60,40},{60,42}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north_floor.propsBus_a, north.propsBus[4]) annotation (Line(
      points={{-73,31},{-73,36},{-74,36},{-74,40},{60,40},{60,41.2}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north.TSensor, TSensor[1]) annotation (Line(
      points={{80.6,38},{100,38},{100,-60},{156,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(north.gainCon, heatPortCon[1]) annotation (Line(
      points={{80,35},{106,35},{106,34},{132,34},{132,20},{150,20}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(north.gainRad, heatPortRad[1]) annotation (Line(
      points={{80,32},{100,32},{100,30},{116,30},{116,-20},{150,-20}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(north_common.propsBus_a, north.propsBus[5]) annotation (Line(
      points={{-113,29},{-113,36},{-112,36},{-112,40},{60,40},{60,40.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(north.flowPort_Out, flowPort_Out[1]) annotation (Line(
      points={{68,48},{68,78},{-20,78},{-20,100}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(north.flowPort_In, flowPort_In[1]) annotation (Line(
      points={{72,48},{72,86},{20,86},{20,100}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,
            -100},{150,100}}), graphics));
end Structure_1zone;
