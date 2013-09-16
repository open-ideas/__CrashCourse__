within CrashCourse.Connectors.with;
connector HeatPort
Modelica.SIunits.Temperature T "potential";
flow Modelica.SIunits.HeatFlowRate Q_flow "flow variable";

/*
This is a block comment.
This model shows the use of predefined types for SI units

Analogue, e.g.
  Modelica.SIunits.pressure p;
  flow Modelica.SIunits.MassFlowrate m_flow;
*/
  annotation (Icon);
end HeatPort;
