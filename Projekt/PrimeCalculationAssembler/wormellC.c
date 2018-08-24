#include<stdio.h>
#include<stdlib.h>
#include <time.h>

extern int wormell(int n);


double curtime(void){
	struct timespec t;
	clock_gettime(CLOCK_MONOTONIC_RAW , &t);
	return t.tv_sec + t.tv_nsec * 1e-9;
}


int main(int argc, char** argv) {
        if(argc != 2) {
		return -1;        
	}
	if(atoi(argv[1]) <= 0){
		return -1;
	}
	int returnValue = 0;
	double start = curtime();
	returnValue = wormell(atoi(argv[1]));
	double end = curtime();
	double elapsed_time = end-start;
        printf("Die %s-te Primzahl ist: %d \n", argv[1],  returnValue);
	printf("Benoetigte Zeit:  %f\n", elapsed_time);
        return EXIT_SUCCESS;
}


