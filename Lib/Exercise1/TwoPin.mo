within Lib.Exercise1;
partial model TwoPin
  "Component with two electrical pins pin_a and pin_b and current i from pin_a to pin_b"

  SI.Voltage v "Voltage drop between the two pins (= pin_a.v - pin_b.v)";
  SI.Current i "Current flowing from pin p to pin n";

  Pin_a pin_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Pin_b pin_b annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  v = pin_a.v - pin_b.v;
  0 = pin_a.i + pin_b.i;
  i = pin_a.i;
end TwoPin;
