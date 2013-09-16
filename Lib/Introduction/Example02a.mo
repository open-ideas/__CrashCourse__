within Lib.Introduction;
model Example02a
  "Calculation of an equation of second order and illustration of a boolean variable."

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);  // Boolean variable with start value FALSE
Real x;

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

end Example02a;
