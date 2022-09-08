within Lib.Exercise1;
model SineVoltage "Sine voltage source"
  extends TwoPin;
  parameter Modelica.SIunits.Voltage V(start=1) "Amplitude of sine wave";
  parameter Modelica.SIunits.Angle phase=0 "Phase of sine wave";
  parameter Modelica.SIunits.Frequency freqHz(start=1) "Frequency of sine wave";
  parameter Modelica.SIunits.Voltage offset = 0 "Offset of source";

equation
  v = V*sin( 2*Modelica.Constants.pi * freqHz * time + phase) + offset;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-40,50},{60,-50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{100,0}},
                                      color={0,0,255}),
        Text(
          extent={{-118,50},{-18,0}},
          lineColor={0,0,255},
          textString="+"),                         Line(points={{-56,0},{-46.2,
              29.9},{-39.8,46.5},{-34.2,58.1},{-29.3,65.2},{-24.3,69.2},{-19.4,
              69.8},{-14.5,67},{-9.6,61},{-4.6,52},{1,38.6},{8.02,18.6},{22.79,
              -26.9},{29.1,-44},{34.8,-56.2},{39.7,-64},{44.6,-68.6},{49.5,-70},
              {54.5,-67.9},{59.4,-62.5},{64.3,-54.1},{69.9,-41.3},{77,-21.7},{
              84,0}},
            color={192,192,192}),
        Text(
          extent={{30,50},{130,0}},
          lineColor={0,0,255},
          textString="-")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-99,-40},{100,-40}},color={192,192,192}),
        Polygon(
          points={{100,-40},{84,-34},{84,-46},{100,-40}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-41,-2},{-32.6,32.2},{-27.1,51.1},{-22.3,64.4},{-18.1,72.6},
              {-13.9,77.1},{-8,78},{-5.42,74.6},{-1.201,67.7},{3.02,57.4},{
              7.84,42.1},{13.9,19.2},{26.5,-32.8},{32,-52.2},{36.8,-66.2},{41,
              -75.1},{45.2,-80.4},{49.5,-82},{53.7,-79.6},{57.9,-73.5},{62.1,
              -63.9},{66.9,-49.2},{73,-26.8},{79,-2}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-41,-2},{-80,-2}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-106,-11},{-60,-29}},
          lineColor={160,160,164},
          textString="offset"),
        Line(
          points={{-41,-2},{-41,-40}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Text(
          extent={{-60,-43},{-14,-61}},
          lineColor={160,160,164},
          textString="startTime"),
        Text(
          extent={{76,-52},{100,-72}},
          lineColor={160,160,164},
          textString="time"),
        Line(
          points={{-8,78},{45,78}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Line(
          points={{-41,-2},{52,-2}},
          color={192,192,192},
          pattern=LinePattern.Dash),
        Polygon(
          points={{33,78},{30,65},{37,65},{33,78}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{37,57},{83,39}},
          lineColor={160,160,164},
          textString="V"),
        Polygon(
          points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{33,78},{33,-2}},
          color={192,192,192},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None})}),
    Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>This voltage source uses the corresponding signal source of the Modelica.Blocks.Sources package. Care for the meaning of the parameters in the Blocks package. Furthermore, an offset parameter is introduced, which is added to the value calculated by the blocks source. The startTime parameter allows to shift the blocks source behavior on the time axis.</p>
</html>"));
end SineVoltage;
