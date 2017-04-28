within ;
model ElectricalCircuit

  MyLib.Source source(
    omega=0,
    beta=0,
    U=5,
    f=0.1)
         annotation (Placement(transformation(
        extent={{-30,-30},{30,30}},
        rotation=-90,
        origin={-80,10})));
  MyLib.Resistor resistor(R=0.01)
    annotation (Placement(transformation(extent={{-70,40},{-10,100}})));
  MyLib.Resistor resistor1(R=100)
    annotation (Placement(transformation(extent={{10,40},{70,100}})));
  MyLib.Ground ground annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,-80})));
  MyLib.Capacity capacity(C=200)  annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,-20})));
  MyLib.Diode diode(Vt=0.04, alfa=15)
                    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,34})));
equation
  connect(source.positive, resistor.positive) annotation (Line(points={{-80,38.8},
          {-80,70},{-68.8,70}}, color={28,108,200}));
  connect(resistor.negative, resistor1.positive)
    annotation (Line(points={{-11.2,70},{11.2,70}}, color={28,108,200}));
  connect(resistor1.negative, ground.pin_a) annotation (Line(points={{68.8,70},{
          68.8,-60.8},{3.55271e-015,-60.8}}, color={28,108,200}));
  connect(source.negative, ground.pin_a) annotation (Line(points={{-80,-18.8},{-80,
          -18.8},{-80,-62},{-80,-60.8},{0,-60.8}}, color={28,108,200}));
  connect(capacity.positive, diode.negative)
    annotation (Line(points={{0,-0.8},{0,14.8}}, color={28,108,200}));
  connect(capacity.negative, ground.pin_a)
    annotation (Line(points={{0,-39.2},{0,-60.8}}, color={28,108,200}));
  connect(diode.positive, resistor1.positive)
    annotation (Line(points={{0,53.2},{0,70},{11.2,70}}, color={28,108,200}));
end ElectricalCircuit;
