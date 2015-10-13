within Lib.TypicalMistakes;
model DerivativeOfDiscontinuity
  "Model showing error message when computing derivative of discontinuity"
  Real x = if time > 0.5 then time else 0;
  Real x2;
  Real y;
equation
  der(x2) = y;
  der( x) = y;
end DerivativeOfDiscontinuity;
