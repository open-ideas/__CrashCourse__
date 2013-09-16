within Lib.Connectors.without;
model connected

  mass mass_a annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  mass mass_b(T(start = 400)) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  resistor resistor
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
mass_a.T = resistor.T_a;
mass_b.T = resistor.T_b;

mass_a.Q_flow + resistor.Q_flow_a = 0;
mass_b.Q_flow + resistor.Q_flow_b = 0;

      annotation (experiment(StopTime=5000), __Dymola_experimentSetupOutput);
end connected;
