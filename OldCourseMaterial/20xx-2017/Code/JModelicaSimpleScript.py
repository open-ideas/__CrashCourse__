# in the ipython console, change the current directory to the path where 
# you have stored this script and your .mo file with eg. this command :
# cd 'C:\myfolder\folder'

import matplotlib.pyplot as plt
import numpy as np

# import the compiler function and FMUModel
from pymodelica import compile_fmu
from pyfmi import load_fmu 

# specify Modelica model and model file
model_name = 'CrashCourseJModelica.FloorHeating'
file_name = 'CrashCourseJModelica.mo'

# compile the model, return argument is the file name of the JMU
fmu_name=compile_fmu(model_name, file_name)
mymodel=load_fmu(fmu_name)

opts=mymodel.simulate_options()
print opts

# Running a few loops
plt.figure()
for c in np.arange(10000, 200000, 50000):
    
    # reset the model (limitation in PyFMI: FMU can only be simulated once)
    mymodel.reset()
    
    # changing a parameter in the model
    mymodel.set('layer.c.CNom', c)
    
    # simulation
    res_file = 'result_' + str(c) + '.txt'
    opts['result_file_name'] = res_file
    res=mymodel.simulate(final_time=40000, options = opts)
    

    # Getting and plotting some results
    T = res['layer.c.T']
    time=res['time']

    plt.plot(time,T, label='C={}'.format(c))
    plt.legend(loc='lower right')

plt.show()

