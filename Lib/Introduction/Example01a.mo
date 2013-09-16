within Lib.Introduction;
model Example01a

parameter Real a=2;
parameter Real b=-10;
Real x;

equation
x^2 + a*x + b = 0;

end Example01a;
