within Lib.TypicalMistakes;
model CircularDependency
  "Model showing error when writing circular dependencies"
  parameter Modelica.SIunits.Power Q_flow = m_flow_nominal*4180*10;
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = Q_flow/4180/10;
  parameter Modelica.SIunits.SpecificHeatCapacity cp = 4180;
  annotation (Documentation(info="<html>
<pre><span style=\"font-family: Courier New,courier;\">Parameter m_flow_nominal and Q_flow are a function of each other such that a circular dependency exists. This can produce an unclear warning when simulating the model.</span></pre>
</html>"));
end CircularDependency;
