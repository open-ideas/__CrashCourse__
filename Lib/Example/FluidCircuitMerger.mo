within CrashCourse.Example;
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
