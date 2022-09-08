within Lib.Introduction;
model Example03c
  "Illustration of conditional statements and the importance of start value"

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean bigThan5(start=false);
Real x(start=-10); // the start value of x obliges modelica to find the second solution of the 2d order equation.
Real y; // Integer y would give an error

equation
x^2 + a*x + b = 0;
bigThan5= n>5;

algorithm
  y:= n*x;
  if y > x then
    y :=x;
  else
     y:=-x;
  end if;

end Example03c;
