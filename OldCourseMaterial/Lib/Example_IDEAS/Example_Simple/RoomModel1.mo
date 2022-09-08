within Lib.Example_IDEAS.Example_Simple;
model RoomModel1
  Connectors.With.Mass capZon(T(start=293.15)) "thermal capacity of the zone"
    annotation (Placement(transformation(extent={{52,30},{32,50}})));
  Connectors.With.Resistor resThe(R=1) "thermal resistance of the house"
    annotation (Placement(transformation(extent={{-6,30},{14,50}})));
  Example.FixedTemperature fixedTemperature
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
equation
  connect(resThe.heatPort_b, capZon.heatPort) annotation (Line(
      points={{12,40},{35.8,40}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end RoomModel1;
