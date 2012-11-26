#include "include/nbody.cpp"

__device__ void update_positions(particle *d_bodies,float dt,int n){

	int i = threadIdx.x + blockDim.x * blockIdx.x;

	if(i < n){
		d_bodies[i].ax0 = d_bodies[i].ax;
		d_bodies[i].ay0 = d_bodies[i].ay;
		d_bodies[i].az0 = d_bodies[i].az;
	
		d_bodies[i].x +=  dt*d_bodies[i].vx + 0.5*dt*dt*d_bodies[i].ax0; 
		d_bodies[i].y +=  dt*d_bodies[i].vy + 0.5*dt*dt*d_bodies[i].ay0;
		d_bodies[i].z +=  dt*d_bodies[i].vz + 0.5*dt*dt*d_bodies[i].az0;
	}
}

__device__ void update_velocities(particle *d_bodies, float dt,int n){
	
	int i = threadIdx.x + blockDim.x * blockIdx.x;

	if(i < n){
		d_bodies[i].vx +=  0.5*dt*(d_bodies[i].ax+d_bodies[i].ax0); 
		d_bodies[i].vy +=  0.5*dt*(d_bodies[i].ay+d_bodies[i].ay0);
		d_bodies[i].vz +=  0.5*dt*(d_bodies[i].az+d_bodies[i].az0);
		
		d_bodies[i].ax0 = d_bodies[i].ax;
		d_bodies[i].ay0 = d_bodies[i].ay;
		d_bodies[i].az0 = d_bodies[i].az;
	}
}

__device__ void reset_accelerations(particle *d_bodies, int n){

	int i = threadIdx.x + blockDim.x * blockIdx.x;
	
	if(i < n){
		d_bodies[i].ax = 0.0;
		d_bodies[i].ay = 0.0;
		d_bodies[i].az = 0.0;
	}

}

__device__ void update_accelerations(particle *d_bodies,int n){

	int j;
	int i = threadIdx.x + blockDim.x * blockIdx.x;

	float dx=0.0,dy=0.0,dz=0.0;
	float r=0.0, r3=0.0, invr3=0.0,f=0.0;

	if (i < n){	
	    for(j=0; j<n; j++){
	       	if(j != i){
	
				dx=d_bodies[i].x-d_bodies[j].x;
				dy=d_bodies[i].y-d_bodies[j].y;
				dz=d_bodies[i].z-d_bodies[j].z;
	
				r = dx*dx + dy*dy + dz*dz;
				r3 = r*r*r;
				invr3 = 1.0/sqrt(r3);
	
				f=d_bodies[j].m*invr3;
	
				d_bodies[i].ax -=  f*dx;
				d_bodies[i].ay -=  f*dy;
				d_bodies[i].az -=  f*dz;
	
			}
		}
	}

}

__global__ void nbody(particle *d_bodies,float ite, float dt, int n){

	float t;
	reset_accelerations(d_bodies,n);
	__syncthreads();
	update_accelerations(d_bodies, n);
	__syncthreads();

	for (t = 0.0; t < ite; t += dt){

		update_positions(d_bodies,dt,n);
		__syncthreads();

		reset_accelerations(d_bodies,n);
		__syncthreads();

		update_accelerations(d_bodies,n);
		__syncthreads();

		update_velocities(d_bodies,dt,n);
		__syncthreads();
	}
	// end nbody algorithm


}

int main(int argc, const char *argv[])
{
	bool file = true;

	checkAndInit(argc, argv);

	initPopulation(file,argv[2]);
	// time stuff
	cudaEvent_t start, stop;
	float time;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start, 0);
	// end time stuff

	particle *d_bodies;
	int size = n*sizeof(particle);
	cudaMalloc((void**) &d_bodies, size);
	cudaMemcpy(d_bodies,bodies,size,cudaMemcpyHostToDevice);

	nbody<<< blockNum, threadsPerBlock >>> (d_bodies,ite,dt,n);

	cudaThreadSynchronize();	

	cudaMemcpy(bodies,d_bodies,size,cudaMemcpyDeviceToHost);
	cudaFree(d_bodies);

	// time stuff
	cudaEventRecord(stop, 0);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&time, start, stop);
	cudaEventDestroy(start);
	cudaEventDestroy(stop);
	cout << time/1000 << endl;
	// end time stuff
	return 0;
}
