within ;
package MyLib

  partial connector Pin

    Modelica.SIunits.Voltage v;
    flow Modelica.SIunits.Current i;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Pin;

  connector Pin_a "positive pin"
    extends Pin;


    annotation (Icon(graphics={
          Rectangle(extent={{-38,40},{40,-40}}, lineColor={28,108,200}),
          Line(points={{0,-20},{0,18},{0,20}}, color={28,108,200}),
          Line(points={{20,0},{-20,0}}, color={28,108,200})}));
  end Pin_a;

  connector Pin_b
    extends Pin;
    annotation (Icon(graphics={Rectangle(extent={{-40,40},{40,-40}}, lineColor=
                {28,108,200}), Line(points={{-20,0},{20,0}}, color={28,108,200})}));
  end Pin_b;

  partial model OnePin

    Modelica.SIunits.Voltage v;
    Modelica.SIunits.Current i;


    Pin_a pin_a
      annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));

  equation
    i = pin_a.i;
    v = pin_a.v;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end OnePin;

  partial model TwoPin

    Modelica.SIunits.Voltage v;
    Modelica.SIunits.Current i;

    Pin_a positive     annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
    Pin_b negative    annotation (Placement(transformation(extent={{86,-10},{106,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));

  equation
    v = positive.v - negative.v;
    0 = positive.i + negative.i;
    i = positive.i;

  end TwoPin;

  model Resistor
    extends TwoPin;

    parameter Modelica.SIunits.Resistance R;

  equation

    v = R*i "Ohm's law";

    annotation (Icon(graphics={Line(points={{-92,0},{-40,0},{-20,60},{0,-40},{
                20,60},{40,0},{60,0},{92,0}}, color={28,108,200})}));
  end Resistor;

  model Capacity
    extends TwoPin;

    parameter Modelica.SIunits.Capacitance C;

  equation

    C*der(v) = i;

    annotation (Icon(graphics={
          Line(points={{-20,-60},{-20,60}}, color={28,108,200}),
          Line(points={{20,-60},{20,60}}, color={28,108,200}),
          Line(points={{-92,0},{-20,0}}, color={28,108,200}),
          Line(points={{20,0},{92,0}}, color={28,108,200})}));
  end Capacity;

  model Source
    extends TwoPin;

    parameter Modelica.SIunits.Frequency f;
    parameter Modelica.SIunits.Angle omega;
    parameter Modelica.SIunits.Voltage beta;
    parameter Modelica.SIunits.Voltage U;

  protected
    parameter Real pi = Modelica.Constants.pi;


  equation

    v = U*sin(2*pi*f*time+omega)+beta;

    annotation (Icon(graphics={
          Ellipse(extent={{-40,40},{40,-40}}, lineColor={28,108,200}),
          Line(points={{-92,0},{-40,0}}, color={28,108,200}),
          Line(points={{92,0},{40,0}}, color={28,108,200}),
          Line(points={{-28,-28},{28,28}}, color={28,108,200})}));
  end Source;

  model Diode
    extends TwoPin;

    parameter Modelica.SIunits.Voltage Vt = 0.04;
    parameter Real alfa = 15;
    parameter Modelica.SIunits.Current Ids = 1e-6;
    parameter Modelica.SIunits.Resistance R = 1e8;

  equation

    if v >= Vt*alfa then
      i = Ids*(exp(alfa)*(1+v/Vt-alfa)-1)+v/R;
    else
      i = Ids*(exp(alfa)-1)+v/R;
    end if;


    annotation (Icon(graphics={
          Line(points={{-92,0},{92,0}}, color={28,108,200}),
          Line(points={{40,-38},{40,40}}, color={28,108,200}),
          Line(points={{40,0},{-20,60},{-20,-60},{40,0}}, color={28,108,200})}));
  end Diode;

  model Ground
    extends OnePin;

  equation
    v=0;

    annotation (Icon(graphics={
          Line(points={{-92,0},{20,0}}, color={28,108,200}),
          Line(points={{20,-60},{20,60}}, color={28,108,200}),
          Line(points={{40,-40},{40,40}}, color={28,108,200}),
          Line(points={{60,-40},{60,40}}, color={28,108,200})}));
  end Ground;
end MyLib;
