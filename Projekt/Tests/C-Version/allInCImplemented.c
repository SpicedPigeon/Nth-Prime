#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <float.h>

double curtime(void){
	struct timespec t;
	clock_gettime(CLOCK_MONOTONIC_RAW, &t);
	return t.tv_sec + t.tv_nsec * 1e-9;
}

int wormell(unsigned int n){
	unsigned int i = 2;
	unsigned int primeCounter = 0;
	while(1){
	        unsigned int a = 2;
	        unsigned int xHalb = i/2;
		    unsigned int anzTeiler = 0;
		    
        	while(a <= xHalb){
        	unsigned int a2 = a+1, a3=a+2, a4=a+3;
			float result1 = (double)i/a;
			
			float result2 = (double)i/a2;
			
			float result3 = (double)i/a3;
			
			float result4 = (double)i/a4;
			
			unsigned int ergebnis1 = ((int) result1) * a;
			if(ergebnis1 == i){
				anzTeiler++;
				if(a == i){
					anzTeiler--;
				}
			}
			a++;
			unsigned int ergebnis2 = ((int) result2) * a;
			if(ergebnis2 == i){
				anzTeiler++;
				if(a2 == i){
					anzTeiler--;
				}
			}
			a++;
			unsigned int ergebnis3 = ((int) result3) * a;
			if(ergebnis3 == i){
				anzTeiler++;
				if(a3 == i){
					anzTeiler--;
				}
			}
			a++;
			int ergebnis4 = ((int) result4) * a;
			if(ergebnis4 == i){
				anzTeiler++;
				if(a4 == i){
					anzTeiler--;
				}
			}
			
			if(anzTeiler >= 1){
				break;
			}
			a++;
        	}

		if(anzTeiler == 0){
			primeCounter++;
			if(primeCounter >= n){
				return i;
			}
		}
		i++;
	}
}



int main(int argc, char** argv){
	if(argc != 3){
                printf("You need 3 Arguments: Path, nthPrime, x-Timetest\n");
                return -1;
        }
        if(atoi(argv[1]) < 1 || atoi(argv[2]) < 1){
                printf("Values need to be greater than 1\n");
                return -1;
        }

	double minTime = DBL_MAX;
	double maxTime = DBL_MIN;
	double avgTime = 0.0;
	int realPrime = 0;
	int primes[atoi(argv[2])];

	for(int i = 0;i < atoi(argv[2]); i++){
		double start = curtime();
		primes[i] = wormell(atoi(argv[1]));
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
	printf("Durchschnittliche benoetigte Zeit: %f\n", avgTime);
}
