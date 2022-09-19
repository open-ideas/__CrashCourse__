within ElectricalExample;
partial model TwoPin
  "Partial model for all models with two connectors"
  Pin_pos p
    annotation (Placement(transformation(extent={{-10,80},{10,100}}),
        iconTransformation(extent={{-10,80},{10,100}})));
  Pin_neg n
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}}),
        iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Units.SI.Voltage dv;
  Modelica.Units.SI.Current i;
equation
  dv = p.v - n.v;
  i = p.i;
  p.i + n.i = 0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TwoPin;
