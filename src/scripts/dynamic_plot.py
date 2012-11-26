from time import sleep
from matplotlib.ticker import NullFormatter
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import matplotlib
matplotlib.use('WXAgg') # do this before importing pylab
import matplotlib.pyplot as plt
from sys import argv

if len(argv) <= 2:
	print("error...")
	print("Use:\n\tplot.py data_file num_particles")
	input()

else:
	data =open(argv[1],"r")

x = []
y = []
z = []

for i in range(int(argv[2])):
	x.append([])
	y.append([])
	z.append([])

for line in data.readlines():
	line = line.replace("\n","").split(" ")[:4]
	line = map(float,line)
	print(line)
	x[int(line[0])].append(line[1])
	y[int(line[0])].append(line[2])
	z[int(line[0])].append(line[3])

# plot

fig = plt.figure()
ax = Axes3D(fig)

x1=[]
for i in range(len(x)):
	x1.append(x[i][0])
y1=[]
for i in range(len(y)):
	y1.append(y[i][0])
z1=[]
for i in range(len(y)):
	z1.append(z[i][0])

ax.set_xlabel('X')
ax.set_xlim3d(-2, 2)
ax.set_ylabel('Y')
ax.set_ylim3d(-2, 2)
ax.set_zlabel('Z')
ax.set_zlim3d(-2, 2)
ax.scatter(x1, y1, z1)

def update_line(idleevent):
    if update_line.i==len(x[0])-1:
        return False
    print(update_line.i)
    plt.cla()

    x1=[]
    for i in range(len(x)):
    	x1.append(x[i][update_line.i+1])
    y1=[]
    for i in range(len(y)):
    	y1.append(y[i][update_line.i+1])
    z1=[]
    for i in range(len(z)):
    	z1.append(z[i][update_line.i+1])

    ax.scatter(x1, y1, z1)

    fig.canvas.draw_idle() 
    update_line.i += 1
update_line.i = 0

import wx
wx.EVT_IDLE(wx.GetApp(), update_line)
plt.show()

