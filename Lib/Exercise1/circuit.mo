within Lib.Exercise1;
model circuit

  Ground ground
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  Resistor resistor(R=0.5)
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
  Resistor resistor1(R=0.5)
    annotation (Placement(transformation(extent={{32,-30},{52,-10}})));
  Capacitor capacitor(C=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-30})));
  Modelica.Electrical.Analog.Sources.StepVoltage V(startTime=1, offset=0)
    annotation (Placement(transformation(
        origin={-72,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(resistor.pin_b, capacitor.pin_a) annotation (Line(
      points={{-30,-20},{1.77636e-015,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(capacitor.pin_a, resistor1.pin_a) annotation (Line(
      points={{0,-20},{32,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(capacitor.pin_b, ground.pin) annotation (Line(
      points={{0,-40},{0,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor1.pin_b, ground.pin) annotation (Line(
      points={{52,-20},{60,-20},{60,-60},{0,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(V.p, resistor.pin_a) annotation (Line(
      points={{-72,-20},{-50,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(V.n, ground.pin) annotation (Line(
      points={{-72,-40},{-72,-60},{0,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end circuit;
