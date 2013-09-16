within Lib.Classes;
model Capacity_extended "Another example of extending an existing class"
  extends Connectors.with.mass;
  /* 
  All declarations, equations etc. from Capacity are literally copied into this model
  They cannot be changed
  */

  Boolean heatLoss(start=false);

algorithm
  heatLoss :=heatPort.Q_flow < 0;

end Capacity_extended;
