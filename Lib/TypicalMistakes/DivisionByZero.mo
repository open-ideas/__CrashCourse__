within Lib.TypicalMistakes;
model DivisionByZero "Model showing division by zero bug"
  parameter Modelica.SIunits.Power Q_flow = 1000;
  Modelica.SIunits.MassFlowRate m_flow_pipe = max(0,1-time);
  Modelica.SIunits.Temperature T;
equation
  T= 293.15 + Q_flow/m_flow_pipe/4180;
end DivisionByZero;
