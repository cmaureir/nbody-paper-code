#include "include/nbody.cpp"

void *updateAccelerationsCalc(void *th){
	struct Thread tmp= *((Thread *)th);
	int ini = tmp.ini;
	int end = tmp.end;
	int i = 0, j = 0;
	float dx=0.0,dy=0.0,dz=0.0;
	float r=0.0, r3=0.0, invr3=0.0,f=0.0;

	for(i=ini;i<end;i++){
    	for(j=0; j<n; j++){
			if(j != i){
				dx=bodies[i].x-bodies[j].x;
				dy=bodies[i].y-bodies[j].y;
				dz=bodies[i].z-bodies[j].z;

    			r = dx*dx + dy*dy + dz*dz;
    			r3 = r*r*r;
    			invr3 = 1.0/sqrt(r3);
    			f=bodies[j].m*invr3;

				//pthread_mutex_lock(&lock);
				bodies[i].ax -= f*dx;
				bodies[i].ay -= f*dy;
				bodies[i].az -= f*dz;
				//pthread_mutex_unlock(&lock);
			}
		}
	}
}

void updateAccelerations(){
	int i;
	
	for (i = 0; i < n; i++) {
		bodies[i].ax = bodies[i].ay = bodies[i].az = 0;		
	}
	int tmp = n/cores;
	//pthread_mutex_init(&lock, NULL);
	for (i = 0; i < cores; i++) {
		threads[i].ini = i*tmp;
		threads[i].end = threads[i].ini+tmp;
		//cout << "Ini: " << threads[i].ini << "End:" << threads[i].end <<endl;
		pthread_create(&threads[i].thread, NULL , updateAccelerationsCalc, (void *)&threads[i]);
	}

	for(int j=0 ; j < cores ; ++j){ 
		pthread_join(threads[j].thread, NULL);
	}
	//pthread_mutex_destroy(&lock);
	
}

void updatePositionsCalc(int i){

	bodies[i].ax0 = bodies[i].ax;
	bodies[i].ay0 = bodies[i].ay;
	bodies[i].az0 = bodies[i].az;
	
	bodies[i].x += dt*bodies[i].vx + 0.5*dt*dt*bodies[i].ax0; 
	bodies[i].y += dt*bodies[i].vy + 0.5*dt*dt*bodies[i].ay0;
	bodies[i].z += dt*bodies[i].vz + 0.5*dt*dt*bodies[i].az0;
}

void updatePositions(){
	for (int i = 0; i < n; i++) {
		updatePositionsCalc(i);
	}
}

void updateVelocitiesCalc(int i){

	bodies[i].vx += 0.5*dt*(bodies[i].ax+bodies[i].ax0); 
	bodies[i].vy += 0.5*dt*(bodies[i].ay+bodies[i].ay0);
	bodies[i].vz += 0.5*dt*(bodies[i].az+bodies[i].az0);
	
	bodies[i].ax0 = bodies[i].ax;
	bodies[i].ay0 = bodies[i].ay;
	bodies[i].az0 = bodies[i].az;
}

void updateVelocities(){
	for (int i = 0; i < n; i++) {
		updateVelocitiesCalc(i);
	}
}


int main(int argc, const char *argv[])
{
	float t;
	bool file = true;

	//time_tot_start = omp_get_wtime();

	checkAndInit(argc, argv);
	threads = new Thread[get_nprocs()];
	initPopulation(file,argv[2]);
	updateAccelerations();
	for (t = 0.0; t < ite; t += dt){
		updatePositions();
		updateAccelerations();
		updateVelocities();
	}

	//time_tot_end = omp_get_wtime();
	//cout << "Time: " << time_tot_end - time_tot_start << endl;
	return 0;
}
