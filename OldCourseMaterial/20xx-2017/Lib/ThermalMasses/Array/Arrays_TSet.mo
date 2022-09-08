within Lib.ThermalMasses.Array;
model Arrays_TSet "Arrays instantiated"

Array_TSet array1(sine(amplitude=55));
Array_TSet array2(sine(amplitude=55, startTime=2000));

end Arrays_TSet;
