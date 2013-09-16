within Lib.Introduction;
model Example02a

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);
Real x;

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

end Example02a;
