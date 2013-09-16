within Lib.Example_IDEAS;
model IntFloHeaFh "Int. concrete floor, insulated for floor heating"

  extends IDEAS.Buildings.Data.Interfaces.Construction(
    nLay=5, locGain=2,
    mats={IDEAS.Buildings.Data.Materials.Tile(d=0.012), IDEAS.Buildings.Data.Materials.Screed(d=0.14), IDEAS.Buildings.Data.Insulation.Pur(d=0.06), IDEAS.Buildings.Data.Materials.Concrete(d=0.20), IDEAS.Buildings.Data.Materials.Gypsum(d=0.012)});

end IntFloHeaFh;
