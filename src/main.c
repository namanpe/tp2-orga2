#include <stdio.h>
#include <stdlib.h>

void monocromatizar(char*, int, int, char);
void realzarBordes(char*, int, int, char*, char*, char*);
void realzarBordesRoberts(char*, int, int, char*, char*, char*);
void umbralizar(char*, int, int, char*, char*, char*);
void printHelp(char*);

int main(int argc, char *argv[]){

	if (argc < 2) {
		displayHelp();
	} else {
	
		if (argv[1] == "r1") {
			roberts();
		} else if (argv[1] == "r2") {
			prewitt();
		} else if (argv[1] == "r2") {
			sobel();
		} else if (argv[1] == "u") {
			umbralizar();
		} else if (argv[1] == "m1") {
			monocromatizarPromedio();
		} else if (argv[1] == "m2") {
			monocromatizarMaximo();
		} else {
			displayHelp();
		}
	
	
	
	}





	return 0;

}