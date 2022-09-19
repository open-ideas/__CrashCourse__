within ElectricalExample;
connector Pin_pos "Positive pin"
  extends Pin;
  annotation (Icon(graphics={Polygon(points={{-20,100},{-20,100}}, lineColor={
              28,108,200}), Polygon(
          points={{-20,100},{-20,20},{-100,20},{-100,-20},{-20,-20},{-20,-100},
              {20,-100},{20,-20},{100,-20},{100,20},{20,20},{20,100},{-20,100}},

          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}));
end Pin_pos;
