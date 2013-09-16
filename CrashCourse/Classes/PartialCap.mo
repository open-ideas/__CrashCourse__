within CrashCourse.Classes;
partial model PartialCap

Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort;

parameter Modelica.SIunits.HeatCapacity CNom;
Modelica.SIunits.HeatCapacity C;
Modelica.SIunits.Temperature T;

equation
  heatPort.T=T;
  C*der(T)=heatPort.Q_flow;

end PartialCap;
