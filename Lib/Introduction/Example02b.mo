within Lib.Introduction;
model Example02b
 /*
 - differential equation
 - initial equation
 */

  Real x "State variable";
initial equation
  x = 2 "Used before simulation to compute initial value";
equation
  der(x) = 1 - x "Drives value of x toward 1.0"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
  annotation (experiment(StopTime=10));
end Example02b;
