within Lib.Connectors.array;
model modified

parameter Integer n=4;
parameter Real[n] cvalues={600,1000,400,600};
parameter Real[n] Tstarts={500,350,600,200};

  with.mass[n] mass(c=cvalues, T(start=Tstarts))   annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  with.resistor[n-1] resistor
    annotation (Placement(transformation(extent={{2,-10},{22,10}})));

equation
for i in 1:3 loop
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
end modified;
