within Lib.Exercise1;
model Circuit

  Resistor resistor(R=0.5)
    annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  Resistor resistor1(R=0.5)
    annotation (Placement(transformation(extent={{32,34},{52,54}})));
  Capacitor capacitor(C=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-16})));
  SineVoltage                                    V(             offset=0,
    V=10,
    freqHz=0.1)
    annotation (Placement(transformation(
        origin={-72,18},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Diode diode annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,34})));
  Ground ground
    annotation (Placement(transformation(extent={{-14,-56},{6,-36}})));
equation
  connect(V.pin_a, resistor.pin_a)
    annotation (Line(points={{-72,28},{-72,44},{-50,44}}, color={0,0,255}));
  connect(resistor.pin_b, diode.pin_a)
    annotation (Line(points={{-30,44},{-15,44},{0,44}}, color={0,0,255}));
  connect(diode.pin_a, resistor1.pin_a)
    annotation (Line(points={{0,44},{32,44}},         color={0,0,255}));
  connect(diode.pin_b, capacitor.pin_a)
    annotation (Line(points={{0,24},{0,9},{0,-6}}, color={0,0,255}));
  connect(resistor1.pin_b, capacitor.pin_b) annotation (Line(points={{52,44},{
          68,44},{68,-26},{0,-26}}, color={0,0,255}));
  connect(V.pin_b, capacitor.pin_b) annotation (Line(points={{-72,8},{-72,8},{
          -72,-26},{-1.77636e-015,-26}}, color={0,0,255}));
  connect(ground.pin, capacitor.pin_b) annotation (Line(points={{-4,-36},{-2,
          -36},{-2,-26},{0,-26}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-60},
            {80,60}}),         graphics={
        Text(
          extent={{-52,60},{-26,46}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="Resistor"),
        Text(
          extent={{30,62},{56,48}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="Resistor"),
        Text(
          extent={{-36,-10},{-10,-24}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="Capacitor"),
        Text(
          extent={{-14,-46},{12,-60}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="Ground"),
        Text(
          extent={{-62,18},{-36,4}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="Source"),
        Text(
          extent={{-24,34},{-10,26}},
          lineColor={0,0,255},
          lineThickness=0.5,
          textString="Diode")}),  Icon(coordinateSystem(extent={{-80,-60},{80,60}})),
    experiment(
      StopTime=100,
      __Dymola_fixedstepsize=40,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end Circuit;
