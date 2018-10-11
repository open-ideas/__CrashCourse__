within Lib.Exercise1;
connector Pin_a "Positive pin of an electrical component"
  extends Pin;
  annotation (Diagram(graphics), Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end Pin_a;
