#include <stdio.h>
#include <stdlib.h>

void monocromatizar(char*, int, int, char);
void realzarBordes(char*, int, int, char*, char*, char*);
void realzarBordesRoberts(char*, int, int, char*, char*, char*);
void umbralizar(char*, int, int, char*, char*, char*);
void printHelp(char*);

void roberts(){
	printf("Ejecutando roberts...\n");
}


void prewitt(){
	printf("Ejecutando prewitt...\n");
}

void sobel(){
	printf("Ejecutando sobel...\n");
}

void umbralizarLauncher(){
	printf("Ejecutando umbralizado...\n");
}

void monocromatizarPromedio(){
	printf("Monocromatizando (Promedio)...\n");
}

void monocromatizarMaximo(){
	printf("Monocromatizando (Maximo)...\n");
}

void displayHelp(char *a){
	printf("Ayuda... \n");
	printf("%s <modos> <archivo entrada> <archivo salida>\n\n",a);
	printf("Los modos disponibles son los siguientes:\n");
	printf("r1 (Roberts)\n");
	printf("r2 (Prewitt)\n");
	printf("r3 (Sobel)\n");
	printf("u <umbral inferior> <umbral superior> (Umbralizar)\n");
	printf("m1 (Monocromatizar con promedio)\n");
	printf("m2 (Monocromatizar con maximo)\n");
}
}

int main(int argc, char *argv[]){

	if (argc < 2) {
		displayHelp(argv[0]);
	} else {

		if (argv[1] == "r1") {
			roberts();
		} else if (argv[1] == "r2") {
			prewitt();
		} else if (argv[1] == "r2") {
			sobel();
		} else if (argv[1] == "u") {
			umbralizarLauncher();
		} else if (argv[1] == "m1") {
			monocromatizarPromedio();
		} else if (argv[1] == "m2") {
			monocromatizarMaximo();
		} else {
			displayHelp(argv[0]);
		}



	}





	return 0;

}
