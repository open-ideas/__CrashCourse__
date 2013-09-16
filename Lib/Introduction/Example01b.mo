within CrashCourse.Introduction;
model Example01b

parameter Real a=2;
parameter Real b=-10;
Real x(start=-10);

equation
x^2 + a*x + b = 0;

end Example01b;
