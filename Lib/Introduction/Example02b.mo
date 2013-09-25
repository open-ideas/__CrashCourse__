within Lib.Introduction;
model Example02b "Solution of a non linear set of equation"

  parameter Real a=3;
  Real x(start=-2);
  Real y;
  Real z;

equation
  y - a*z = 4;
  z + y = -8;
  cosh(x) = y + 10; // non linear equation using the predefined function: cosh (hyperbolic cosine)

end Example02b;
