within Lib.Inheritance;
model model_ab
  extends model_aa;
  Real d;
equation
  d = b / a;
  c = a + b;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end model_ab;
