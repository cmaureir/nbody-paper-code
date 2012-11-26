#!/bin/bash
#PBS -l walltime=10:00:00
#PBS -q gpu
#PBS -N openmp_8
#PBS -mbea
#PBS -M cmaureir@csrg.inf.utfsm.cl

cd $PBS_O_WORKDIR
cd ../../
rm -f nbody_parallel || echo "error cleaning"
make || echo "error make"

N=(512 1024 1536 2048 2560 3072 3584 4096 4608 5120)

echo "8 cores";

for i in ${N[@]};do
	echo $i;
	./nbody_parallel $i input/input$i
done
