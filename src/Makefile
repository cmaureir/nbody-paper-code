SRC=nbody_leap
# NVCC = nvcc
CC=g++
#CC=icc
CXXFLAGS=-fopenmp -pg -Wall
#CXXFLAGS=-openmp -Wall
PTHFLAGS=-lpthread
# CUFLAGS = --gpu-architecture sm_13 #--device-emulation

# CUDA = /opt/cuda

# CUDAHEADERS = $(CUDA)/include
# INCLUDEFLAGS = -I $(CUDAHEADERS)
# LDFLAGS += -L$(CUDA)/lib64 -L$(CUDA)/lib
# LDFLAGS += -lm -lgomp -lcudarti

all: nbody_serial nbody_openmp nbody_pthreads2

cuda: nbody_cuda

nbody_serial: $(SRC)_serial.cpp
	$(CC) $(CXXFLAGS)  $< -o $@

nbody_openmp: $(SRC)_openmp.cpp
	$(CC) $(CXXFLAGS)  $< -o $@

nbody_pthreads2: $(SRC)_pthreads2.cpp
	$(CC) $(CXXFLAGS) $(PTHFLAGS)  $< -o $@

# nbody_cuda: $(SRC)_cuda.cu
# 	$(NVCC) $(CUFLAGS) $(INCLUDEFLAGS) $< -o $@
	
clean:
	@rm -rf nbody_openmp nbody_pthreads2 nbody_serial nbody_cuda

.PHONY: all clean
