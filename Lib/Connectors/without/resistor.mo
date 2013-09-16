within Lib.Connectors.without;
model resistor

Modelica.SIunits.Temperature T_a "Left-side resistor temprature";
Modelica.SIunits.Temperature T_b "Right-side resistor temprature";

Modelica.SIunits.HeatFlowRate Q_flow_a "Left-side resistor heat exchange";
Modelica.SIunits.HeatFlowRate Q_flow_b "Right-side resistor heat exchange";

parameter Modelica.SIunits.ThermalResistance R = 1
    "Thermal resistance in Watt per Kelvin";

equation
Q_flow_a = (T_a - T_b) / R;
Q_flow_a + Q_flow_b = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(extent={{-80,20},{80,-20}},
            lineColor={0,0,255})}));
end resistor;
