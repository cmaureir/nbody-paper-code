#!/bin/bash
#PBS -l walltime=10:00:00
#PBS -l nodes=1:ppn=1
#PBS -q mpi
#PBS -N test_cpu
#PBS -mbea
#PBS -M cmaureir@csrg.inf.utfsm.cl

cd $PBS_O_WORKDIR
cd ../../
rm -f nbody_serial || echo "error cleaning"
make || echo "error make"

N=(512 1024 1536 2048 2560 3072 3584 4096 4608 5120)

#for i in ${N[@]};do
#	./nbody_serial $i input/input$i
#done

./nbody_serial 1536 input/input1536
