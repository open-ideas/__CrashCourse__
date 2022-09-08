within Lib.Classes;
model ExtendedMass "Another example of extending an existing class"
  extends ThermalMasses.ClassesAndConnectors.Mass(m=10);
  /* 
  All declarations, equations etc. from Capacity are literally copied into this model
  They cannot be removed. parameter values can be changed.
  */

  Boolean heatLoss(start=false);

algorithm
  heatLoss := heatPort.Q_flow < 0;

end ExtendedMass;
