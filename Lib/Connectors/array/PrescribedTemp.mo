within Lib.Connectors.array;
model PrescribedTemp

  input Real T;

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort annotation (extent=[90,-10; 110,10]);
equation
  heatPort.T=T;
    annotation (Diagram, Icon(graphics={Text(
            extent={{-32,34},{28,-34}},
            lineColor={0,0,255},
            lineThickness=0.5,
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid,
            textString="T")}));
end PrescribedTemp;
