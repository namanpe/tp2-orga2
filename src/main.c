#include <stdio.h>
#include <stdlib.h>

void monocromatizar(char*, int, int, char);
void realzarBordes(char*, int, int, char*, char*, char*);
void realzarBordesRoberts(char*, int, int, char*, char*, char*);
void umbralizar(char*, int, int, char*, char*, char*);
void printHelp(char*);


void roberts(char *argv[]){
        printf("Ejecutando roberts...\n");
}

void prewitt(char *argv[]){
        printf("Ejecutando prewitt...\n");
}

void sobel(char *argv[]){
        printf("Ejecutando sobel...\n");
}

void umbralizarLauncher(int argc, char *argv[]){
        printf("Ejecutando umbralizado...\n");
}

void monocromatizarPromedio(char *argv[]){
	printf("Monocromatizando (Promedio)...\n");

	FILE *pFile, *salida;
	char *file, *fileSalida;
	long nBytes;
	int i, j;

	char* archivoEntrada = argv[2];
	char* archivoSalida = argv[3];


	pFile = fopen ( archivoEntrada , "rb" );
	if( pFile != NULL ){
		fseek(pFile, 0, SEEK_END);
		nBytes = ftell(pFile); // Tamaño en bytes del archivo
		file = malloc(nBytes); // Pido memoria para cargar el archivo de entrada
		fileSalida = malloc(nBytes);

		fseek(pFile, 0, 0);
		fread(file, 1, nBytes, pFile); // Leo todo el archivo

		fseek(pFile, 0, 0);
		fread(fileSalida, 1, nBytes, pFile); // Leo todo el archivo

		fseek(pFile, 18, SEEK_SET);
		fread(&i, 1, 4, pFile); // Leo el alto

		fseek(pFile, 22, SEEK_SET);
		fread(&j, 1, 4, pFile); // Leo el ancho

		monocromatizar(fileSalida + 54, i, j, 'p');

	}


}

void monocromatizarMaximo(char *argv[]){
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

	if (argc < 4) {
			displayHelp(argv[0]);
	} else {

			if (argv[1] == "r1") {
					roberts(argv);
			} else if (argv[1] == "r2") {
					prewitt(argv);
			} else if (argv[1] == "r2") {
					sobel(argv);
			} else if (argv[1] == "u") {
					umbralizarLauncher(argc, argv);
			} else if (argv[1] == "m1") {
					monocromatizarPromedio(argv);
			} else if (argv[1] == "m2") {
					monocromatizarMaximo(argv);
			} else {
					displayHelp(argv[0]);
			}

	return 0;

}
