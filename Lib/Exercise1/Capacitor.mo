within Lib.Exercise1;
model Capacitor "Ideal linear electrical capacitor"
extends TwoPin;

    parameter SI.Capacitance C(start=1) "Capacitance";

equation
  i = C*der(v);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          points={{-30,60},{-30,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{30,60},{30,-60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-100,0},{-30,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{30,0},{100,0}},
          color={0,0,0},
          smooth=Smooth.None)}));
end Capacitor;
