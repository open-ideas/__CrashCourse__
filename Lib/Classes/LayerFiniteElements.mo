within Lib.Classes;
model LayerFiniteElements "1 Dimensional finite element layer"

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_a annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort_b annotation (extent=[92,-8; 112,12]);

  parameter Real R=3;
  parameter Real C=800;
  parameter Integer n=10 "number of elements";
  Lib.ThermalMasses.ClassesAndConnectors.Resistor[n + 1] r(each R=R/(n + 1));
  replaceable FixedMass[n] c constrainedby PartialMass(each CNom=C/n) annotation (Placement(transformation(extent={{-14,-6},{6,14}})),choicesAllMatching=true);

equation
  connect(heatPort_a,r[1].heatPort_a);
  for i in 1:n loop
    connect(r[i].heatPort_b,c[i].heatPort);
    connect(r[i].heatPort_b,r[i+1].heatPort_a);
  end for;
  connect(r[n+1].heatPort_b,heatPort_b);
end LayerFiniteElements;
