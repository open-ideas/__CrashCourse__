within Lib.ThermalMasses.OneClass;
model TwoThermalMasses "Make a file to simulate two connected thermal masses"

  //Thermal mass model1.
  Modelica.SIunits.Temperature T1(start=273.15) "mass temperature";
  Modelica.SIunits.HeatFlowRate Q_flow1 "heat exchange";

  parameter Modelica.SIunits.Mass m1 = 1.5 "mass, in kg";
  parameter Modelica.SIunits.SpecificHeatCapacity c1 = 1600
    "specific capacity, J/kgK";
  final parameter Modelica.SIunits.HeatCapacity C1 = c1*m1
    "dangerous without 'final' keyword";

  //Thermal mass model2.
  Modelica.SIunits.Temperature T2(start=400) "mass temperature";
  Modelica.SIunits.HeatFlowRate Q_flow2 "heat exchange";

  parameter Modelica.SIunits.Mass m2 = 1.5 "mass, in kg";
  parameter Modelica.SIunits.SpecificHeatCapacity c2 = 1600
    "specific capacity, J/kgK";
  final parameter Modelica.SIunits.HeatCapacity C2 = c2*m2
    "dangerous without 'final' keyword";

  //Thermal resistance model Fourier conduction.

  Modelica.SIunits.Temperature T_a "Left-side resistor temperature";
  Modelica.SIunits.Temperature T_b "Right-side resistor temperature";

  Modelica.SIunits.HeatFlowRate Q_flow_a "Left-side resistor heat entering";
  Modelica.SIunits.HeatFlowRate Q_flow_b "Right-side resistor heat entering";

  parameter Modelica.SIunits.ThermalResistance R = 1
    "Thermal resistance in Watt per Kelvin";

equation
  //thermal mass
  //differential equation
  C1 * der(T1) = Q_flow1;
  C2 * der(T2) = Q_flow2;

  //Resistance
  // Fourier's conduction law
  Q_flow_a = (T_a - T_b) / R;
  //conservation of energy. Notice that flow to object is +, from of object is -
  Q_flow_a + Q_flow_b = 0;

  //Connect
  T1 = T_a;
  T2 = T_b;

  // (Kirchhoff Junction Rule)
  Q_flow1 + Q_flow_a = 0;
  Q_flow2 + Q_flow_b = 0;

  annotation (experiment(StopTime=10000));
end TwoThermalMasses;
