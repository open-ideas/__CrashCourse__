within Lib;
package Task
  extends Modelica.Icons.Package;
  model House_EqBased
    type Temperature=Real(unit="K");
    type HeatFlow=Real(unit="W");
    type Resistance=Real(unit="K/W");
    type Capacitance=Real(unit="J/K");

    parameter Integer n = 5;

    parameter Resistance RWall=0.00806;
    parameter Resistance RSlab1=0.016;
    parameter Resistance RSlab2=0.016;
    parameter Resistance RGro1[n] = 0.033 * ones(n);
    parameter Resistance RGro2[n] = 0.033 * ones(n);
    parameter Capacitance CZone = 240960000;
    parameter Capacitance CSlab = 336000000;
    parameter Capacitance CGro[n] = 2.52*10^8 * ones(n);

    parameter Temperature TGroBou = 283.15;

    Temperature TAmb = 10*cos(2*Modelica.Constants.pi*time * 3*10^(-8)) + 276.15;
    Temperature TZone(start=293.15);
    Temperature TSlab(start=293.15);
    Temperature TGro[n](each start=283.15);
  protected
    HeatFlow QZA;
    HeatFlow QZS;
    HeatFlow QZone;
    HeatFlow QSlab;
    HeatFlow QSG;
    HeatFlow QGG[n+1];
    HeatFlow QGro[n];

    HeatFlow QSol = floor(cos(2*Modelica.Constants.pi*time / 86400) + 1) * 5000 * cos(2*Modelica.Constants.pi*time / 86400);
  equation
    // Zone equation
    TZone - TAmb = RWall * QZA;
    TZone - TSlab = RSlab1 * QZS;
    CZone * der(TZone) = QZone;
    QZA + QZS + QZone - QSol = 0;

    // Slab equation
    CSlab * der(TSlab) = QSlab;
    TSlab - TGro[1] = (RSlab2 + RGro1[1]) * QSG;
    QSlab + QSG - QZS = 0;

    //Ground equation
    QGG[1] = QSG;
    for i in 1:n-1 loop
      CGro[i] * der(TGro[i]) = QGro[i];
      TGro[i] - TGro[i+1] = (RGro2[i] + RGro1[i+1]) * QGG[i+1];
      QGG[i+1] + QGro[i] - QGG[i] = 0;
    end for;
    CGro[n] * der(TGro[n]) = QGro[n];
    TGro[n]- TGroBou = RGro2[n] * QGG[n+1];
    QGG[n+1] + QGro[n] - QGG[n] = 0;
  end House_EqBased;

  model House_OjectsBased

    parameter Integer n = 5 "number of ground layer";
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CZone(C=1004*1.2*(20*20
          *5)*100, T(start=293.15)) "Zone capacity"
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RWall(R=(0.31*(20*
          5)*4)^(-1)) "Resistance of outerwall"
      annotation (Placement(transformation(extent={{-38,10},{-18,30}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    Modelica.Blocks.Sources.Cosine TAmb(
      freqHz=3*10^(-8),
      amplitude=10,
      offset=276.15)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RSlab1(R=((0.6*
          0.25 + 0.036*0.1)*20*20)^(-1))
                           annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={0,0})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RSlab2(R=((0.6*
          0.25 + 0.036*0.1)*20*20)^(-1))
                           annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={0,-30})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CSlab(C=840*2000*(20*20
          *0.5), T(start=293.15)) "slab capacity" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={28,-16})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RGro1[n](each R=((
          0.3*0.25)*20*20)^(-1))
                          annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-30,-60})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor CGro[n](each C=840*1500*(20*
          20*0.5), each T(start=293.15)) "slab capacity" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-54,-50})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TGro(T=283.15)
      annotation (Placement(transformation(extent={{-60,-100},{-80,-80}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor RGro2[n](each R=((
          0.3*0.25)*20*20)^(-1))
                annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-78,-60})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow QSol "Solar gain"
      annotation (Placement(transformation(extent={{40,40},{20,60}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=floor(cos(2*
          Modelica.Constants.pi*time/86400) + 1)*5000*cos(2*Modelica.Constants.pi
          *time/86400))
      annotation (Placement(transformation(extent={{78,40},{58,60}})));
  equation
    connect(RWall.port_b, CZone.port) annotation (Line(
        points={{-18,20},{0,20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(prescribedTemperature.port, RWall.port_a) annotation (Line(
        points={{-40,70},{-20,70},{-20,40},{-60,40},{-60,20},{-38,20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(RSlab1.port_a, RSlab2.port_b) annotation (Line(
        points={{0,-10},{0,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(CSlab.port, RSlab2.port_b) annotation (Line(
        points={{18,-16},{0,-16},{0,-20},{1.83187e-015,-20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(RSlab1.port_b, CZone.port) annotation (Line(
        points={{0,10},{0,20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(RSlab2.port_a, RGro1[1].port_b) annotation (Line(
        points={{0,-40},{0,-60},{-20,-60}},
        color={191,0,0},
        smooth=Smooth.None));

    for i in 1:n-1 loop
      connect(RGro1[i].port_a, CGro[i].port) annotation (Line(
          points={{-40,-60},{-54,-60}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(RGro2[i].port_b, CGro[i].port) annotation (Line(
        points={{-68,-60},{-54,-60}},
        color={191,0,0},
        smooth=Smooth.None));
      connect(RGro2[i].port_a, RGro1[i+1].port_b) annotation (Line(
        points={{-88,-60},{-88,-32},{-20,-32},{-20,-60}},
        color={191,0,0},
        smooth=Smooth.None));
    end for;
    connect(RGro1[n].port_a, CGro[n].port) annotation (Line(
          points={{-40,-60},{-54,-60}},
          color={191,0,0},
          smooth=Smooth.None));
    connect(RGro2[n].port_b, CGro[n].port) annotation (Line(
        points={{-68,-60},{-54,-60}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(RGro2[n].port_a, TGro.port)  annotation (Line(
        points={{-88,-60},{-88,-90},{-80,-90}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(QSol.port, CZone.port) annotation (Line(
        points={{20,50},{12,50},{12,20},{0,20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(TAmb.y, prescribedTemperature.T) annotation (Line(
        points={{-79,70},{-62,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, QSol.Q_flow) annotation (Line(
        points={{57,50},{40,50}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end House_OjectsBased;

  model House_ObjectBasedHeated
    extends Lib.Task.House_OjectsBased;
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature prescribedTemperatureZone(T=293.15)
      annotation (Placement(transformation(extent={{40,10},{20,30}})));
  equation

    connect(prescribedTemperatureZone.port, CZone.port) annotation (Line(
        points={{20,20},{0,20}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end House_ObjectBasedHeated;

end Task;
