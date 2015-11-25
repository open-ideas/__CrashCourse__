within Lib.TypicalMistakes;
model UnconnectedPort "Model showing error when ports are unconnected"

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
//   fixedHeatFlow.port.T=29;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p><span style=\"font-family: Sans Serif;\">When a connector is unconnected from the outside, Dymola will add default equations setting the <i>flow</i> variable of the connector to zero. In the current example this means that fixedHeatFlow.port.Q_flow = 0, while this equation is already produced inside the component itself. Therefore the same equation is used twice, but more importantly there is no equation that defines the temperatur of the heat port, leading to a singular system.</span></p>
</html>"));
end UnconnectedPort;
