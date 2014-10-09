within Lib.ThermalMasses.ClassesAndConnectors;
model Resistor

// a resistance has two heat port
// notice the coding convention "_a" and "_b"
  HeatPort heatPort_a
                    annotation (Placement(transformation(extent={{-90,-10},{-70,
            10}}), iconTransformation(extent={{-90,-10},{-70,10}})));
  HeatPort heatPort_b
                     annotation (Placement(transformation(extent={{70,-10},{90,10}}),
        iconTransformation(extent={{70,-10},{90,10}})));

parameter Modelica.SIunits.ThermalResistance R = 1
    "Thermal resistance in Watt per Kelvin";

equation
// Fourier's conduction law
heatPort_a.Q_flow = (heatPort_a.T - heatPort_b.T) / R;
// conservation of energy
heatPort_a.Q_flow + heatPort_b.Q_flow = 0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={Rectangle(extent={{-80,20},{80,-20}}, lineColor={0,
              0,255}), Text(
          extent={{-92,-30},{98,-72}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}}), graphics));
end Resistor;
