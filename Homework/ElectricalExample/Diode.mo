within ElectricalExample;
model Diode "Model of a diode"
  extends TwoPin;
  parameter Modelica.Units.SI.Voltage Vt = 0.04;
  parameter Real alpha = 1;
  parameter Modelica.Units.SI.Current Ids = 1*10^(-6);
  parameter Modelica.Units.SI.Resistance Rd = 1*10^8;

equation
  if dv/Vt >= alpha then
    i = Ids*(exp(alpha*(1+dv/Vt-alpha))-1)+dv/Rd;
  else
    i = Ids*(exp(alpha)-1)+dv/Rd;
  end if;

  annotation (Icon(graphics={
        Line(
          points={{0,80},{0,40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{0,-40},{0,-80}},
          color={28,108,200},
          thickness=1),
        Polygon(
          points={{-60,40},{60,40},{0,-40},{-60,40}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.None,
          lineThickness=1),
        Line(
          points={{-60,-40},{60,-40}},
          color={28,108,200},
          thickness=1)}));
end Diode;
