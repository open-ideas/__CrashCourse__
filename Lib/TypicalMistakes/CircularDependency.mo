within Lib.TypicalMistakes;
model CircularDependency
  "Model showing error when writing circular dependencies"
  parameter Modelica.SIunits.Power Q_flow = m_flow_nominal*4180*10;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = Q_flow/4180/10;
  parameter Modelica.SIunits.SpecificHeatCapacity cp = 4180;
end CircularDependency;
