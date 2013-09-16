within Lib.Connectors.with;
model mass

Modelica.SIunits.Temperature T(start=200) "mass temprature";

parameter Modelica.SIunits.Mass m = 1.5 "mass, in kg";
parameter Modelica.SIunits.SpecificHeatCapacity c = 1600
    "specific capacity, J/kgK";
final parameter Modelica.SIunits.HeatCapacity C = c*m
    "dangerous without 'final' keyword";

  HeatPort heatPort "thermal connector" annotation (Placement(transformation(extent={{52,-10},{72,10}}),
        iconTransformation(extent={{52,-10},{72,10}})));

equation
heatPort.T = T; // define the temperature of the connector = to temperature of the mass
// capacity equation
C * der(T) = heatPort.Q_flow;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Polygon(
          points={{0,58},{-22,64},{-50,48},{-62,10},{-62,6},{-62,-22},{-62,-26},
              {-16,-56},{-14,-58},{20,-64},{26,-66},{62,-56},{62,-46},{62,10},{62,
              20},{64,36},{64,40},{62,62},{48,60},{16,52},{8,54},{0,58}},
          lineColor={0,0,255},
          smooth=Smooth.None), Text(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          textString="m")}));
end mass;
