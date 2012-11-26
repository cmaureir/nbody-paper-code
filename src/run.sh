#!/bin/bash
#PBS -l walltime=10:00:00
#PBS -q gpu
#PBS -N test_4096
#PBS -mbea
#PBS -M cmaureir@csrg.inf.utfsm.cl

cd $PBS_O_WORKDIR

SIZE=4096

#while [[ $SIZE -le 4096 ]];do
	echo $SIZE
	#echo "Serial"
	#for i in {1..5};do
	#	time ./nbody_serial $SIZE input/input$SIZE
	#done
	
	echo "OpenMP"
	for i in {1..5};do
		time ./nbody_openmp $SIZE input/input$SIZE
	done
	
	echo "pthreads2"
	for i in {1..5};do
		time ./nbody_pthreads2 $SIZE input/input$SIZE
	done
#	SIZE=$(($SIZE*2))
#done
