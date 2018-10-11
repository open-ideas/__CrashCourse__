within Lib;
package Introduction "First steps in Modelica"
    extends Modelica.Icons.Package;

  model Example01c "Solution of a non linear set of equation"
   /*
 - Solution of a non linear set of equation
 */
    parameter Real a=3;
    Real x(start=-2);
    Real y;
    Real z;

  equation
    y - a*z = 4;
    z + y = -8;
    cosh(x) = y + 10; // non linear equation using the predefined function: cosh (hyperbolic cosine)

  end Example01c;

  model Example02a
   /* 
 - acausal
 - algorithm
  */
    parameter Real a = 1;
    constant Real b = 2;
    Real result_1;
    Real result_2;
    Real result_3;

  equation
    result_1 = a + b;
    result_2 - a = b;

  algorithm
    result_3 :=a;
    result_3 :=result_3 + b;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Example02a;
end Introduction;
