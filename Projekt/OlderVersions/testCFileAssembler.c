#include<stdio.h>
#include<stdlib.h> 
#include <time.h>
#include <float.h>

extern int wormell(int n); 

double curtime(void){
	struct timespec t;
	clock_gettime(CLOCK_MONOTONIC_RAW , &t);
	return t.tv_sec + t.tv_nsec * 1e-9;
}

int main(int argc, char** argv) {
	if(argc != 3){
		printf("You need 3 Arguments: Path, nthPrime, x-Timetest\n");
		return -1;
	}
	if(atoi(argv[1]) < 1 || atoi(argv[2]) < 1){
		printf("Values need to be greater than 1\n");
		return -1;
	}	
	double minTime = DBL_MAX;
	double avgTime = 0.0;
	double maxTime = DBL_MIN;
	int realPrime = 0;
	int primes[atoi(argv[2])];

	for(int i = 0;i < atoi(argv[2]); i++){
		double start = curtime();
		primes[i]  = wormell(atoi(argv[1]));
		double end = curtime();	
		double elapsed_time = end-start;
		avgTime += elapsed_time;
		if(elapsed_time < minTime){
			minTime = elapsed_time;
		}
		if(elapsed_time > maxTime){
			maxTime = elapsed_time;
		}
	}
	realPrime = primes[0];
	for(int i = 0; i < atoi(argv[2]);i++){
		if(primes[i] != realPrime){
			printf("Mistakes were made!\n");
		}
	}
	avgTime /= atoi(argv[2]);
        printf("Die %s-te Primzahl ist: %d \n", argv[1], realPrime);
	printf("Minimal benoetigte Zeit: %f\n", minTime);
	printf("Maximal benoetigte Zeit: %f\n", maxTime);
	printf("Durchschnittliche  benoetigte Zeit: %f\n", avgTime);
        return EXIT_SUCCESS;
}
