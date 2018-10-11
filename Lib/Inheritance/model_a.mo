within Lib.Inheritance;
model model_a
  parameter Real a = 2;
  parameter Real b = 5;
  Real c;
equation
  c = a + b;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end model_a;
