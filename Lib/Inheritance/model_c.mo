within Lib.Inheritance;
model model_c
  extends model_a;
  Real d;
equation
  d = b / a;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end model_c;
