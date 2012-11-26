#!/bin/bash
#PBS -l walltime=2:00:00
#PBS -q gpu
#PBS -N test_nbody_cuda
#PBS -mbea
#PBS -M cmaureir@csrg.inf.utfsm.cl

cd $PBS_O_WORKDIR

for i in `seq 1 50`;do
	.././nbody_cuda 1024 ../input/input1024 2 512
done

for i in `seq 1 50`;do
	.././nbody_cuda 1024 ../input/input1024 4 256
done

for i in `seq 1 50`;do
.././nbody_cuda 1024 ../input/input1024 8 128
done

for i in `seq 1 50`;do
.././nbody_cuda 1024 ../input/input1024 16 64
done

for i in `seq 1 50`;do
.././nbody_cuda 1024 ../input/input1024 32 32
done


