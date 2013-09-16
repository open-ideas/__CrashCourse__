within CrashCourse_Dymola;
model Example03b "Illustration of conditional statements"

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
  y:= n*x;
  if y > x then    // if statement. If statement can also be written in equation but it will cause EVENTS.
    y :=x;
  else
     y:=-x;
  end if;

end Example03b;
