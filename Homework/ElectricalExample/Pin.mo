within ElectricalExample;
partial connector Pin
  "This is a partial connector, which will be used in each electrical component. It needs two variables, current i and voltage v"
  Modelica.Units.SI.Voltage v "Potential at the pin";
  flow Modelica.Units.SI.Current i "Current flowing into the pin";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(extent={{-100,100},{100,-100}},
                                              lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pin;
