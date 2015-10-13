within Lib.TypicalMistakes;
model ParallelPaths
  package Medium = IDEAS.Media.Water;

  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = Medium,
    Q_flow_nominal=3000,
    T_a_nominal=273.15 + 70,
    T_b_nominal=273.15 + 50)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Medium, m_flow_nominal=1,
    dynamicBalance=false,
    filteredSpeed=false)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad1(
    redeclare package Medium = Medium,
    Q_flow_nominal=3000,
    T_a_nominal=273.15 + 70,
    T_b_nominal=273.15 + 50)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
equation
  connect(const.y,fan. m_flow_in) annotation (Line(points={{-19,30},{-10.2,30},
          {-10.2,12}},color={0,0,127}));
  connect(rad.port_a, fan.port_b)
    annotation (Line(points={{20,10},{0,10},{0,0}}, color={0,127,255}));
  connect(fan.port_b, rad1.port_a) annotation (Line(points={{0,0},{0,0},{0,-10},
          {0,-20},{20,-20}}, color={0,127,255}));
  connect(rad1.port_b, fan.port_a) annotation (Line(points={{40,-20},{54,-20},{
          54,-22},{54,-50},{-20,-50},{-20,0}},       color={0,127,255}));
  connect(rad.port_b, fan.port_a) annotation (Line(points={{40,10},{40,10},{54,10},
          {54,-50},{-20,-50},{-20,0}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a)
    annotation (Line(points={{-40,0},{-40,0},{-20,0}},  color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end ParallelPaths;
