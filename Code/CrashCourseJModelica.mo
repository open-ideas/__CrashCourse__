within ;
package CrashCourseJModelica "Library for JModelica"
model Example01a

parameter Real a=2;
parameter Real b=-10;
Real x;

equation
x^2 + a*x + b = 0;

end Example01a;

model Example01b

parameter Real a=2;
parameter Real b=-10;
Real x(start=-10);

equation
x^2 + a*x + b = 0;

end Example01b;

model Example02a

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);
Real x;

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

end Example02a;

  model Example02b

    parameter Real a=3;
    Real x(start=-2);
    Real y;
    Real z;

  equation
    y - a*z = 4;
    z + y = -8;
    cosh(x) = y + 10;

  end Example02b;

model Example03a

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);
Real x;
Real y; // Integer y would give an error

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

algorithm
  y:= n*x;

end Example03a;

model Example03b

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);
Real x;
Real y; // Integer y would give an error

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

algorithm
  y:= n*x;
  if y > x then
    y :=x;
  else
     y:=-x;
  end if;

end Example03b;

model Example03c

parameter Real a=2;
parameter Real b=-10;
parameter Integer n = 6;
Boolean biggerThan5(start=false);
Real x(start=-10);
Real y; // Integer y would give an error

equation
x^2 + a*x + b = 0;
biggerThan5= n>5;

algorithm
  y:= n*x;
  if y > x then
    y :=x;
  else
     y:=-x;
  end if;

end Example03c;

model Mass
parameter Real m=1.5 "mass, in kg";
parameter Real c=1600 "specific capacity, J/kgK";
parameter Real UA=20 "heat transfer coefficient, in W/K";
parameter Real C = c*m "dangerous without 'final' keyword";
Real T(start=200);
parameter Real Ta=300;

equation
C * der(T) + UA * (T-Ta) = 0;

end Mass;

model TwoMasses "instantiation of objects"
Mass m1;
Mass m2;
end TwoMasses;

model TwoMasses2 "with modifiers"
Mass m1(C=2500, T(start=350));
Mass m2(C=1500,T(start=380));
end TwoMasses2;

model Mass2 "Mass with final parameter C"

parameter Real m=1.5 "mass, in kg";
parameter Real c=1600 "specific capacity, J/kgK";
parameter Real UA=20 "heat transfer coefficient, in W/K";
final parameter Real C = c*m "final prevents modification of this parameter";
Real T(start=200,fixed=false);
parameter Real Ta=300;

equation
C * der(T) + UA * (T-Ta) = 0;

end Mass2;

connector HeatPort_Real

Real T "potential";
flow Real Q_flow "flow variable";

  annotation (Icon);
end HeatPort_Real;

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

model Resistor
HeatPort heatPort_a;
HeatPort heatPort_b;
parameter Modelica.SIunits.ThermalResistance R=1;

equation
heatPort_a.Q_flow = (heatPort_a.T - heatPort_b.T) / R;
heatPort_a.Q_flow + heatPort_b.Q_flow = 0;
end Resistor;

model Capacity
HeatPort heatPort;
parameter Modelica.SIunits.HeatCapacity C=800;
Modelica.SIunits.Temperature T;

equation
T = heatPort.T;
C*der(T) = heatPort.Q_flow;

end Capacity;

model LinkedCapacities
Capacity c1(T(start = 400),C=600);
Capacity c2(T(start = 350),C=1000);
Resistor r(R=3);

equation
connect(c1.heatPort,r.heatPort_a);
connect(c2.heatPort,r.heatPort_b);

/*
connect-statement :
  - potentials are set equal,
  - Kirchoff to "flow" variables
*/

end LinkedCapacities;

model LinkedCapacities2
Capacity c1(T(start = 400),C=600);
Capacity c2(T(start = 350),C=1000);
Capacity c3(T(start = 600),C=400);
Capacity c4(T(start = 200),C=600);
Resistor r1(R=3);
Resistor r2;
Resistor r3;
Resistor r4;

equation
connect(c1.heatPort,r1.heatPort_a);
connect(c2.heatPort,r2.heatPort_a);
connect(c3.heatPort,r3.heatPort_a);
connect(c4.heatPort,r4.heatPort_a);
connect(r1.heatPort_b,r2.heatPort_b);
connect(r3.heatPort_b,r2.heatPort_b);
connect(r4.heatPort_b,r2.heatPort_b);

end LinkedCapacities2;

model Array

parameter Integer n=4;

Capacity[n] c;
Resistor[n] r;

equation
for i in 1:n loop
connect(c[i].heatPort,r[i].heatPort_a);
end for;

for i in 2:n loop
connect(r[1].heatPort_b,r[i].heatPort_b);
end for;

end Array;

model Array_modified

parameter Integer n=4;
parameter Real[n] cvalues={600,1000,400,600};
parameter Real[n] Tstarts={500,350,600,200};
Capacity[n] c(C=cvalues, T(start = Tstarts));
Resistor[n] r;

equation
for i in 1:n loop
connect(c[i].heatPort,r[i].heatPort_a);
end for;

for i in 2:n loop
connect(r[1].heatPort_b,r[i].heatPort_b);
end for;

end Array_modified;

model PrescribedTemp

  input Real T;

    HeatPort heatPort annotation (extent=[90,-10; 110,10]);
equation
  heatPort.T=T;
    annotation (Diagram, Icon(graphics={Text(
            extent={{-32,34},{28,-34}},
            lineColor={0,0,255},
            lineThickness=0.5,
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid,
            textString="T")}));
end PrescribedTemp;

model Array_TSet
parameter Real[4] cvalues={600,1000,400,600};
parameter Real[4] Tstarts={400,350,600,200};
Capacity[4] c(C=cvalues, T(start = Tstarts));
Resistor[4] r;
PrescribedTemp TSet(T=step.y);
Modelica.Blocks.Sources.Step step(height=50,startTime=3000,offset=300);

equation
for i in 1:4 loop
connect(c[i].heatPort,r[i].heatPort_a);
end for;

for i in 2:4 loop
connect(r[1].heatPort_b,r[i].heatPort_b);
end for;

//Tset.T=step.y;
connect(TSet.heatPort,r[1].heatPort_b);

end Array_TSet;

  model Capacity_extended
    extends Capacity;
    /* 
  All declarations, equations etc. from Capacity are literally copied into this model
  They cannot be changed
  */

    Boolean heatLoss(start=false);

  algorithm
    heatLoss :=heatPort.Q_flow < 0;

  end Capacity_extended;

model Array_TSet_CapExtended
parameter Real[4] cvalues={600,1000,400,600};
parameter Real[4] Tstarts={400,350,600,200};
Capacity_extended[4] c(C=cvalues, T(start = Tstarts));
Resistor[4] r;
PrescribedTemp TSet(T=step.y);
Modelica.Blocks.Sources.Step step(height=50,startTime=3000,offset=300);

equation
for i in 1:4 loop
connect(c[i].heatPort,r[i].heatPort_a);
end for;

for i in 2:4 loop
connect(r[1].heatPort_b,r[i].heatPort_b);
end for;

//Tset.T=step.y;
connect(TSet.heatPort,r[1].heatPort_b);

end Array_TSet_CapExtended;

  model Arrays "Arrays instantiated"

  CrashCourseJModelica.Array_TSet_CapExtended array1(step(
                                                   height =    55));
  CrashCourseJModelica.Array_TSet_CapExtended array2(step(
                                                   height =    55, startTime =    2000));

  end Arrays;

partial model PartialCap

HeatPort heatPort;

parameter Modelica.SIunits.HeatCapacity CNom;
Modelica.SIunits.HeatCapacity C;
Modelica.SIunits.Temperature T;

equation
  heatPort.T=T;
  C*der(T)=heatPort.Q_flow;

end PartialCap;

model FixedCap

extends PartialCap;

equation
C=CNom;
end FixedCap;

model PCMCap

  extends PartialCap;

  parameter Modelica.SIunits.HeatCapacity CMax=30000;
  parameter Modelica.SIunits.Temperature TNom=330;

equation
  if T<TNom-5 or T>TNom+5 then
    C=CNom;
  else
    C=CNom+(CMax-CNom)/2+(CMax-CNom)/2*sin(2*Modelica.Constants.pi*(T/(10))+3.1415/2);
  end if;

end PCMCap;

  model Layer

    HeatPort heatPort_a annotation (extent=[-110,-10; -90,10]);
    HeatPort heatPort_b annotation (extent=[92,-8; 112,12]);

    parameter Real R=3;
    parameter Real C=800;

    Resistor r1(R=R/2);
    Resistor r2(R=R/2);
    replaceable FixedCap c(CNom=C, T(start = 273.15)) constrainedby PartialCap(CNom=C)
                                                                 annotation (choicesAllMatching=true);

  equation
    connect(heatPort_a,r1.heatPort_a);
    connect(r1.heatPort_b,c.heatPort);
    connect(r1.heatPort_b,r2.heatPort_a);
    connect(r2.heatPort_b, heatPort_b);

  end Layer;

    model LayerFiniteElement "1 Dimensional finite element layer"

    parameter Integer n=10 "number of elements";
    Resistor[n] r(each R=0.1);
    replaceable FixedCap[n-1] c constrainedby PartialCap;
    HeatPort heatPort_a annotation (extent=[-110,-10; -90,10]);
    HeatPort heatPort_b annotation (extent=[90,-10; 110,10]);

    equation
    connect(heatPort_a,r[1].heatPort_a);
    for i in 1:n-1 loop
      connect(r[i].heatPort_b,c[i].heatPort);
      connect(r[i].heatPort_b,r[i+1].heatPort_a);
    end for;
    connect(r[n].heatPort_b,heatPort_b);
    end LayerFiniteElement;

  model TwoLayers

    PrescribedTemp prescribedTemp_a annotation (extent=[-84,-6; -64,14]);
    PrescribedTemp prescribedTemp_b annotation (extent=[30,-6; 50,14]);

    Layer layer_fix(redeclare CrashCourseJModelica.FixedCap
                                                    c(T(start=500)))
      annotation (extent=[-24,10; -4,30], Placement(transformation(extent={{-6,32},
              {14,52}})));
    Layer layer_pcm(redeclare CrashCourseJModelica.PCMCap
                                                   c(T(start=500)))
      annotation (extent=[-24,-24; -4,-4], Placement(transformation(extent={{-6,-48},
              {14,-28}})));
    Modelica.Blocks.Sources.Step step(
      height=100,
      offset=273,
      startTime=6000) annotation (extent=[-80,60; -60,80]);

  /*simulate 10 000 seconds*/

  equation
    step.y=prescribedTemp_a.T;
    273=prescribedTemp_b.T;

    connect(prescribedTemp_a.heatPort, layer_fix.heatPort_a) annotation (Line(
        points={{-64,4},{-48,4},{-48,42},{-6,42}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(prescribedTemp_a.heatPort, layer_pcm.heatPort_a) annotation (Line(
        points={{-64,4},{-48,4},{-48,-38},{-6,-38}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(layer_fix.heatPort_b, prescribedTemp_b.heatPort) annotation (Line(
        points={{14.2,42.2},{50,42.2},{50,4}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(layer_pcm.heatPort_b, prescribedTemp_b.heatPort) annotation (Line(
        points={{14.2,-37.8},{50,-37.8},{50,4}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(graphics));
  end TwoLayers;

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

  partial model PartialTwoFlowPorts
    "Partial model for a 2 flowport component with conservation of mass"

    FlowPort flowPort_a "inlet, positive flow here means normal flow direction"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    FlowPort flowPort_b
      "outlet, negative flow here means normal flow direction"
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

  model SimplePipe "Fluid pipe , no heatPort"
    extends PartialTwoFlowPorts;

    constant Modelica.SIunits.Density rho_water=999 "fixed density of water";
    constant Modelica.SIunits.SpecificHeatCapacity cp_water=4190
      "fixed cp of water";

    parameter Modelica.SIunits.Length l=1 "length of the pipe";
    parameter Modelica.SIunits.Diameter dia=0.022 "diameter of the pipe";
    final parameter Modelica.SIunits.Mass m=Modelica.Constants.pi*dia^2/4*l*rho_water
      "mass of the water in the pipe";
    parameter Modelica.SIunits.Pressure dpNominal=10000 "nominal pressure drop";
    parameter Modelica.SIunits.VolumeFlowRate V_flowNominal=0.1
      "nominal massflowrate";

    Modelica.SIunits.VolumeFlowRate V_flow "volume flowrate";
    Modelica.SIunits.Pressure dp "pressure drop";

  equation
    flowPort_a.m_flow*cp_water*(flowPort_a.T-flowPort_b.T)=m*der(T)*cp_water;
    dp=0.01*V_flow+dpNominal*(V_flow/V_flowNominal)^2;
    /*
  I have used the very simple turbulent flow quadratic pressure drop but in order to 
  avoid derivitives = 0 round V_flow=0 I added a term that has fixed derivative without
  influencing the result too much.
  */
    flowPort_a.p-flowPort_b.p=dp;
    V_flow=flowPort_a.m_flow/rho_water;

    annotation (Diagram(graphics), Icon(graphics={Rectangle(
            extent={{-94,8},{94,-8}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}));
  end SimplePipe;

  model SimplePump "Pump model withhout heat exchange, fixed pressure increase"
    extends PartialTwoFlowPorts;
    parameter Modelica.SIunits.Pressure dp=10000
      "pressure increase of the pump";

  equation
    flowPort_b.p=flowPort_a.p+dp;
    flowPort_b.T=flowPort_a.T;

    annotation (Icon(graphics={Ellipse(extent={{-56,52},{54,-58}}, lineColor={0,0,
                255}), Polygon(
            points={{-38,36},{-38,-44},{52,0},{-38,36}},
            lineColor={0,0,255},
            lineThickness=0.5,
            smooth=Smooth.None,
            fillPattern=FillPattern.Solid)}));
  end SimplePump;

  model FixedHeatFlow "Fixes the heat flow in a HeatPort connector"

    parameter Modelica.SIunits.HeatFlowRate Q "Heat flowrate";
    HeatPort heatPort
      annotation (Placement(transformation(extent={{84,-10},{104,10}})));

  equation
    heatPort.Q_flow=-Q;
    annotation (Diagram(graphics), Icon(graphics={Text(
            extent={{-52,36},{42,-40}},
            lineColor={0,0,255},
            lineThickness=0.5,
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid,
            textString="Q")}));
  end FixedHeatFlow;

  model FixedPressure "Fixes the absolute pressure in a hydraulic circuit"
    parameter Modelica.SIunits.Pressure p "absolute pressure";

    FlowPort flowPort
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    flowPort.m_flow=0;
    flowPort.p=p;
    annotation (Icon(graphics={Text(
            extent={{-16,22},{16,-18}},
            lineColor={0,0,255},
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid,
            textString="P")}));
  end FixedPressure;

  model FluidCircuitMerger
    "Arranges the singularity that would arise without this component in a hydraulic circuit"

    FlowPort flowPort_a annotation (extent=[-110,-10; -90,10]);
    FlowPort flowPort_b annotation (extent=[90,-10; 110,10]);
  equation
    flowPort_a.T=flowPort_b.T;
    flowPort_a.p=flowPort_b.p;
    annotation (Diagram, Icon(Line(points=[-98,2; -76,32; -50,46; -48,46; -18,52;
              -14,52; 10,54; 12,54; 24,52; 26,52; 36,50; 40,48; 46,46; 56,40; 60,38;
              74,34; 80,30; 86,26; 88,24; 92,20; 94,16; 100,2], style(
            color=3,
            rgbcolor={0,0,255},
            smooth=0,
            fillColor=6,
            rgbfillColor={255,128,0},
            fillPattern=1))));
  end FluidCircuitMerger;

  model PipePump "Tester for pipe and pump"

    PipeWithHeatPort simplePipe
      annotation (Placement(transformation(extent={{-14,26},{6,46}})));
    SimplePump simplePump
      annotation (Placement(transformation(extent={{42,26},{62,46}})));
    FluidCircuitMerger fluidCircuitMerger
      annotation (Placement(transformation(extent={{26,-14},{36,0}})));
    CrashCourseJModelica.FixedPressure prescribedPressure(p=200000)
      annotation (Placement(transformation(extent={{12,52},{32,72}})));
    CrashCourseJModelica.FixedHeatFlow prescribedHeatFlow(Q=100)
      annotation (Placement(transformation(extent={{-48,54},{-28,74}})));
  equation

    connect(simplePipe.flowPort_b, simplePump.flowPort_a) annotation (Line(
        points={{6,36},{42,36}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(simplePump.flowPort_b, fluidCircuitMerger.flowPort_b) annotation (
        Line(
        points={{62,36},{70,36},{70,-7},{36,-7}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(fluidCircuitMerger.flowPort_a, simplePipe.flowPort_a) annotation (
        Line(
        points={{26,-7},{-28,-7},{-28,36},{-14,36}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(prescribedPressure.flowPort, simplePump.flowPort_a) annotation (Line(
        points={{32,62},{42,62},{42,36}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(prescribedHeatFlow.heatPort, simplePipe.heatPort) annotation (Line(
        points={{-28.6,64},{-4,64},{-4,37.6}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(graphics));
  end PipePump;

  model PipeWithHeatPort
    "Fluid pipe with 1 heatport for heat exchange with environment"
    extends PartialTwoFlowPorts;

    constant Modelica.SIunits.Density rho_water=999 "fixed density of water";
    constant Modelica.SIunits.SpecificHeatCapacity cp_water=4190
      "fixed cp of water";

    parameter Modelica.SIunits.Length l=1 "length of the pipe";
    parameter Modelica.SIunits.Diameter dia=0.022 "diameter of the pipe";
    parameter Modelica.SIunits.Mass m=Modelica.Constants.pi*dia^2/4*l*rho_water
      "mass of the water in the pipe";
    parameter Modelica.SIunits.Pressure dpNominal=10000 "nominal pressure drop";
    parameter Modelica.SIunits.VolumeFlowRate V_flowNominal=0.1
      "nominal massflowrate";

    Modelica.SIunits.VolumeFlowRate V_flow "volume flowrate";
    Modelica.SIunits.Pressure dp "pressure drop";

    HeatPort heatPort
      annotation (Placement(transformation(extent={{-10,6},{10,26}})));
  equation
    heatPort.T=T;
    heatPort.Q_flow+flowPort_a.m_flow*cp_water*(flowPort_a.T-flowPort_b.T)=m*der(T)*cp_water;
    dp=0.01*V_flow+dpNominal*(V_flow/V_flowNominal)^2;
    /*
  I have used the very simple turbulent flow quadratic pressure drop but in order to 
  avoid derivitives equal to 0 round V_flow=0 I added a term that has fixed derivative without
  influencing the result too much (is rudimentary linearization around zero).
  */
    flowPort_a.p-flowPort_b.p=dp;
    V_flow=flowPort_a.m_flow/rho_water;

    annotation (Diagram(graphics), Icon(graphics={Rectangle(
            extent={{-94,8},{94,-8}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}));
  end PipeWithHeatPort;

  model FlowBoundary "Fixes pressure, temperature "
  parameter Modelica.SIunits.Temperature T "Boundary temperature";
  parameter Modelica.SIunits.Pressure p "Boundary pressure";

    FlowPort flowPort
      annotation (Placement(transformation(extent={{70,-10},{90,10}})));

  equation
    flowPort.p=p;
    flowPort.T=T;
    annotation (Diagram(graphics), Icon(graphics={Ellipse(
            extent={{-86,80},{76,-78}},
            lineColor={0,0,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid)}));
  end FlowBoundary;

  model FlowBoundary_OnlyPressure "Fixes pressure, temperature "
  parameter Modelica.SIunits.Temperature T "Boundary temperature";
  parameter Modelica.SIunits.Pressure p "Boundary pressure";

    FlowPort flowPort
      annotation (Placement(transformation(extent={{70,-10},{90,10}})));

  equation
    flowPort.p=p;

    annotation (Diagram(graphics), Icon(graphics={Ellipse(
            extent={{-86,80},{76,-78}},
            lineColor={0,0,255},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid)}));
  end FlowBoundary_OnlyPressure;

  model PipeTester "Xtremely basic pipe tester"
    PipeWithHeatPort simplePipe
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FlowBoundary flowBoundary(T=303.15, p=230000)
      annotation (Placement(transformation(extent={{-62,0},{-42,20}})));
    FlowBoundary_OnlyPressure flowBoundary_OnlyPressure(T=303.15, p=210000)
      annotation (Placement(transformation(extent={{10,20},{30,40}})));
    Layer layer
      annotation (Placement(transformation(extent={{-62,54},{-42,74}})));
    PrescribedTemp prescribedTemp
      annotation (Placement(transformation(extent={{-100,54},{-80,74}})));
  equation
    connect(flowBoundary.flowPort, simplePipe.flowPort_a) annotation (Line(
        points={{-44,10},{-20,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(flowBoundary_OnlyPressure.flowPort, simplePipe.flowPort_b)
      annotation (Line(
        points={{28,30},{32,30},{32,28},{34,28},{34,10},{0,10}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(layer.heatPort_b, simplePipe.heatPort) annotation (Line(
        points={{-41.8,64.2},{-10,64.2},{-10,11.6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(prescribedTemp.heatPort, layer.heatPort_a) annotation (Line(
        points={{-80,64},{-62,64}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(graphics));
  end PipeTester;

  model FixedTemperature "Fixes the temperature in a HeatPort"
    parameter Modelica.SIunits.Temperature T "constant temperature";

    HeatPort heatPort
      annotation (Placement(transformation(extent={{88,-10},{108,10}})));

  equation
    heatPort.T=T;
    annotation (Icon(graphics={Text(
            extent={{-46,44},{52,-56}},
            lineColor={0,0,255},
            textString="T")}));
  end FixedTemperature;

  model OnOffHeatFlow "Fixes the heat flow in a HeatPort connector"

    parameter Modelica.SIunits.HeatFlowRate Q "Heat flowrate";
    input Boolean onoff "boolean on off control signal";
    HeatPort heatPort
      annotation (Placement(transformation(extent={{84,-10},{104,10}})));

  equation
    heatPort.Q_flow = if onoff then -Q else 0;
    annotation (Diagram(graphics), Icon(graphics={Text(
            extent={{-52,36},{42,-40}},
            lineColor={0,0,255},
            lineThickness=0.5,
            fillColor={255,128,0},
            fillPattern=FillPattern.Solid,
            textString="Q")}));
  end OnOffHeatFlow;

  model FloorHeating "Model with Pipe connected to layer, Pump and Boiler"
    parameter Modelica.SIunits.HeatCapacity cFloor=80000
      "capacity of the floor";

    PipeWithHeatPort floorHeating(
      l=100,
      V_flowNominal=0.001,
      T(start=293),
      dia=0.030,
      dpNominal=40000)
      annotation (Placement(transformation(extent={{-14,26},{6,46}})));
    SimplePump pump(dp=40000)
      annotation (Placement(transformation(extent={{42,26},{62,46}})));
    FluidCircuitMerger fluidCircuitMerger
      annotation (Placement(transformation(extent={{26,-14},{36,0}})));
    CrashCourseJModelica.FixedPressure prescribedPressure(p=200000)
      annotation (Placement(transformation(extent={{12,52},{32,72}})));
    PipeWithHeatPort boiler(
      dia=0.080,
      T(start=293),
      V_flowNominal=0.001)
      annotation (Placement(transformation(extent={{-22,10},{-42,-10}})));
    Layer layer(R=0.01,    C=cFloor,
      redeclare FixedCap c(CNom=80000, T(start=288.15)))
                annotation (Placement(transformation(extent={{-44,58},{-24,78}})));
    OnOffHeatFlow boilerHeatFlow(       onoff=onoff.y, Q=5000)
      annotation (Placement(transformation(extent={{-72,-28},{-52,-8}})));
    FixedTemperature fixedTemperature(T=296.15)
      annotation (Placement(transformation(extent={{-90,58},{-70,78}})));
    Modelica.Blocks.Logical.OnOffController onoff(bandwidth=1);

    Real deviation(start=0);
    Real deviationInt(start=0);
  equation
    deviation = abs(layer.c.T - (24+273.15));
    der(deviationInt) = deviation;
    onoff.reference=24+273.15;
    onoff.u=layer.c.T;
    //boilerHeatFlow.onoff=onoff.y;
    connect(floorHeating.flowPort_b, pump.flowPort_a)     annotation (Line(
        points={{6,36},{42,36}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(pump.flowPort_b, fluidCircuitMerger.flowPort_b)       annotation (
        Line(
        points={{62,36},{70,36},{70,-7},{36,-7}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(prescribedPressure.flowPort, pump.flowPort_a)       annotation (Line(
        points={{32,62},{42,62},{42,36}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(boiler.flowPort_a, fluidCircuitMerger.flowPort_a)
      annotation (Line(
        points={{-22,0},{4,0},{4,-7},{26,-7}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(boiler.flowPort_b, floorHeating.flowPort_a)         annotation (Line(
        points={{-42,0},{-52,0},{-52,36},{-14,36}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(layer.heatPort_b, floorHeating.heatPort)
                                                   annotation (Line(
        points={{-23.8,68.2},{-4,68.2},{-4,37.6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(boilerHeatFlow.heatPort, boiler.heatPort)           annotation (
        Line(
        points={{-52.6,-18},{-32,-18},{-32,-1.6}},
        color={0,0,255},
        smooth=Smooth.None));
    connect(fixedTemperature.heatPort, layer.heatPort_a) annotation (Line(
        points={{-70.2,68},{-44,68}},
        color={0,0,255},
        smooth=Smooth.None));
    annotation (Diagram(graphics));
  end FloorHeating;
  annotation (uses(Modelica(version="3.2")),
    version="1",
    conversion(noneFromVersion=""));
end CrashCourseJModelica;
