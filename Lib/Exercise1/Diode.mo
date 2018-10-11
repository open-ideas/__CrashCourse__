within Lib.Exercise1;
model Diode "Simple diode"
  extends TwoPin;
  parameter Modelica.SIunits.Current Ids=1.e-6 "Saturation current";
  parameter Modelica.SIunits.Voltage Vt=0.04 "Voltage equivalent of temperature (kT/qn)";
  parameter Real Maxexp(final min=Modelica.Constants.small) = 15
    "Max. exponent for linear continuation";
  parameter Modelica.SIunits.Resistance R=1.e8 "Parallel ohmic resistance";

equation
  i = if (v/Vt > Maxexp) then Ids*(exp(Maxexp)*(1 + v/Vt - Maxexp) - 1) + v/R
     else Ids*(exp(v/Vt) - 1) + v/R;
  annotation (
    Documentation(info="<html>
<p>The simple diode is a one port. It consists of the diode itself and an parallel ohmic resistance <i>R</i>. The diode formula is:</p>
<pre>                v/vt
  i  =  ids ( e      - 1).</pre>
<p>If the exponent <i>v/vt</i> reaches the limit <i>maxex</i>, the diode characteristic is linearly continued to avoid overflow.</p><p><b>Please note:</b> In case of useHeatPort=true the temperature dependence of the electrical behavior is <b>not </b>modelled yet. The parameters are not temperature dependent.</p>
</html>", revisions="<html>
<ul>
<li><i> March 11, 2009   </i>
       by Christoph Clauss<br> conditional heat port added<br>
       </li>
<li><i> November 15, 2005   </i>
       by Christoph Clauss<br> smooth function added<br>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> implemented<br>
       </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,0},{40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255}),
        Text(
          extent={{-150,-49},{149,-77}},
          lineColor={0,0,0},
          textString="Vt=%Vt"),
        Text(
          extent={{-154,100},{146,60}},
          textString="%name",
          lineColor={0,0,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,-20}},
          color={127,0,0},
          smooth=Smooth.None,
          pattern=LinePattern.Dot)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{30,0},{-30,40},{-30,-40},{30,0}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.None),
        Line(points={{-96,0},{96,0}}, color={0,0,255}),
        Line(points={{30,40},{30,-40}}, color={0,0,255})}));
end Diode;
