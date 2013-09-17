within Lib.Example;
model SimplePump "Pump model withhout heat exchange, fixed pressure increase"
  extends PartialTwoFlowPorts;
  parameter Modelica.SIunits.Pressure dp=10000 "pressure increase of the pump";

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
