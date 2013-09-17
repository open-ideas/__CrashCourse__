within Lib.Classes;
model LayerFiniteElement "1 Dimensional finite element layer"

  parameter Real R=3;
  parameter Real C=800;
  parameter Integer n=10 "number of elements";
  Lib.Connectors.With.Resistor[n + 1] r(each R=R/(n + 1));
  replaceable FixedCap[n] c constrainedby Classes.PartialCap(each CNom=C/n);

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_a annotation (extent=[-110,-10; -90,10]);
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort_b annotation (extent=[92,-8; 112,12]);

equation
connect(heatPort_a,r[1].heatPort_a);
for i in 1:n loop
  connect(r[i].heatPort_b,c[i].heatPort);
  connect(r[i].heatPort_b,r[i+1].heatPort_a);
end for;
connect(r[n+1].heatPort_b,heatPort_b);
end LayerFiniteElement;
