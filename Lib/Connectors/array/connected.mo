within Lib.Connectors.Array;
model Connected

  With.Mass mass annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  With.Mass mass1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
  With.Mass mass2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
  With.Mass mass3
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  With.Resistor resistor
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  With.Resistor resistor1
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  With.Resistor resistor2
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
equation
  connect(mass.heatPort, resistor.heatPort_a) annotation (Line(
      points={{-53.8,40},{-48,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(resistor.heatPort_b, mass1.heatPort) annotation (Line(
      points={{-32,40},{-20,40},{-20,36.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(mass1.heatPort, resistor2.heatPort_a) annotation (Line(
      points={{-20,36.2},{-20,40},{-8,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(resistor2.heatPort_b, mass2.heatPort) annotation (Line(
      points={{8,40},{20,40},{20,36.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(mass2.heatPort, resistor1.heatPort_a) annotation (Line(
      points={{20,36.2},{20,40},{32,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(resistor1.heatPort_b, mass3.heatPort) annotation (Line(
      points={{48,40},{53.8,40}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
        experiment(StopTime=5000),
        __Dymola_experimentSetupOutput);
end Connected;
