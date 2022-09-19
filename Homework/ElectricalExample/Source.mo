within ElectricalExample;
model Source "Model for a voltage source"
  extends TwoPin;
  parameter Modelica.Units.SI.Voltage V = 10;
  parameter Modelica.Units.SI.Time omega = 0;
  parameter Modelica.Units.SI.Voltage beta = 0;
  parameter Modelica.Units.SI.Frequency f = 0.1;
  final constant Real pi = 2*Modelica.Math.asin(1.0);
equation
  dv = V*sin(2*pi*f*time + omega) + beta;

  annotation (Icon(graphics={
        Line(points={{0,80},{0,40}}, color={28,108,200},
          thickness=1),
        Line(points={{0,-40},{0,-80}}, color={28,108,200},
          thickness=1),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.None,
          lineThickness=1),
        Line(
          points={{0,30},{0,10}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-10,20},{10,20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-10,-20},{10,-20}},
          color={28,108,200},
          thickness=1)}));
end Source;
