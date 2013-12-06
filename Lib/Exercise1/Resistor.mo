within Lib.Exercise1;
model Resistor "Ideal linear electrical resistor"
extends TwoPin;
parameter SI.Resistance R = 1;

equation
  v = R * i;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-94,0},{100,0}},
          color={0,0,0},
          smooth=Smooth.None)}));
end Resistor;
