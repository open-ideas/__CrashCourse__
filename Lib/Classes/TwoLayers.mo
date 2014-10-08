within Lib.Classes;
model TwoLayers

  ThermalMasses.Array.PrescribedTemp prescribedTemp_a(T=step.y)
    annotation (extent=[-84,-6; -64,14]);
  ThermalMasses.Array.PrescribedTemp prescribedTemp_b(T=273.15)
    annotation (extent=[30,-6; 50,14]);

  // object of type: Layer. IMPORT: use "redeclare" to specify the type of the variable "c"
  Layer layer_fix(redeclare FixedMass  c(T(start=500)))
    annotation (extent=[-24,10; -4,30], Placement(transformation(extent={{-6,32},
            {14,52}})));
  Layer layer_pcm(redeclare PCMMass   c(T(start=500)))
    annotation (extent=[-24,-24; -4,-4], Placement(transformation(extent={{-6,-48},
            {14,-28}})));
  Modelica.Blocks.Sources.Step step(
    height=100,
    offset=273,
    startTime=6000) annotation (extent=[-80,60; -60,80]);

/*simulate 10 000 seconds*/

equation
  connect(prescribedTemp_a.heatPort, layer_fix.heatPort_a) annotation (Line(
      points={{-64,4},{-48,4},{-48,42},{-6,42}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(prescribedTemp_a.heatPort, layer_pcm.heatPort_a) annotation (Line(
      points={{-64,4},{-48,4},{-48,-38},{-6,-38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(layer_fix.heatPort_b, prescribedTemp_b.heatPort) annotation (Line(
      points={{14.2,42.2},{50,42.2},{50,4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(layer_pcm.heatPort_b, prescribedTemp_b.heatPort) annotation (Line(
      points={{14.2,-37.8},{50,-37.8},{50,4}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end TwoLayers;
