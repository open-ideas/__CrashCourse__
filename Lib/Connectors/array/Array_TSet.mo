within Lib.Connectors.array;
model Array_TSet
parameter Integer n=4;
parameter Real[n] cvalues={600,1000,400,600}; // write the modifiers as parameters
parameter Real[n] Tstarts={500,350,600,200};

  with.mass[n] mass(c=cvalues, T(start=Tstarts))   annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  with.resistor[n-1] resistor
    annotation (Placement(transformation(extent={{2,-10},{22,10}})));
PrescribedTemp TSet(T=step.y);
Modelica.Blocks.Sources.Step step(height=50,startTime=3000,offset=300); // use modelica's library! Step input source

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

connect(TSet.heatPort,resistor[1].heatPort_b);

end Array_TSet;
