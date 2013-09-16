within Lib.Connectors.Array;
model Array

parameter Integer n=4 "number of capacities";

  With.Mass[n] mass "array of mass" annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  With.Resistor[n-1] resistor "array of resistors"
    annotation (Placement(transformation(extent={{2,-10},{22,10}})));

equation
for i in 1:n-1 loop
connect(mass[i].heatPort,resistor[i].heatPort_a) annotation (Line(
      points={{-3.8,0},{4,0}},
      color={0,0,0},
      smooth=Smooth.None));
connect(mass[i+1].heatPort,resistor[i].heatPort_b) annotation (Line(
      points={{-3.8,0},{0,0},{0,8},{26,8},{26,0},{20,0}},
      color={0,0,0},
      smooth=Smooth.None));
end for;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
        experiment(StopTime=5000),
        __Dymola_experimentSetupOutput);
end Array;
