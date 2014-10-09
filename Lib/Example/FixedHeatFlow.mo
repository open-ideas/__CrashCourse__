within Lib.Example;
model FixedHeatFlow "Fixes the heat flow in a HeatPort connector"

  parameter Modelica.SIunits.HeatFlowRate Q "Heat flowrate";
  Lib.Connectors.With.HeatPort heatPort
    annotation (Placement(transformation(extent={{84,-10},{104,10}})));

equation
  heatPort.Q_flow=-Q;
  annotation (Diagram(graphics), Icon(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-100},{100,100}}),
                                      graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),       Text(
          extent={{-52,36},{42,-40}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Text(
          extent={{-100,90},{100,50}},
          lineColor={0,0,255},
          textString="%name")}));
end FixedHeatFlow;
