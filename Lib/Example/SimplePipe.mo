within Lib.Example;
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
