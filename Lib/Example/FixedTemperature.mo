within CrashCourse.Example;
model FixedTemperature "Fixes the temperature in a HeatPort"
  parameter Modelica.SIunits.Temperature T "constant temperature";

  HeatPort heatPort
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));

equation
  heatPort.T=T;
  annotation (Icon(graphics={Text(
          extent={{-46,44},{52,-56}},
          lineColor={0,0,255},
          textString="T")}));
end FixedTemperature;
