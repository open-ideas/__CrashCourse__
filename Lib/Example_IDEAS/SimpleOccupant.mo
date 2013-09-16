within CrashCourse.Example_IDEAS;
model SimpleOccupant "Simple office occupant"
  extends IDEAS.Interfaces.BaseClasses.Occupant(
                                    nLoads=1);

equation
wattsLawPlug.P[1] = 0;
wattsLawPlug.Q[1] = 0;
for i in 1:nZones loop
  heatPortCon[i].Q_flow =  0;
  heatPortRad[i].Q_flow =  0;
  TSet[i] =  290.15;
end for;
mDHW60C = 0;

  annotation (Diagram(graphics));
end SimpleOccupant;
