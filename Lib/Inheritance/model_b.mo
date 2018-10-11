within Lib.Inheritance;
model model_b
  parameter Real a = 2;
  parameter Real b = 5;
  Real c;
  Real d;
equation
  c = a + b;
  d = b / a;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end model_b;
