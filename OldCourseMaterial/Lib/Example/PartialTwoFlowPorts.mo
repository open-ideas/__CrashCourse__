within Lib.Example;
partial model PartialTwoFlowPorts
  "Partial model for a 2 flowport component with conservation of mass"

  FlowPort flowPort_a "inlet, positive flow here means normal flow direction"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FlowPort flowPort_b "outlet, negative flow here means normal flow direction"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.Temperature T
    "Temperature of the component is the outlet temperature";
equation
  flowPort_a.m_flow+flowPort_b.m_flow=0;
  T=flowPort_b.T;

  annotation (Icon(graphics={Line(
          points={{-60,-80},{80,-80},{60,-70},{60,-90},{80,-80}},
          color={0,0,255},
          smooth=Smooth.None)}));
end PartialTwoFlowPorts;
