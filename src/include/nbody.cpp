#include "nbody.h"

void initPopulation(bool read, const char filename[50]){
	if (read) {
		int i,tmp;
		float xx,yy,zz,vvx,vvy,vvz,mm;
		FILE *in;
		in = fopen(filename,"r");

		for(i = 0; i < n; i++){
			fscanf(in,"%d %f %f %f %f %f %f %f\n", &tmp,&mm, &xx,&yy,&zz,&vvx,&vvy,&vvz);
			bodies[i].x = xx;
			bodies[i].y = yy;
			bodies[i].z = zz;
			bodies[i].vx = vvx;
			bodies[i].vy = vvy;
			bodies[i].vz = vvz;
			bodies[i].m = mm;
		}
		fclose(in);
	}
	else {
		srand48((unsigned)time(NULL));
		int i;
		float mass = (float) rand()/RAND_MAX;

		for (i = 0; i < n; i++) {
			bodies[i].x = (float) rand()/RAND_MAX * 2.0 - 1.0;
			bodies[i].y = (float) rand()/RAND_MAX * 2.0 - 1.0;
			bodies[i].z = (float) rand()/RAND_MAX * 2.0 - 1.0;
			
			bodies[i].vx = (float) rand()/RAND_MAX * 2.0 - 1.0;
			bodies[i].vy = (float) rand()/RAND_MAX * 2.0 - 1.0;
			bodies[i].vz = (float) rand()/RAND_MAX * 2.0 - 1.0;

			bodies[i].m = mass;
	
		}
	}

}


void print(){
	int i;
	for (i = 0; i < n; i++) {
		printf("%d %lf %lf %lf %lf %lf %lf %lf %lf %lf\n",i,bodies[i].x,bodies[i].y,bodies[i].z,bodies[i].vx,bodies[i].vy,bodies[i].vz,bodies[i].ax0,bodies[i].ay0,bodies[i].az0);
	}
}

void print_particle(int i){
	printf("%d %lf %lf %lf %lf %lf %lf %lf %lf %lf\n",i,bodies[i].x,bodies[i].y,bodies[i].z,bodies[i].vx,bodies[i].vy,bodies[i].vz,bodies[i].ax0,bodies[i].ay0,bodies[i].az0);
}

void print_file(){
	int i;
	for (i = 0; i < n; i++) {
		printf("%d %lf %lf %lf %lf %lf %lf %lf\n",i,bodies[i].m,bodies[i].x,bodies[i].y,bodies[i].z,bodies[i].vx,bodies[i].vy,bodies[i].vz);
	}
}

void checkAndInit(int argc, const char *argv[]){

    if (argc < 3) {
        cerr << "Normal usage: " << argv[0] << " size input_file" << endl;
        cerr << "CUDA usage: " << argv[0] << " size input_file numBlocks threadsPerBlock" << endl;
        exit(1);
    }

    n = atoi(argv[1]);
	cores = atoi(argv[3]);

	if (argc ==  5){
		blockNum = atoi(argv[3]);
		threadsPerBlock = atoi(argv[4]);

//		if (blockNum * threadsPerBlock != n){
//			cerr << "You are wasting threads," << endl;
//			cerr << "because the blockNum * threadsPerBlock != n" << endl;;
//			cerr << ">>>> " << blockNum << " * " << threadsPerBlock << " != " << n;
//        	exit(1);
//		}
		
		cout << "blockNum: " << blockNum << endl;
		cout << "threadsPerBlock: " << threadsPerBlock << endl;
	}


	bodies = new particle[n];
}
