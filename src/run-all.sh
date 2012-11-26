#!/bin/bash
#PBS -l walltime=15:00:00
#PBS -q gpu
#PBS -N test_4096
#PBS -mbea
#PBS -M cmaureir@csrg.inf.utfsm.cl

cd $PBS_O_WORKDIR

SIZE=4096

while [[ $SIZE -le 4096 ]];do
	echo $SIZE
#	echo "Serial"
#	for i in {1..5};do
#			time ./nbody_serial $SIZE input/input$SIZE 1
#	done
	
	echo "OpenMP"
	for i in 10 12 14 16;do
		echo "Cores: $i"
		for j in {1..2};do
			time ./nbody_openmp $SIZE input/input$SIZE $i
		done
	done
	
	echo "pthreads2"
	for i in 1 2 4 6 8 10 12 14 16;do
		echo "Cores: $i"
		for j in {1..2};do
			time ./nbody_pthreads2 $SIZE input/input$SIZE $i
		done
	done
	SIZE=$(($SIZE*2))
done
