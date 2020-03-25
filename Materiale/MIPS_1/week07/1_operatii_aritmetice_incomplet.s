# Cateva instructiuni simple pentru a testa QtSpim
# 
	# Codul propriu zis (programul) trebuie sa apara dupa directiva de asamblare ".text"
	# 
	.text 

	# main este o functie globala
	.globl main 

		

# Eticheta "main" este punctul de incepere a executiei programului
main:
	li $t2, 25		# Incarca imediat valoarea (25) in t2
	lw $t3, val		# Incarca cuvantul stocat sub eticheta "val"

				# Aduna-le
				# Afiseaza-le
				# Afiseaza linie noua "\n"	
			
				# Scade-le
				# Afiseaza-le
				# Afiseaza linie noua "\n"

				# Inmulteste-le
				# Afiseaza-le
				# Afiseaza linie noua "\n"


	# Iesirea se face cu un apel al "syscall".
	# ATENTIE: sunt mai multe tipuri de apeluri syscall (de fapt un vector de interupere)
	# trebuie ales cel convenabil, plasandu-i codul in $v0. Codul pentru "exit" e "10"

	li $v0, 10 		# Scrie "10" in v0 pentru a selecta "exit syscall"
	syscall 		# Si ies


.end main

	# Toate structurile de stocat in memorie trebuie plasate dupa 
	# directiva de asamblare ".data" 
	.data


	# Directiva .word rezerva spatiu in RAM pentru 
	# o singura variabila word pe 4-octeti (sau pentru mai multe astfel de variabile)
	# si atribuie acelei locatii RAM o valoare initiala
	# (sau o lista de valori initiale separate prin virgula)

val:	.word 29
