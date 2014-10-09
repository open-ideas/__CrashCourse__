within Lib.ThermalMasses.ClassesNoConnector;
model Connected
  "Model of two thermal mass connected to each other by a thermal resistance."

  Mass mass_a "object of type mass" annotation (Placement(transformation(extent={{-40,-10},
            {-10,16}})));
  Mass mass_b(T(start = 400)) "use of modifier" annotation (Placement(transformation(extent={{22,-12},
            {52,18}})));
  Resistor resistor
    annotation (Placement(transformation(extent={{-12,-12},{24,14}})));

equation
  // Connect
  // (Kirchhoff Loop Rule)
  mass_a.T = resistor.T_a;
  mass_b.T = resistor.T_b;

  mass_a.Q_flow + resistor.Q_flow_a = 0;
  mass_b.Q_flow + resistor.Q_flow_b = 0;
  // (Kirchhoff Junction Rule)
      annotation (experiment(StopTime=5000), __Dymola_experimentSetupOutput);
end Connected;
