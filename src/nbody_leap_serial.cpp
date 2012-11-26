#include "include/nbody.cpp"

void updateAccelerations(){
	int i,j;
	float dx,dy,dz;
	float r, r3, invr3,f;

	for (i = 0; i < n; i++) {
		bodies[i].ax = bodies[i].ay = bodies[i].az = 0;		
	}
	for (i = 0; i < n; i++) {
    	for(j=0; j<n; j++){
        	if(j != i){
            	dx=bodies[i].x-bodies[j].x;
				dy=bodies[i].y-bodies[j].y;
				dz=bodies[i].z-bodies[j].z;

                r = dx*dx + dy*dy + dz*dz;
                r3 = r*r*r;
                invr3 = 1.0/sqrt(r3);
                f=bodies[j].m*invr3;

                bodies[i].ax -= f*dx;
    	        bodies[i].ay -= f*dy;
                bodies[i].az -= f*dz;
			}
		}
	}
}


void updatePositions(){
	for (int i = 0; i < n; i++) {
		bodies[i].ax0 = bodies[i].ax;
		bodies[i].ay0 = bodies[i].ay;
		bodies[i].az0 = bodies[i].az;

	   	bodies[i].x += dt*bodies[i].vx + 0.5*dt*dt*bodies[i].ax0; 
	   	bodies[i].y += dt*bodies[i].vy + 0.5*dt*dt*bodies[i].ay0;
	   	bodies[i].z += dt*bodies[i].vz + 0.5*dt*dt*bodies[i].az0;
	}
}

void updateVelocities(){
	for (int i = 0; i < n; i++) {
		bodies[i].vx += 0.5*dt*(bodies[i].ax+bodies[i].ax0); 
		bodies[i].vy += 0.5*dt*(bodies[i].ay+bodies[i].ay0);
		bodies[i].vz += 0.5*dt*(bodies[i].az+bodies[i].az0);
		
		bodies[i].ax0 = bodies[i].ax;
		bodies[i].ay0 = bodies[i].ay;
		bodies[i].az0 = bodies[i].az;
	}
}


int main(int argc, const char *argv[])
{
	float t;
	bool file = true;
	checkAndInit(argc, argv);

	time_tot_start = omp_get_wtime();
	initPopulation(file,argv[2]);
	updateAccelerations();
	for (t = 0.0; t < ite; t += dt){
		updatePositions();
		updateAccelerations();
		updateVelocities();
	}
	
	time_tot_end = omp_get_wtime();
	cout << "Time: " << time_tot_end - time_tot_start << endl;
	return 0;
}
