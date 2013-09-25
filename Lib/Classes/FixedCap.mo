within Lib.Classes;
model FixedCap
               // extension of PartialCap

    extends Classes.PartialCap;

equation
    C = CNom;
end FixedCap;
