import matplotlib.pyplot as p
from pylab import title,legend,grid,xlabel,ylabel

n=[]
t_c=[]
t_s=[]

f = open("../Serial/serial.out","r")
for line in f.readlines():
	line = line.replace("\n","").split(" ")
	n.append(int(line[0]))
	t_s.append(float(line[1]))
f.close()

f = open("test_cuda_th.o280560","r")
for line in f.readlines():
	line = line.replace("\n","").split(" ")
	if len(line) == 1:
		d=-1
#		n.append(int(line[0]))
	elif d == 4:
		t_c.append(float(line[2]))
	d+=1
f.close()

t=[]

for i in range(len(t_c)):
	t.append((t_s[i]/t_c[i]))

plot0 = p.plot(n,t,'o-',label=r'$\Psi(\delta,N)$')

title(r'$CUDA\ Implementation$',fontsize=24)
legend(fancybox=True,loc='center right')
grid(True)
#p.axis([00,1024,0,50],0.01)
xlabel(r'$Number\ of\ particles$',fontsize=20)
ylabel(r'$Acceleration\ factor\ \left(\Psi\right)$',fontsize=20)
p.show()

