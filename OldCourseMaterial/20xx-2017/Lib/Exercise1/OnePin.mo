within Lib.Exercise1;
partial model OnePin

  Pin_a pin annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  SI.Voltage v "Voltage drop between the two pins (= pin_a.v - pin_b.v)";
  SI.Current i "Current flowing from pin p to pin n";

equation
  v = pin.v;
  i = pin.i;
end OnePin;
