within ElectricalExample;
model Capacitor "Model for a capacitor"
  extends TwoPin;
  parameter Modelica.Units.SI.Capacitance C = 1;
  parameter Modelica.Units.SI.Voltage V_init = 0;
initial equation
  dv = V_init;
equation
  C*der(dv) = i;
  annotation (Icon(graphics={
        Line(
          points={{0,80},{0,20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{0,-20},{0,-80}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-60,20},{60,20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-60,-20},{60,-20}},
          color={28,108,200},
          thickness=1)}));
end Capacitor;
