within Lib.Example;
connector FlowPort "Fluid flowport, temperature based"
  Modelica.SIunits.AbsolutePressure p "absolute pressure";
  flow Modelica.SIunits.MassFlowRate m_flow "massflowrate";
  Modelica.SIunits.Temperature T "Temperature";

  annotation (Icon(graphics={Ellipse(
          extent={{-40,44},{42,-36}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end FlowPort;
