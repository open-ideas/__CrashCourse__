within Lib.Introduction;
model Example03b
 /*
 - array and for loops
 */

  Real scale[10] "Numbers from 1 to 10";
  Real scale2[10] = ones(10) "Array of ones";
  Real scale3[10] = {i for i in 1:10} "Numbers from 1 to 10";
  Real scale4[10] =   {if i <= 5 then i else 10 - i for i in 1:10} "What's the result?";
  Real scale5[10] = scale2 + scale3;
equation
  for i in 1:10 loop
    scale[i] = i;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Example03b;
