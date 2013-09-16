within Lib.Example_IDEAS;
model HeatingStupid "stupid heating"

  import IDEAS.Thermal.Components.Emission.Interfaces.EmissionType;
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem(nZones=2,
    final emissionType = EmissionType.FloorHeating,
    nLoads=1);

  IDEAS.Thermal.Components.Emission.EmbeddedPipe embeddedPipe(m_flowMin=0.1)
    annotation (Placement(transformation(extent={{6,44},{30,60}})));
  IDEAS.Thermal.Components.Emission.EmbeddedPipe embeddedPipe1(m_flowMin=0.1)
    annotation (Placement(transformation(extent={{-10,-4},{14,12}})));
  IDEAS.Thermal.Components.BaseClasses.Ambient ambient(
    medium=IDEAS.Thermal.Data.Media.Water(),
    constantAmbientPressure=500000,
    constantAmbientTemperature=303.15)
    annotation (Placement(transformation(extent={{-80,6},{-60,26}})));
  IDEAS.Thermal.Components.BaseClasses.Ambient ambient1(
    medium=IDEAS.Thermal.Data.Media.Water(),
    constantAmbientPressure=300000,
    constantAmbientTemperature=293.15)
    annotation (Placement(transformation(extent={{102,16},{122,36}})));
  IDEAS.Thermal.Components.BaseClasses.Pump pump(m_flowNom=0.2,
    m=1,
    medium=IDEAS.Thermal.Data.Media.Water())
    annotation (Placement(transformation(extent={{52,40},{72,60}})));
  IDEAS.Thermal.Components.BaseClasses.Pump pump1(m_flowNom=0.2,
    m=1,
    medium=IDEAS.Thermal.Data.Media.Water())
    annotation (Placement(transformation(extent={{42,0},{62,20}})));
equation
  connect(embeddedPipe.heatPortEmb, heatPortEmb[1]) annotation (Line(
      points={{11,59.8},{11,55},{-200,55}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(embeddedPipe1.heatPortEmb, heatPortEmb[2]) annotation (Line(
      points={{-5,11.8},{-5,65},{-200,65}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(ambient.flowPort, embeddedPipe.flowPort_a) annotation (Line(
      points={{-80,16},{-92,16},{-92,47},{6,47}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ambient.flowPort, embeddedPipe1.flowPort_a) annotation (Line(
      points={{-80,16},{-84,16},{-84,2},{-88,2},{-88,-1},{-10,-1}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(embeddedPipe.flowPort_b, pump.flowPort_a) annotation (Line(
      points={{30,57},{36,57},{36,56},{52,56},{52,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump.flowPort_b, ambient1.flowPort) annotation (Line(
      points={{72,50},{82,50},{82,26},{102,26}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(embeddedPipe1.flowPort_b, pump1.flowPort_a) annotation (Line(
      points={{14,9},{28,9},{28,10},{42,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pump1.flowPort_b, ambient1.flowPort) annotation (Line(
      points={{62,10},{82,10},{82,26},{102,26}},
      color={0,0,255},
      smooth=Smooth.None));
QHeatTotal = 0; // useful output, QHeatTotal defined in partial
P[1] = 0;
Q[1] = 0;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end HeatingStupid;
