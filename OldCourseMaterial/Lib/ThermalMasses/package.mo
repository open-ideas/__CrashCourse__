within Lib;
package ThermalMasses "Set of exmaples on the use of connectors"
extends Modelica.Icons.Package;


annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
          -100},{100,100}}), graphics={
      Ellipse(
        extent={{-36,22},{-12,-2}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Ellipse(
        extent={{12,22},{36,-2}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-12,12},{12,6}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-52,44},{-16,26}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid,
        textString="Mass1"),
      Text(
        extent={{6,44},{42,26}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid,
        textString="Mass2"),
      Text(
        extent={{-14,-10},{22,-28}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid,
        textString="Thermal Connection 
(Resistance)
",      fontSize=20),
      Text(
        extent={{-32,18},{-16,6}},
        lineColor={255,255,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid,
        textString="T1"),
      Text(
        extent={{16,18},{32,6}},
        lineColor={255,255,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid,
        textString="T2"),
      Line(
        points={{-6,14},{4,14},{2,16},{4,14},{2,12}},
        color={0,0,255},
        smooth=Smooth.None),
      Text(
        extent={{-14,26},{12,14}},
        lineColor={0,0,255},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid,
        textString="Q_flow",
        fontSize=16)}));
end ThermalMasses;
