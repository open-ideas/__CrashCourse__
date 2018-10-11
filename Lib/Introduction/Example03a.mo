within Lib.Introduction;
model Example03a
 /*
 - if else statement
 */

  Real x "State variable";
  parameter Real limit = 1.5 "Trigger limit for boolean small";
  Boolean small "Becomes true when x < limit";
initial equation
  x = 2 "Used before simulation to compute initial value";
equation
  der(x) = 1 - x "Drives value of x toward 1.0";

  if x < limit then
    small = true;
  else
    small = false;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              experiment(StopTime=10));
end Example03a;
