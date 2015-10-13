within Lib.TypicalMistakes;
model UnconnectedPort "Model showing error when ports are unconnected"

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=10)
    annotation (Placement(transformation(extent={{-14,52},{6,72}})));
equation
//   fixedHeatFlow.port.T=29;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end UnconnectedPort;
