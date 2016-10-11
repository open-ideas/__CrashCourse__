within Lib.TypicalMistakes;
model DerivativeOfDiscontinuity
  "Model showing error message when computing derivative of discontinuity"
  Real x = if time > 0.5 then time else 0;
  Real x2;
  Real y;
equation
  der(x2) = y;
  der( x) = y;
  annotation (Documentation(info="<html>
<p><span style=\"font-family: Sans Serif;\">It is mathematically not possible to take the derivative of a discontinuously changing signal. Doing this may produce warnings/errors, or may give unexpected model results, such as illustrated by this model.</span></p>
</html>"));
end DerivativeOfDiscontinuity;
