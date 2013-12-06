within Lib.Exercise1;
connector Pin_b "Negative pin of an electrical component"
  Modelica.SIunits.Voltage v "Potential at the pin";
  flow Modelica.SIunits.Current i "Current flowing into the pin";
  annotation (Diagram(graphics={
                              Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255})}), Icon(graphics={
                              Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255})}));
end Pin_b;
