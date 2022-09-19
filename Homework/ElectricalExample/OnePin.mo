within ElectricalExample;
partial model OnePin
  "Partial model for all models with one connector"
  flow Modelica.Units.SI.Current i "Current flowing through this component";
  Modelica.Units.SI.Voltage v "Voltage of this component";
  Pin_pos pin
    annotation (Placement(transformation(extent={{-10,20},{10,40}}),
        iconTransformation(extent={{-10,20},{10,40}})));
equation
  pin.i = i;
  pin.v = v;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OnePin;
