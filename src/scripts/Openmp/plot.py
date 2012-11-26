import matplotlib.pyplot as p
from pylab import title,legend,grid,xlabel,ylabel

n=[]
t_s=[]
cores = [2,4,6,8]
#cores = [2,4,6,8,10,12,14,16]

f = open("../Serial/serial.out","r")
for line in f.readlines():
	line = line.replace("\n","").split(" ")
	n.append(int(line[0]))
	t_s.append(float(line[1]))
f.close()

t_p = []
for i in range(len(n)):
	t_p.append([])
d=0
f = open("openmp_final.out","r")
for line in f.readlines():
	line = line.replace("\n","").split(" ")
	if len(line) == 2:
		d=-1
	else:	
		t_p[d].append(t_s[d]/float(line[1]))
	d+=1
f.close()

print(cores)
print(t_s)
for i in t_p:
	print(i)
raw_input()

tmp = [0,1,2,3,4,5,6,7,8]

plot00 = p.plot(tmp,tmp,label="-")
#plot0 = p.plot(cores,t_p[0],label="512")
plot1 = p.plot(cores,t_p[1],'o-',label="1024")
#plot2 = p.plot(cores,t_p[2],label="1536")
#plot3 = p.plot(cores,t_p[3],label="2048")
#plot4 = p.plot(cores,t_p[4],label="2560")
#plot5 = p.plot(cores,t_p[5],label="3072")
#plot6 = p.plot(cores,t_p[6],label="3584")
#plot7 = p.plot(cores,t_p[7],label="4096")
#plot8 = p.plot(cores,t_p[8],label="4608")
plot9 = p.plot(cores,t_p[9],'o-',label="5120")

title(r'$OpenMP\ Implementation$',fontsize=24)
legend(fancybox=True,loc='center left')
grid(True)
#p.axis([00,1024,0,50],0.01)
xlabel(r'$Number\ of\ cores$',fontsize=20)
ylabel(r'$Speedup\ \left(\frac{t_{seq}}{t_{par}}\right)$',fontsize=20)
p.show()

