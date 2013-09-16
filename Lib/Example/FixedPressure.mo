within Lib.Example;
model FixedPressure "Fixes the absolute pressure in a hydraulic circuit"
  parameter Modelica.SIunits.Pressure p "absolute pressure";

  FlowPort flowPort
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  flowPort.m_flow=0;
  flowPort.p=p;
  annotation (Icon(graphics={Text(
          extent={{-16,22},{16,-18}},
          lineColor={0,0,255},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          textString="P")}));
end FixedPressure;
