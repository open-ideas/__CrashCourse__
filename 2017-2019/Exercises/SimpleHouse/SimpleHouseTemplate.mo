model SimpleHouseTemplate
  "Template file for simple house example"
  extends Modelica.Icons.Example;

  package MediumAir = IDEAS.Media.Air "Medium model for air";
  package MediumWater = IDEAS.Media.Water "Medium model for water";

  parameter Modelica.SIunits.Area A_wall = 100 "Wall area";
  parameter Modelica.SIunits.Length d_wall = 0.25 "Wall thickness";
  parameter Modelica.SIunits.ThermalConductivity k_wall = 0.04 "Wall thermal conductivity";
  parameter Modelica.SIunits.Density rho_wall = 2000 "Wall density";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_wall = 1000 "Wall specific heat capacity";

  parameter Modelica.SIunits.Area A_win = 6 "Window area";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h = 2 "Heat transfer coefficient";
    IDEAS.BoundaryConditions.WeatherData.ReaderTMY3
                                                  weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://IDEAS/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-200,-18},{-180,2}})));


  IDEAS.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{-130,-18},{-110,2}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Tout
    "Exterior temperature boundary condition"
    annotation (Placement(transformation(extent={{-20,-8},{0,12}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalResistor wallRes(
    R=d_wall/A_wall/k_wall)
    "Thermal resistor for wall: 25 cm of rockwool"
    annotation (Placement(transformation(extent={{84,-8},{104,12}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor walCap(C=A_wall*d_wall*
        cp_wall*rho_wall, T(start=293.15))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={158,2})));
  Modelica.Blocks.Math.Gain gain(k=A_win)
    annotation (Placement(transformation(extent={{-34,112},{-14,132}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{32,112},{52,132}})));
  IDEAS.Fluid.MixingVolumes.MixingVolume vol(
    m_flow_nominal=1,
    V=8*8*3,
    redeclare package Medium = MediumAir,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=293.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{150,112},{170,132}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor wallRes1(R=1/A_wall/
        h)
    "Thermal resistor for wall: 25 cm of rockwool"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={134,82})));
  IDEAS.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumWater,
    Q_flow_nominal=3000,
    T_a_nominal=333.15,
    T_b_nominal=313.15)
    annotation (Placement(transformation(extent={{110,-116},{130,-96}})));
  IDEAS.Fluid.HeatExchangers.HeaterCooler_u hea(
    m_flow_nominal=0.1,
    Q_flow_nominal=3000,
    redeclare package Medium = MediumWater,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{40,-116},{60,-96}})));
  IDEAS.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.1,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    constantMassFlowRate=0.1)
    annotation (Placement(transformation(extent={{-6,-116},{14,-96}})));
  IDEAS.Fluid.Sources.Boundary_pT bou(nPorts=1, redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{68,-192},{88,-172}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=294.15, uHigh=296.15)
    annotation (Placement(transformation(extent={{-188,-136},{-168,-116}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-150,-136},{-130,-116}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-114,-136},{-94,-116}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{52,140},{32,160}})));
  IDEAS.Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=0.1,
    m2_flow_nominal=0.1,
    eps=0.85,
    dp1_nominal=0,
    dp2_nominal=0)
    annotation (Placement(transformation(extent={{-88,82},{-68,102}})));
  IDEAS.Fluid.Movers.FlowControlled_dp fan1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    dp_nominal=200,
    inputType=IDEAS.Fluid.Types.InputType.Constant,
    constantHead=200)
    annotation (Placement(transformation(extent={{-158,90},{-138,110}})));
  IDEAS.Fluid.Actuators.Dampers.VAVBoxExponential vavDam(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-116,90},{-96,110}})));
  IDEAS.Fluid.Sources.Boundary_pT bou1(
                                      nPorts=2,
    redeclare package Medium = MediumAir,
    use_T_in=true)
    annotation (Placement(transformation(extent={{-212,56},{-192,76}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=296.15, uHigh=298.15)
    annotation (Placement(transformation(extent={{-186,120},{-166,140}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1
    annotation (Placement(transformation(extent={{-152,120},{-132,140}})));
equation
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-180,-8},{-180,-8},{-120,-8}},
      color={255,204,51},
      thickness=0.5));
  connect(Tout.T, weaBus.TDryBul)
    annotation (Line(points={{-22,2},{-120,2},{-120,-8}}, color={0,0,127}));
  connect(Tout.port,wallRes. port_a)
    annotation (Line(points={{0,2},{0,2},{84,2}},    color={191,0,0}));
  connect(wallRes.port_b, walCap.port)
    annotation (Line(points={{104,2},{148,2}},          color={191,0,0}));
  connect(prescribedHeatFlow.port, walCap.port) annotation (Line(points={{52,122},
          {116,122},{116,2},{148,2}}, color={191,0,0}));
  connect(gain.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-13,122},{32,122}}, color={0,0,127}));
  connect(gain.u, weaBus.HDirNor) annotation (Line(points={{-36,122},{-120,122},
          {-120,-8}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(wallRes1.port_b, vol.heatPort)
    annotation (Line(points={{134,92},{134,122},{150,122}}, color={191,0,0}));
  connect(wallRes1.port_a, walCap.port)
    annotation (Line(points={{134,72},{134,2},{148,2}}, color={191,0,0}));
  connect(hea.port_b, rad.port_a)
    annotation (Line(points={{60,-106},{110,-106}}, color={0,127,255}));
  connect(fan.port_b, hea.port_a)
    annotation (Line(points={{14,-106},{40,-106}}, color={0,127,255}));
  connect(fan.port_a, rad.port_b) annotation (Line(points={{-6,-106},{-16,-106},
          {-16,-162},{158,-162},{158,-106},{130,-106}}, color={0,127,255}));
  connect(bou.ports[1], rad.port_b) annotation (Line(points={{88,-182},{104,-182},
          {104,-162},{158,-162},{158,-106},{130,-106}}, color={0,127,255}));
  connect(rad.heatPortCon, vol.heatPort) annotation (Line(points={{118,-98.8},{118,
          122},{150,122}}, color={191,0,0}));
  connect(rad.heatPortRad, walCap.port) annotation (Line(points={{122,-98.8},{122,
          -62},{134,-62},{134,2},{148,2}}, color={191,0,0}));
  connect(temperatureSensor.port, vol.heatPort) annotation (Line(points={{52,150},
          {134,150},{134,122},{150,122}}, color={191,0,0}));
  connect(temperatureSensor.T, hysteresis.u) annotation (Line(points={{32,150},{
          -224,150},{-224,-126},{-190,-126}}, color={0,0,127}));
  connect(hysteresis.y, not1.u)
    annotation (Line(points={{-167,-126},{-152,-126}}, color={255,0,255}));
  connect(booleanToReal.u, not1.y)
    annotation (Line(points={{-116,-126},{-129,-126}}, color={255,0,255}));
  connect(booleanToReal.y, hea.u) annotation (Line(points={{-93,-126},{-38,-126},
          {-38,-74},{38,-74},{38,-100}}, color={0,0,127}));
  connect(fan1.port_a, bou1.ports[1]) annotation (Line(points={{-158,100},{-192,
          100},{-192,68}}, color={0,127,255}));
  connect(fan1.port_b, vavDam.port_a)
    annotation (Line(points={{-138,100},{-116,100}}, color={0,127,255}));
  connect(vavDam.port_b, hex.port_a1) annotation (Line(points={{-96,100},{-92,
          100},{-92,98},{-88,98}}, color={0,127,255}));
  connect(hex.port_b2, bou1.ports[2]) annotation (Line(points={{-88,86},{-140,
          86},{-140,64},{-192,64}}, color={0,127,255}));
  connect(hex.port_b1, vol.ports[1])
    annotation (Line(points={{-68,98},{158,98},{158,112}}, color={0,127,255}));
  connect(bou1.T_in, weaBus.TDryBul) annotation (Line(points={{-214,70},{-218,
          70},{-218,-26},{-120,-26},{-120,-8}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(hex.port_a2, vol.ports[2]) annotation (Line(points={{-68,86},{164,86},
          {164,112},{162,112}}, color={0,127,255}));
  connect(hysteresis1.y, booleanToReal1.u)
    annotation (Line(points={{-165,130},{-154,130}}, color={255,0,255}));
  connect(booleanToReal1.y, vavDam.y) annotation (Line(points={{-131,130},{-106,
          130},{-106,112}}, color={0,0,127}));
  connect(hysteresis1.u, hysteresis.u) annotation (Line(points={{-188,130},{
          -224,130},{-224,-126},{-190,-126}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,
            -220},{200,200}}), graphics={
        Rectangle(
          extent={{-220,40},{20,-40}},
          fillColor={238,238,238},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-220,-60},{180,-200}},
          fillColor={238,238,238},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-220,180},{180,60}},
          fillColor={238,238,238},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-144,154},{-210,172}},
          lineColor={0,0,127},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Ventilation"),
        Rectangle(
          extent={{40,40},{180,-40}},
          fillColor={238,238,238},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{98,20},{32,38}},
          lineColor={0,0,127},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Wall"),
        Text(
          extent={{-148,-86},{-214,-68}},
          lineColor={0,0,127},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Heating"),
        Text(
          extent={{-118,18},{-214,40}},
          lineColor={0,0,127},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Weather inputs")}),
    experiment(StopTime=1e+06),
    Documentation(revisions="<html>
<ul>
<li>
October 11, 2016, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model is used in an exercise at KU Leuven
to demonstrate the use of Modelica using mainly fluid parts
from the IDEAS / Annex60 library.
</p>
</html>"),
    __Dymola_Commands(file=
          "modelica://IDEAS/Resources/Scripts/Dymola/Fluid/Examples/SimpleHouse.mos"
        "Simulate and plot"),
    uses(Modelica(version="3.2.2"), IDEAS(version="1.0.0")));
end SimpleHouseTemplate;
