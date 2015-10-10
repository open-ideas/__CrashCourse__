within Lib.Example_IDEAS;
package ElectricalGridModel "Electrical grid model"
  model Linear3P "Linear single-line grid for 3-phase situation"

  // Input parameters //////////////////////////////////////////////////////////////////////////////////////////////
    parameter Integer nLoads = 33 "Number of buildings attached to the feeder";
    parameter Modelica.SIunits.Length[nLines] length = ones(nLoads)*24
      "Length of all (nLoads+1) cables";
    replaceable parameter IDEAS.Electric.Data.Interfaces.Cable cable annotation (choicesAllMatching=true);

    final parameter Integer nLines = nLoads;

    final parameter Modelica.SIunits.Resistance[3,nLines] R3 = {cable.RCha.*length for i in 1:3};
    final parameter Modelica.SIunits.Reactance[3,nLines] X3 = {cable.XCha.*length for i in 1:3};

  // Output variables //////////////////////////////////////////////////////////////////////////////////////////////
    Modelica.SIunits.ReactivePower QGriTot = Modelica.ComplexMath.imag(TraPin.v*Modelica.ComplexMath.conj(TraPin.i))
      "Reactive transformer load";
    Modelica.SIunits.ActivePower PGriTot = Modelica.ComplexMath.real(TraPin.v*Modelica.ComplexMath.conj(TraPin.i))
      "Active transformer load";
    Modelica.SIunits.ActivePower PLosBra[3,nLines] = line.Plos
      "Resistive losses in each line";
    Modelica.SIunits.ActivePower PGriLosTot = sum(PLosBra)
      "Total resistive loss in the feeder";
    Modelica.SIunits.Voltage VMax = max(Modelica.ComplexMath.'abs'(node.v))
      "Maximum momentaneous nodal voltage";
    Modelica.SIunits.Voltage VMin = min(Modelica.ComplexMath.'abs'(node.v))
      "Minimum momentaneous nodal voltage";
    Modelica.SIunits.Current IMax = max(abs(Modelica.ComplexMath.'abs'(line.i)))
      "Maximum montaneours line current";

  protected
     Modelica.SIunits.Voltage[nLoads] vmax "Maximum nodal voltages";
     Modelica.SIunits.Voltage[nLoads] vmin "Minimum nodal voltages";

  // Connection variables //////////////////////////////////////////////////////////////////////////////////////////
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin TraPin[3]
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin TraGnd
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin[3, nLoads] node
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  // Protected variables ///////////////////////////////////////////////////////////////////////////////////////////
  protected
    IDEAS.Electric.Distribution.AC.BaseClasses.Branch[3,nLines] line(R=R3, X=X3)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    IDEAS.Electric.Distribution.AC.BaseClasses.Branch[nLines] neutral(R=cable.RCha
           .* length, X=cable.XCha .* length)
      annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
    IDEAS.Electric.BaseClasses.AC.Con3PlusNTo3[
                                            nLoads] con3PlusNTo3
      annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  equation

      for k in 1:nLoads loop
      vmax[k] = max(max(Modelica.ComplexMath.'abs'(node[1,k].v),Modelica.ComplexMath.'abs'(node[2,k].v)),Modelica.ComplexMath.'abs'(node[3,k].v));
      vmin[k] = min(min(Modelica.ComplexMath.'abs'(node[1,k].v),Modelica.ComplexMath.'abs'(node[2,k].v)),Modelica.ComplexMath.'abs'(node[3,k].v));
    end for;

    connect(line[:,1].pin_p,TraPin) annotation (Line(
        points={{-10,0},{-100,0}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(neutral[1].pin_p,TraGnd) annotation (Line(
        points={{-10,-20},{-56,-20},{-56,-40},{-100,-40}},
        color={85,170,255},
        smooth=Smooth.None));

    for i in 1:nLines loop
      connect(line[:,i].pin_n,con3PlusNTo3[i].fourWire[1:3]) annotation (Line(
        points={{10,0},{58,0},{58,0},{66,0},{66,0.25}},
        color={85,170,255},
        smooth=Smooth.None));
      connect(neutral[i].pin_n,con3PlusNTo3[i].fourWire[4]) annotation (Line(
        points={{10,-20},{56,-20},{56,0.75},{66,0.75}},
        color={85,170,255},
        smooth=Smooth.None));
      connect(con3PlusNTo3[i].threeWire,node[:,i]) annotation (Line(
        points={{86,0},{100,0}},
        color={85,170,255},
        smooth=Smooth.None));
    end for;

    for j in 1:nLines-1 loop
      connect(line[:,j].pin_n,line[1:3,j+1].pin_p) annotation (Line(
        points={{10,0},{30,0},{30,10},{-30,10},{-30,0},{-10,0}},
        color={85,170,255},
        smooth=Smooth.None));
      connect(neutral[j].pin_n,neutral[j+1].pin_p) annotation (Line(
        points={{10,-20},{32,-20},{32,-28},{-30,-28},{-30,-20},{-10,-20}},
        color={85,170,255},
        smooth=Smooth.None));
    end for;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                        graphics), Icon(graphics={
          Line(
            points={{-22,36},{30,2},{100,0}},
            color={85,170,255},
            smooth=Smooth.Bezier),
          Line(
            points={{30,36},{54,18},{100,4}},
            color={85,170,255},
            smooth=Smooth.Bezier),
          Polygon(
            points={{-32,40},{-32,34},{-4,34},{-4,-80},{4,-80},{4,34},{34,34},{34,
                40},{4,40},{4,46},{-4,46},{-4,40},{-32,40}},
            lineColor={95,95,95},
            smooth=Smooth.None,
            fillPattern=FillPattern.Solid,
            fillColor={95,95,95}),
          Line(
            points={{-102,4},{-46,12},{-28,36}},
            color={85,170,255},
            smooth=Smooth.Bezier),
          Line(
            points={{-100,0},{-12,12},{30,36}},
            color={85,170,255},
            smooth=Smooth.Bezier)}));
  end Linear3P;

  model Feeder "Example of feeder model"

      parameter Integer nBui=10 "number of buildings";

      Modelica.SIunits.Power PGriTot=feeder.PGriTot "Active transformer load";
      Modelica.SIunits.ActivePower PGriLosTot = feeder.PGriLosTot
      "Total resistive loss in the feeder";
      Modelica.SIunits.Voltage Vmin=feeder.VMin
      "Minimum momentaneous nodal voltage";
      Modelica.SIunits.Voltage Vmax=feeder.VMax
      "Maximum momentaneous nodal voltage";
      Modelica.SIunits.Current IMax = feeder.IMax
      "Maximum montaneours line current";

  // Climate ////////////////////////////////////////////////////////////////////////////////////////////////////////

  //public
    inner IDEAS.SimInfoManager sim
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    inner IDEAS.Occupants.Extern.StrobeInfoManager strobe(
      StROBe=false,
      FilNam_PPv="pv_profiles.txt",
      nPv=19,
      FilNam_P="P.txt",
      P_nominal=254,
      nOcc=100,
      StROBe_P=true,
      final PPv=false)
       annotation (Placement(transformation(extent={{-86,80},{-66,100}})));

    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{80,80},{100,100}})));

  // Grid ////////////////////////////////////////////////////////////////////////////////////////////////////////
  protected
    final parameter Modelica.SIunits.ComplexVoltage VSource=(230*1) + 0*Modelica.ComplexMath.j
      "Voltage at node 1";
    final parameter Integer Phases = 1 "Number of phases simulated";
    final parameter Real gridFreq = 50 "Grid frequency";
    Feeders.Linear3P feeder(
      nLoads=nBui,
      length={7,7,14,78,15,6,23,3,9,10},
      redeclare IDEAS.Electric.Data.Cables.PvcAl150 cable) "LV feeder"
      annotation (Placement(transformation(extent={{78,-8},{62,8}})));
    IDEAS.Electric.Distribution.AC.Components.MvLvTransformer_3P transformer_MvLv( redeclare
        IDEAS.Electric.Data.TransformerImp.Transfo_250kVA   transformer)
      annotation (Placement(transformation(extent={{104,-16},{84,4}})));

  // Dwellings ////////////////////////////////////////////////////////////////////////////////////////////////////////
  public
     Lib.Example_IDEAS.Office bui_1(standAlone=false)
      annotation (Placement(transformation(extent={{-78,62},{-62,78}})));
     Lib.Example_IDEAS.Office bui_2(standAlone=false)
      annotation (Placement(transformation(extent={{-58,62},{-42,78}})));
     Lib.Example_IDEAS.Office bui_3(standAlone=false)
      annotation (Placement(transformation(extent={{-38,62},{-22,78}})));
     Lib.Example_IDEAS.Office bui_4(standAlone=false)
      annotation (Placement(transformation(extent={{-18,62},{-2,78}})));
     Lib.Example_IDEAS.Office bui_5(standAlone=false)
       annotation (Placement(transformation(extent={{2,62},{18,78}})));
     Lib.Example_IDEAS.Office bui_6(standAlone=false)
       annotation (Placement(transformation(extent={{22,62},{38,78}})));
     Lib.Example_IDEAS.Office bui_7(standAlone=false)
       annotation (Placement(transformation(extent={{42,62},{58,78}})));
     Lib.Example_IDEAS.Office bui_8(standAlone=false)
      annotation (Placement(transformation(extent={{-78,42},{-62,58}})));
     Lib.Example_IDEAS.Office bui_9(standAlone=false)
      annotation (Placement(transformation(extent={{-58,42},{-42,58}})));
     Lib.Example_IDEAS.Office bui_10(standAlone=false)
      annotation (Placement(transformation(extent={{-38,42},{-22,58}})));

  equation
    connect(bui_1.plugFeeder, feeder.node[1, 1]) annotation (Line(
        points={{-62,68.4},{-60,68.4},{-60,-0.533333},{62,-0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_2.plugFeeder, feeder.node[2, 2]) annotation (Line(
        points={{-42,68.4},{-40,68.4},{-40,0},{62,0}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_3.plugFeeder, feeder.node[3, 3]) annotation (Line(
        points={{-22,70},{-20,70},{-20,0.533333},{62,0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_4.plugFeeder, feeder.node[1, 4]) annotation (Line(
        points={{-2,68.4},{0,68.4},{0,-0.533333},{62,-0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_5.plugFeeder, feeder.node[2, 5]) annotation (Line(
        points={{18,68.4},{20,68.4},{20,0},{62,0}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_6.plugFeeder, feeder.node[3, 6]) annotation (Line(
        points={{38,68.4},{40,68.4},{40,0.533333},{62,0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_7.plugFeeder, feeder.node[1, 7]) annotation (Line(
        points={{58,68.4},{60,68.4},{60,0},{62,0},{62,-0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_8.plugFeeder, feeder.node[2, 8]) annotation (Line(
        points={{-62,50},{-60,50},{-60,0},{62,0}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_9.plugFeeder, feeder.node[3, 9]) annotation (Line(
        points={{-42,48.4},{-40,48.4},{-40,0.533333},{62,0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(bui_10.plugFeeder, feeder.node[1, 10]) annotation (Line(
        points={{-22,48.4},{-20,48.4},{-20,-0.533333},{62,-0.533333}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(feeder.TraGnd, transformer_MvLv.pin_lv_n) annotation (Line(
        points={{78,-3.2},{82,-3.2},{82,-12},{84,-12}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(transformer_MvLv.pin_lv_p, feeder.TraPin) annotation (Line(
        points={{84,0},{78,0}},
        color={85,170,255},
        smooth=Smooth.None));

    connect(feeder.TraGnd, transformer_MvLv.pin_lv_n) annotation (Line(
        points={{78,-3.2},{82,-3.2},{82,-12},{84,-12}},
        color={85,170,255},
        smooth=Smooth.None));
    connect(transformer_MvLv.pin_lv_p, feeder.TraPin) annotation (Line(
        points={{84,0},{78,0}},
        color={85,170,255},
        smooth=Smooth.None));

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                        graphics),
      experiment(
        StopTime=3.1536e+007,
        Interval=900,
        __Dymola_Algorithm="Dassl"),
      __Dymola_experimentSetupOutput(derivatives=false));
  end Feeder;
end ElectricalGridModel;
