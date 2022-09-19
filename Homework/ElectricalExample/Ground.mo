within ElectricalExample;
model Ground "Model for a ground"
  extends OnePin;
equation
  v = 0;
  annotation (Icon(graphics={
        Line(
          points={{0,20},{0,-20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-60,-20},{60,-20}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-40,-40},{40,-40}},
          color={28,108,200},
          thickness=1),
        Line(
          points={{-20,-60},{20,-60}},
          color={28,108,200},
          thickness=1)}));
end Ground;
