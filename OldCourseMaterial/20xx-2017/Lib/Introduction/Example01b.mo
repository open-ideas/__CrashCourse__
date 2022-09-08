within Lib.Introduction;
model Example01b
  "Calculation of an equation of second order, with specification of start (guess) value."

parameter Real a=2;
parameter Real b=-10;
Real x(start=-10);    // variable with start (guess) value = -10

equation
x^2 + a*x + b = 0;    // Second order equation. Notice: equation has 2 solutions. Modelica will return only one solution. Value depend on the start x-value.

end Example01b;
