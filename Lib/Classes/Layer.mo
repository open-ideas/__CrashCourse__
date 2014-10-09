within Lib.Classes;
model Layer "Layer of material composed of a capacity and two resistances"

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_a annotation (extent=[-110,-10; -90,10]);
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort_b annotation (extent=[92,-8; 112,12]);

  parameter Real R=3;
  parameter Real C=800;

  Lib.ThermalMasses.ClassesAndConnectors.Resistor r1(R=R/2);
  Lib.ThermalMasses.ClassesAndConnectors.Resistor r2(R=R/2);
    // replaceable variable: all the extension of partialCap can be chosen instead of FixedCap (Notice use of "constrainebby")
  replaceable Lib.Classes.FixedMass c(CNom=C, T(start=273.15)) constrainedby
    PartialMass(CNom=C) annotation (Placement(transformation(extent={{-14,-6},{6,14}})),choicesAllMatching=true);

equation
    connect(heatPort_a,r1.heatPort_a);
    connect(r1.heatPort_b,c.heatPort);
    connect(r1.heatPort_b,r2.heatPort_a);
    connect(r2.heatPort_b, heatPort_b);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Layer;
