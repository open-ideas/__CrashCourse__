within CrashCourse.Example;
model FlowBoundary_OnlyPressure "Fixes pressure, temperature "
parameter Modelica.SIunits.Temperature T "Boundary temperature";
parameter Modelica.SIunits.Pressure p "Boundary pressure";

  FlowPort flowPort
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));

equation
  flowPort.p=p;

  annotation (Diagram(graphics), Icon(graphics={Ellipse(
          extent={{-86,80},{76,-78}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid)}));
end FlowBoundary_OnlyPressure;
