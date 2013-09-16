within Lib.Example;
model FloorHeating "Model with Pipe connected to layer, Pump and Boiler"
  parameter Modelica.SIunits.HeatCapacity cFloor=80000 "capacity of the floor";

  PipeWithHeatPort floorHeating(
    l=100,
    V_flowNominal=0.001,
    T(start=293),
    dia=0.030,
    dpNominal=40000)
    annotation (Placement(transformation(extent={{-14,26},{6,46}})));
  SimplePump pump(dp=40000)
    annotation (Placement(transformation(extent={{42,26},{62,46}})));
  FluidCircuitMerger fluidCircuitMerger
    annotation (Placement(transformation(extent={{26,-14},{36,0}})));
  Lib.Example.FixedPressure prescribedPressure(p=200000)
    annotation (Placement(transformation(extent={{12,52},{32,72}})));
  PipeWithHeatPort boiler(
    dia=0.080,
    T(start=293),
    V_flowNominal=0.001)
    annotation (Placement(transformation(extent={{-22,10},{-42,-10}})));
  Lib.Classes.Layer layer(R=0.01,    C=cFloor,
    redeclare FixedCap c(CNom=80000, T(start=288.15)))
              annotation (Placement(transformation(extent={{-44,58},{-24,78}})));
  OnOffHeatFlow boilerHeatFlow(       onoff=onoff.y, Q=5000)
    annotation (Placement(transformation(extent={{-72,-28},{-52,-8}})));
  FixedTemperature fixedTemperature(T=296.15)
    annotation (Placement(transformation(extent={{-90,58},{-70,78}})));
  Modelica.Blocks.Logical.OnOffController onoff(bandwidth=1);

  Real deviation(start=0);
  Real deviationInt(start=0);
equation
  deviation = abs(layer.c.T - (24+273.15));
  der(deviationInt) = deviation;
  onoff.reference=24+273.15;
  onoff.u=layer.c.T;
  //boilerHeatFlow.onoff=onoff.y;
  connect(floorHeating.flowPort_b, pump.flowPort_a)     annotation (Line(
      points={{6,36},{42,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump.flowPort_b, fluidCircuitMerger.flowPort_b)       annotation (
      Line(
      points={{62,36},{70,36},{70,-7},{36,-7}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(prescribedPressure.flowPort, pump.flowPort_a)       annotation (Line(
      points={{32,62},{42,62},{42,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(boiler.flowPort_a, fluidCircuitMerger.flowPort_a)
    annotation (Line(
      points={{-22,0},{4,0},{4,-7},{26,-7}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(boiler.flowPort_b, floorHeating.flowPort_a)         annotation (Line(
      points={{-42,0},{-52,0},{-52,36},{-14,36}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(layer.heatPort_b, floorHeating.heatPort)
                                                 annotation (Line(
      points={{-23.8,68.2},{-4,68.2},{-4,37.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(boilerHeatFlow.heatPort, boiler.heatPort)           annotation (
      Line(
      points={{-52.6,-18},{-32,-18},{-32,-1.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(fixedTemperature.heatPort, layer.heatPort_a) annotation (Line(
      points={{-70.2,68},{-44,68}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end FloorHeating;
