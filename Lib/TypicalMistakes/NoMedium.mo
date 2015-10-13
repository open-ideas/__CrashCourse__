within Lib.TypicalMistakes;
model NoMedium
  package Medium = IDEAS.Media.Water;

  IDEAS.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium =
        Medium, m_flow_nominal=1,
    dynamicBalance=false,
    filteredSpeed=false)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    Q_flow_nominal=3000,
    T_a_nominal=273.15 + 70,
    T_b_nominal=273.15 + 50)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
equation
  connect(fan.port_b, rad.port_a)
    annotation (Line(points={{0,0},{10,0},{20,0}},
                                            color={0,127,255}));
  connect(rad.port_b, fan.port_a) annotation (Line(points={{40,0},{60,0},{60,
          -40},{-40,-40},{-40,0},{-20,0}},
                                      color={0,127,255}));
  connect(const.y, fan.m_flow_in) annotation (Line(points={{-19,30},{-10.2,30},
          {-10.2,12}},color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p>This model does not contain a pressure boundary (component boundary_pT) and therefore the <b>absolute</b> pressure is not defined in this system.</p>
</html>"));
end NoMedium;
