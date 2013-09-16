within CrashCourse.Introduction;
model Example02b

  parameter Real a=3;
  Real x(start=-2);
  Real y;
  Real z;

equation
  y - a*z = 4;
  z + y = -8;
  cosh(x) = y + 10;

end Example02b;
