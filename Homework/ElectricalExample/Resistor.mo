within ElectricalExample;
model Resistor "Model for a resistor"
  extends TwoPin;
  parameter Modelica.Units.SI.Resistance R;
equation
  dv = i*R;
  annotation (Icon(graphics={Line(
          points={{0,80},{0,40},{20,36},{-20,24},{20,16},{-20,4},{20,-4},{-20,
              -14},{20,-24},{-20,-36},{0,-40},{0,-80}},
          color={28,108,200},
          thickness=1)}));
end Resistor;
