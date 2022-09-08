within Lib.Introduction;
model Example01a "Calculation of an equation of second order"
  /*
   - parameter versus variable
   - type of variable
   - equation part
   - acausal
  */
parameter Real a=2;      // Parameter
parameter Real b=-10;
Real x;                  // variable. Default start value = 0
Boolean a_bigger;
Integer n;

equation
  x^2 + a*x + b = 0;       // equation
  a_bigger = a > b;
  n = 1;

end Example01a;
