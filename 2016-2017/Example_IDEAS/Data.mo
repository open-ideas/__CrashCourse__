within Example_IDEAS;
package Data
  extends Modelica.Icons.MaterialPropertiesPackage;
  package Materials
    extends Modelica.Icons.MaterialPropertiesPackage;

    record Brick =   IDEAS.Buildings.Data.Interfaces.Material (
        k=1.10,
        c=840,
        rho=1850,
        epsLw=0.88,
        epsSw=0.55) "High density brick";
    record Plaster = IDEAS.Buildings.Data.Interfaces.Material (
        d=0.02,
        k=0.6,
        c=840,
        rho=975,
        epsLw=0.85,
        epsSw=0.65) "Plaster";
    record Concrete =  IDEAS.Buildings.Data.Interfaces.Material (
        k=1.7,
        c=840,
        rho=2400,
        epsLw=0.88,
        epsSw=0.55) "Concrete";
    record Tile = IDEAS.Buildings.Data.Interfaces.Material (
        d=0.01,
        k=1.4,
        c=840,
        rho=2100,
        epsLw=0.88,
        epsSw=0.55) "Tiles for floor finishing";
    record Screed = IDEAS.Buildings.Data.Interfaces.Material (
        k=0.6,
        c=860,
        rho=1100,
        epsLw=0.88,
        epsSw=0.55) "Light cast concrete";

    record MineralWool = IDEAS.Buildings.Data.Interfaces.Insulation (
      k=0.036,
      c=840,
      rho=1850,
      epsLw=0.8,
      epsSw=0.8) "Mineral wool";

    record Glazing =
                  IDEAS.Buildings.Data.Interfaces.Glazing (
        nLay=3,
        mats={IDEAS.Buildings.Data.Materials.Glass(
                              d=0.004),IDEAS.Buildings.Data.Materials.Air(
                                                     d=0.015, epsLw_a=0.04),
            IDEAS.Buildings.Data.Materials.Glass(
                            d=0.004, epsLw=0.04)},
        SwTrans=[0, 0.521; 10, 0.524; 20, 0.517; 30, 0.508; 40, 0.495; 50, 0.472;
            60, 0.418; 70, 0.312; 80, 0.153; 90, 0.000],
        SwAbs=[0, 0.102, 0.0, 0.022; 10, 0.104, 0.0, 0.022; 20, 0.112, 0.0, 0.023;
            30, 0.117, 0.0, 0.023; 40, 0.119, 0.0, 0.025; 50, 0.123, 0.0, 0.026; 60,
            0.135, 0.0, 0.027; 70, 0.142, 0.0, 0.029; 80, 0.105, 0.0, 0.031; 90,
            0.000, 0.0, 0.000],
        SwTransDif=0.418,
        SwAbsDif={0.135,0.0,0.027},
        U_value=1.4,
        g_value=0.755)
      "Saint Gobain ClimaPlus Futur AR 1.4 4/15/4 (U = 1.4 W/m2K, g = 0.755)";
      record Frame =     IDEAS.Buildings.Data.Interfaces.Frame (U_value=2.5)
      "Frame with U-value of 2.5 W/m2K";

  end Materials;

  package Constructions
    extends Modelica.Icons.MaterialPropertiesPackage;

    record ExtWall "Exterior wall "
      extends IDEAS.Buildings.Data.Interfaces.Construction(nLay=4, mats={
             Data.Materials.Brick(d=0.10),
             Data.Materials.MineralWool(d=0.16),
             Data.Materials.Brick(d=0.14),
             Data.Materials.Plaster(d=0.02)});
    end ExtWall;

    record IntWall "Internal wall "
      extends IDEAS.Buildings.Data.Interfaces.Construction(nLay=3, mats={
             Data.Materials.Plaster(d=0.02),
             Data.Materials.Brick(d=0.10),
             Data.Materials.Plaster(d=0.02)});
    end IntWall;

    record IntFloorHeaFh "Int. concrete floor, insulated for floor heating"

      extends IDEAS.Buildings.Data.Interfaces.Construction(
        nLay=5, locGain={2},
        mats={Data.Materials.Tile(d=0.01),
        Data.Materials.Screed(d=0.06),
        IDEAS.Buildings.Data.Insulation.Pur(d=0.06),
        Data.Materials.Concrete(d=0.20),
        Data.Materials.Plaster(d=0.02)});

    end IntFloorHeaFh;
  end Constructions;

end Data;
