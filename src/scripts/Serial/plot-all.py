import matplotlib.pyplot as p
from pylab import title,legend,grid,xlabel,ylabel

n=[]
f = open("serial.out","r")
for line in f.readlines():
	line = line.replace("\n","").split(" ")
	n.append(int(line[0]))
f.close()

serial=[14.6992, 58.6611, 131.717, 234.119, 365.722, 526.936, 716.619, 936.014, 1184.53, 1462.52]
cuda=[3.10652,6.95458,12.1478,21.1089,32.2147,46.1879,63.984,80.3663,102.018,124.541]
openmp=[3.65904,14.3325,31.971,56.5876,88.3514,126.9,172.634,225.545,279.299,351.846]

print(serial)
print(openmp)
print(cuda)

plot1 = p.plot(n,serial,'o-',label='Serial')
plot2 = p.plot(n,openmp,'o-',label='OpenMP')
plot3 = p.plot(n,cuda,'o-',label='CUDA')

title(r'$Implementations$',fontsize=24)
legend(fancybox=True,loc='center left')
grid(True)
#p.axis([00,1024,0,50],0.01)
xlabel(r'$Number\ of\ particles$',fontsize=20)
ylabel(r'$Time\ [s]$',fontsize=20)
p.show()

