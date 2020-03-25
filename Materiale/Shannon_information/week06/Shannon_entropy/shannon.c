
// compile:
// gcc -o shannon shannon.c -lm
// run:
// ./shannon tom_sawyer_intro_mini.txt

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>



int main( int argc, char **argv)
{
  int i, j, len, N;
  int *N_ap;
  float Info;
  float *p;
  char *buffer;
  
  FILE *inFile, *outFile;

  // numele fisierului este specificat la rulare   
  inFile = fopen( argv[1], "r");

  // determin lungimea fisierului 
  fseek( inFile,0,SEEK_END);
  len = ftell(inFile);
  rewind(inFile);
  
  // alloc memorie pentru a incarca continutul in "buffer" 
  if((buffer=malloc(len*sizeof(char)))==NULL) {
       printf("Eroare alocare memorie\n"); 
       return(1);
  } 
  
  // incarca fisierul in buffer
  fread(buffer, len, 1, inFile);
  
  fclose(inFile);
  
  
  // afisez codurile  ASCII ale primelor 10 caractere din text
  for(i=0;i<10;i++)
  {
   printf( "%i \n", *(buffer+i));
  } 

  // array nr. de aparitii N_ap pentru fiecare caracter (coduri ASCII intre 0 si 127)
  N = 128;
  N_ap = malloc( N*sizeof(int));  // nr. de aparatii
  p = malloc( N*sizeof(float)); // probabilitatea de aparitie 

  // initializare
  for (i=0;i<N;i++) {
       N_ap[i] = 0;
  }

  // incrementez nr de aparatii pentru fiecare caracter N_ap[j]  
  for (i=0;i<len;i++) {
       j = *(buffer+i);
       N_ap[j] = N_ap[j] + 1;
  }

  // calculez probabilitatea de aparitie a unui caracter = nr. aparitii / nr. total caractere 
  for (i=0;i<N;i++) {
       p[i] = (float)N_ap[i] / (float)len;
       if (p[i]!=0) printf( "%i %f\n", i, p[i]);
  }

  // Calculez Informatia (Entropia) Shannon
  Info = 0.;
  for (i=0;i<N;i++) {
       if (p[i]!=0.) {
           Info = Info - p[i]*log(p[i])/log(2.0);
       }
  } 

  // Afisez Informatia Shannon
  // Rezultatul (4.23) reprezinta informatia medie masurata in bits pe care o 
  // primesc cand aflu un caracter nou din text
  printf( "Info = %f \n", Info);

   
 free(buffer);

 
 return 0;
  
}

//-------------------------------------------------------------/

