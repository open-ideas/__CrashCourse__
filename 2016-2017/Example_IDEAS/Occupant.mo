within Example_IDEAS;
model Occupant
  extends IDEAS.Templates.Interfaces.BaseClasses.Occupant(nZones=2, nLoads=1);

  parameter Modelica.SIunits.Area[nZones]  AZones={11.88,11.88}
    "Floor area of different zones";

protected
  final parameter Modelica.SIunits.Time interval=3600 "Time interval";
  final parameter Modelica.SIunits.Time period=86400/interval
    "Number of intervals per repetition";
  final parameter Real[2] Qgain(unit="W/m2") = {20,2}
    "Specific gains during working hours and unoccupied hours";
  Integer t "Time interval";

algorithm
  //calculates the hour of the day
  when sample(0, interval) then
    t := if pre(t) + 1 <= period then pre(t) + 1 else 1;
  end when;

equation

  mDHW60C = 0;
  heatPortRad.Q_flow = heatPortCon.Q_flow; //50% convective & 50% radiative gains
  P[1] = heatPortCon[1].Q_flow + heatPortRad[1].Q_flow;
  Q[1] = 0;

  if noEvent(t > 7 and t <= 17) then
    heatPortCon.Q_flow = -AZones*Qgain[1]*0.5;
    TSet = ones(nZones)*(21 + 273.15);
  else
    heatPortCon.Q_flow = -AZones*Qgain[2]*0.5;
    TSet = ones(nZones)*(15 + 273.15);
  end if;

  annotation (Diagram(graphics));
end Occupant;
