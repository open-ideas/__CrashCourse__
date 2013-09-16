within CrashCourse.Connectors.with;
model resistor

  HeatPort heatPort_a
                    annotation (Placement(transformation(extent={{-90,-10},{-70,
            10}}), iconTransformation(extent={{-90,-10},{-70,10}})));
  HeatPort heatPort_b
                     annotation (Placement(transformation(extent={{70,-10},{90,10}}),
        iconTransformation(extent={{70,-10},{90,10}})));

parameter Modelica.SIunits.ThermalResistance R = 1
    "Thermal resistance in Watt per Kelvin";

equation
heatPort_a.Q_flow = (heatPort_a.T - heatPort_b.T) / R;
heatPort_a.Q_flow + heatPort_b.Q_flow = 0;

  annotation (Icon(graphics={Rectangle(extent={{-80,20},{80,-20}}, lineColor={0,
              0,255})}));
end resistor;
