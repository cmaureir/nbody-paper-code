from sys import argv,exit
from os import popen
from random import uniform,random,randint

if len(argv) < 2:
	print("error")
	exit()

size = argv[1]

ls = popen("ls ../input/* | grep "+size)
n_files = 0
while 1:
	f = ls.readline()
	if not f: break
	n_files += 1

if n_files == 0:
	output_file = "input"+size
else:
	output_file = "input"+size+"-"+str(n_files+1)
	
outfile = open("../input/"+output_file,"w")
	
# -1 mass x y z vx vy vz
mass = str(random())[:5]

for i in range(int(size)):
	line = "-1 "+mass+" "
	for i in range(6):
		line = line+str(uniform(-1,1))+str(randint(100000,999999))+" "
	line = line + "\n"
	outfile.write(line)

outfile.close()
print("Created file: \"../input/"+output_file+"\"")
