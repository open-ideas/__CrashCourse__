within CrashCourse.Example;
model PipeTester "Xtremely basic pipe tester"

  PipeWithHeatPort simplePipe
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  FlowBoundary flowBoundary(T=303.15, p=230000)
    annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
  FlowBoundary_OnlyPressure flowBoundary_OnlyPressure(T=303.15, p=210000)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Layer layer
    annotation (Placement(transformation(extent={{-62,54},{-42,74}})));
  Connectors.array.PrescribedTemp
                 prescribedTemp
    annotation (Placement(transformation(extent={{-100,54},{-80,74}})));
equation
  connect(flowBoundary.flowPort, simplePipe.flowPort_a) annotation (Line(
      points={{-44,10},{-20,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(flowBoundary_OnlyPressure.flowPort, simplePipe.flowPort_b)
    annotation (Line(
      points={{28,30},{32,30},{32,28},{34,28},{34,10},{0,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(layer.heatPort_b, simplePipe.heatPort) annotation (Line(
      points={{-41.8,64.2},{-10,64.2},{-10,11.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(prescribedTemp.heatPort, layer.heatPort_a) annotation (Line(
      points={{-80,64},{-62,64}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end PipeTester;
