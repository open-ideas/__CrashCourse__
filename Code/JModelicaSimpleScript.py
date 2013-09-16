# in the ipython console, change the current directory to the path where 
# you have stored this script and your .mo file with eg. this command :
# cd 'C:\myfolder\folder'

import matplotlib.pyplot as plt

# import the compiler function and FMUModel
from jmodelica.fmi import compile_fmu
from jmodelica.fmi import FMUModel

# specify Modelica model and model file
model_name = 'CrashCourse_Dymola.FloorHeating'
#mo_file = 'JModelica_Crashcourse.mo'
mo_file = 'CrashCourse_Dymola.mo'
# compile the model, return argument is the file name of the JMU
fmu_name=compile_fmu(model_name, mo_file)
mymodel=FMUModel(fmu_name)

# changing a parameter in the model
# mymodel.set('c1.C',2000)

# simulation
res=mymodel.simulate(final_time=40000)


# Getting and plotting some results
T1=res['layer.c.T']
T2=res['boiler.T']
time=res['time']

plt.figure()
plt.plot(time,T1,time,T2)
plt.legend(('T1','T2'))
plt.show()

