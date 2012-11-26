import matplotlib.pyplot as p
from pylab import title,legend,grid,xlabel,ylabel


t_files = ["test1024-2-512",
		   "test1024-4-256",
		   "test1024-8-128",
		   "test1024-16-64",
		   "test1024-32-32"]

ite = [i+1 for i in range(50)]
data = []

for i in range(len(t_files)):
	data.append([])
index = 0

for i in t_files:
	f = open(i,"r")
	for line in f.readlines():
		line = line.replace("\n","").replace(" ","")
		line = float(line)
		data[index].append(line)
	f.close()
	index +=1


plot1 = p.plot(ite,data[0],label='2 ')
plot2 = p.plot(ite,data[1],label='4 ')
plot3 = p.plot(ite,data[2],label='8 ')
plot4 = p.plot(ite,data[3],label='16')
plot5 = p.plot(ite,data[4],label='32')

title('...')
legend(
	(plot1,plot2,plot3,plot4,plot5),
	('b = 2  ; tpb = 512',
	 'b = 4  ; tpb = 256',
	 'b = 8  ; tpb = 128',
	 'b = 16 ; tpb = 64',
	 'b = 32 ; tpb = 32'),
	loc='center right')
grid(True)
#p.axis([00,1024,0,50],0.01)
xlabel('Iterations')
ylabel('Time [s]')
p.show()

