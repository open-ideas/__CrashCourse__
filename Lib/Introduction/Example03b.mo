within Lib.Introduction;
model Example03b

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);
Real x;
Real y; // Integer y would give an error

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

algorithm
  y:= n*x;
  if y > x then
    y :=x;
  else
     y:=-x;
  end if;

end Example03b;
