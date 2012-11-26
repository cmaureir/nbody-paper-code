#ifndef nbody_H
#define nbody_H

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <iostream>
#include <iomanip>
#include <sys/sysinfo.h> 
#include <omp.h>
#include <pthread.h>
using namespace std;

int n;
float dt = 0.001;
float ite = 1.0;

struct Thread {
	int id;
	pthread_t thread;
	int ini;
	int end;
};

struct particle {
	float x, y, z;
	float m;
	float vx, vy, vz;
	float ax, ay, az;
	float ax0, ay0, az0;
};

particle *bodies = NULL;
Thread *threads = NULL;
//pthread_mutex_t lock;
int blockNum;
int threadsPerBlock;
int cores = get_nprocs();
float time_tot_start, time_tot_end;

void initPopulation(bool read, const char filename[50]);
void print();
void print_particle(int i);
void print_file();
#endif
