within Lib.Connectors.Without;
model Resistor
  "Thermal resistance model. Model is singular when it is use alone because it lacks two equation (for T_a / T_b or for Q_flow_a Q_flow_b)"

Modelica.SIunits.Temperature T_a "Left-side resistor temperature";
Modelica.SIunits.Temperature T_b "Right-side resistor temperature";

Modelica.SIunits.HeatFlowRate Q_flow_a "Left-side resistor heat exchange";
Modelica.SIunits.HeatFlowRate Q_flow_b "Right-side resistor heat exchange";

parameter Modelica.SIunits.ThermalResistance R = 1
    "Thermal resistance in Watt per Kelvin";

equation
// Fourier's conduction law
Q_flow_a = (T_a - T_b) / R;
//conservation of energy. Notice that flow to object is +, from of object is -
Q_flow_a + Q_flow_b = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(extent={{-80,20},{80,-20}},
            lineColor={0,0,255})}));
end Resistor;
