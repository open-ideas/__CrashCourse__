within Lib.TypicalMistakes;
model DivisionByZero "Model showing division by zero bug"
  parameter Modelica.SIunits.Power Q_flow = 1000;
  Modelica.SIunits.MassFlowRate m_flow_pipe = max(0,1-time);
  Modelica.SIunits.Temperature T;
equation
  T= 293.15 + Q_flow/m_flow_pipe/4180;
  annotation (Documentation(info="<html>
<p><code><span style=\"font-family: Courier New,courier;\">Variable <b>m_flow_pipe </b>becomes zero when time = 1. This generates a division by zero, which is mathematically undefined and therefore generates an error. Such problems need to be avoided by changing the used equations.</span></code></p>
</html>"));
end DivisionByZero;
