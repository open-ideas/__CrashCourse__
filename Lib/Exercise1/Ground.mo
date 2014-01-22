within Lib.Exercise1;
model Ground
  extends OnePin;

equation
  v = 0;
  annotation (Icon(graphics={
        Line(
          points={{-80,20},{80,20}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-60,0},{60,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,-20},{40,-20}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,20},{0,100}},
          color={0,0,0},
          smooth=Smooth.None)}));
end Ground;
