within Lib.Introduction;
model Example03a "Illustration of the algorithm statement"

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean bigThan5(start=false);
Real x;
Real y; // Integer y would give an error

equation
x^2 + a*x + b = 0;
bigThan5= n>5;

algorithm
            // algorithm part. Equations are computed line by line
  y:= n*x;

end Example03a;
