within Lib.Exercise1;
partial model OnePin

  Pin_a pin annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.SIunits.Voltage v "Voltage at the pin of OnePin";
  Modelica.SIunits.Current i "Current flowing into OnePin";

equation
  v = pin.v;
  i = pin.i;
end OnePin;
