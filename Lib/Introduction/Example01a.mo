within CrashCourse_Dymola;
model Example01a "Calculation of an equation of second order"

parameter Real a=2;      // Parameter
parameter Real b=-10;
Real x;                  // variable. Default start value = 0

equation
x^2 + a*x + b = 0;       // equation

end Example01a;
