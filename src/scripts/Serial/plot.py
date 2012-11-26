import matplotlib.pyplot as p
from pylab import title,legend,grid,xlabel,ylabel

n=[]
t=[]


f = open("serial.out","r")
for line in f.readlines():
	line = line.replace("\n","").split(" ")
	n.append(int(line[0]))
	t.append(float(line[1]))
f.close()

plot1 = p.plot(n,t,'o-',label='Serial')

title(r'$Serial\ Implementation$',fontsize=24)
#legend(fancybox=True,loc='center left')
grid(True)
#p.axis([00,1024,0,50],0.01)
xlabel(r'$Number\ of\ particles$',fontsize=20)
ylabel(r'$Time\ [s]$',fontsize=20)
p.show()

