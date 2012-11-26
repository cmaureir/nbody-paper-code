#!/bin/bash
#PBS -l walltime=15:00:00
#PBS -q gpu
#PBS -N test_cuda_th
#PBS -mbea
#PBS -M cmaureir@csrg.inf.utfsm.cl

cd $PBS_O_WORKDIR
cd ../../
rm -f nbody_cuda || echo "error cleaning"
make cuda || echo "error make"

#N=(512 1024 1536 2048 2560 3072 3584 4096 4608 5120)


#for i in ${N[@]};do
#	./nbody_cuda $i input/input$i 32 160
#	./nbody_cuda $i input/input$i 20 256
#	./nbody_cuda $i input/input$i 16 320
#	./nbody_cuda $i input/input$i 10 512
#done

echo "512";
./nbody_cuda 512 input/input512 1 512
./nbody_cuda 512 input/input512 2 256
./nbody_cuda 512 input/input512 4 128
./nbody_cuda 512 input/input512 8 64
./nbody_cuda 512 input/input512 16 32

echo "1024";
./nbody_cuda 1024 input/input1024 2 512
./nbody_cuda 1024 input/input1024 4 256
./nbody_cuda 1024 input/input1024 8 128
./nbody_cuda 1024 input/input1024 16 64
./nbody_cuda 1024 input/input1024 32 32

echo "1536";
./nbody_cuda 1536 input/input1536 3 512
./nbody_cuda 1536 input/input1536 6 256
./nbody_cuda 1536 input/input1536 12 128
./nbody_cuda 1536 input/input1536 24 64
./nbody_cuda 1536 input/input1536 48 32

echo "2048";
./nbody_cuda 2048 input/input2048 4 512
./nbody_cuda 2048 input/input2048 8 256
./nbody_cuda 2048 input/input2048 16 128
./nbody_cuda 2048 input/input2048 32 64
./nbody_cuda 2048 input/input2048 64 32

echo "2560";
./nbody_cuda 2560 input/input2560 5 512
./nbody_cuda 2560 input/input2560 10 256
./nbody_cuda 2560 input/input2560 20 128
./nbody_cuda 2560 input/input2560 40 64
./nbody_cuda 2560 input/input2560 80 32

echo "3072";
./nbody_cuda 3072 input/input3072 6 512
./nbody_cuda 3072 input/input3072 12 256
./nbody_cuda 3072 input/input3072 24 128
./nbody_cuda 3072 input/input3072 48 64
./nbody_cuda 3072 input/input3072 96 32

echo "3584";
./nbody_cuda 3584 input/input3584 7 512
./nbody_cuda 3584 input/input3584 14 256
./nbody_cuda 3584 input/input3584 28 128
./nbody_cuda 3584 input/input3584 56 64
./nbody_cuda 3584 input/input3584 112 32

echo "4096";
./nbody_cuda 4096 input/input4096 8 512
./nbody_cuda 4096 input/input4096 16 256
./nbody_cuda 4096 input/input4096 32 128
./nbody_cuda 4096 input/input4096 64 64
./nbody_cuda 4096 input/input4096 128 32

echo "4608";
./nbody_cuda 4608 input/input4608 9 512
./nbody_cuda 4608 input/input4608 18 256
./nbody_cuda 4608 input/input4608 36 128
./nbody_cuda 4608 input/input4608 72 64
./nbody_cuda 4608 input/input4608 144 32

echo "5120";
./nbody_cuda 5120 input/input5120 10 512
./nbody_cuda 5120 input/input5120 20 256
./nbody_cuda 5120 input/input5120 40 128
./nbody_cuda 5120 input/input5120 80 64
./nbody_cuda 5120 input/input5120 160 32
