within Lib.TypicalMistakes;
model ParallelPathsPump
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
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan1(
                                               redeclare package Medium =
        Medium, m_flow_nominal=1,
    dynamicBalance=false,
    filteredSpeed=false)
    annotation (Placement(transformation(extent={{52,0},{72,20}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan2(
                                               redeclare package Medium =
        Medium, m_flow_nominal=1,
    dynamicBalance=false,
    filteredSpeed=false)
    annotation (Placement(transformation(extent={{52,-30},{72,-10}})));
  Modelica.Blocks.Math.Gain gain(k=0.5)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation
  connect(const.y,fan. m_flow_in) annotation (Line(points={{-19,30},{-10,30},{
          -10,12}},   color={0,0,127}));
  connect(rad.port_a, fan.port_b)
    annotation (Line(points={{20,10},{0,10},{0,0}}, color={0,127,255}));
  connect(fan.port_b, rad1.port_a) annotation (Line(points={{0,0},{0,0},{0,-10},
          {0,-20},{20,-20}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a)
    annotation (Line(points={{-40,0},{-40,0},{-20,0}},  color={0,127,255}));
  connect(rad.port_b, fan1.port_a)
    annotation (Line(points={{40,10},{52,10}}, color={0,127,255}));
  connect(fan1.port_b, fan.port_a) annotation (Line(points={{72,10},{92,10},{92,
          -50},{-20,-50},{-20,0}}, color={0,127,255}));
  connect(rad1.port_b, fan2.port_a)
    annotation (Line(points={{40,-20},{52,-20}}, color={0,127,255}));
  connect(fan2.port_b, fan.port_a) annotation (Line(points={{72,-20},{92,-20},{
          92,-50},{-20,-50},{-20,0}}, color={0,127,255}));
  connect(gain.u, const.y)
    annotation (Line(points={{-2,30},{-19,30}}, color={0,0,127}));
  connect(gain.y, fan1.m_flow_in)
    annotation (Line(points={{21,30},{62,30},{62,22}},     color={0,0,127}));
  connect(fan1.m_flow_in, fan2.m_flow_in)
    annotation (Line(points={{62,22},{62,22},{62,-8}},       color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p><span style=\"font-family: Sans Serif;\">The system is singular since:</span></p>
<p><span style=\"font-family: Sans Serif;\">m_flow_left = 1</span></p>
<p><span style=\"font-family: Sans Serif;\">m_flow_right_top = 0.5</span></p>
<p><span style=\"font-family: Sans Serif;\">from this we can already deduce that m_flow_right_bottom = 0.5 since mass is conserved. Adding the third pump again adds m_flow_right_bottom = 0.5. This leads to a singular system. Note that in this system the pressure in the radiators is undefined.</span></p>
</html>"));
end ParallelPathsPump;
