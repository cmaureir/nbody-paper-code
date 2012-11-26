import matplotlib.pyplot as p
from pylab import *

inputs=[16,32,64,128,256,512,1024]
serial=[0.0117635,0.0449909,0.175573,0.708204,2.77872,11.5183,46.6012]
parallel=[0.0893954,0.114531,0.328105,0.458292,1.07187,2.89104,10.4472]

plot1 = p.plot(inputs,serial,label='pb_200_01')
plot2 = p.plot(inputs,parallel,label='pb_200_09')

title('Serial vs Parallel')
legend((plot1,plot2),('serial impl','parallel impl'),loc='upper left')
grid(True)
p.axis([00,1024,0,50],0.01)
xlabel('Number of particles')
ylabel('Time of the implementations [s]')
p.show()
