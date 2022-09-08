within Lib.Classes;
partial model PartialMass
  "partial model. Needs extra information. Number of unkowns > nb of equations"

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort;

  parameter Modelica.SIunits.HeatCapacity CNom "nominal capacity value";
  Modelica.SIunits.HeatCapacity C "capacity. Notice: it is a variable!";
  Modelica.SIunits.Temperature T;

equation
  heatPort.T=T;
  C*der(T)=heatPort.Q_flow;
  // one equation is missing.
end PartialMass;
