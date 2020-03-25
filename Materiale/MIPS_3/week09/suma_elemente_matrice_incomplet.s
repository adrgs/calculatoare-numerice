#suma elementelor de pe diagonala

.data
	matrice: .word 1, 2, 3, 4
		 .word 5, 6, 7, 8
		 .word 9, 10, 11, 12
		 .word 13, 14, 15, 16

	dimensiuneArray: .word 4
	suma: .word 0
	
	lungimeWord = 4 #valoare constanta - un word are 4 octeti

.text
.globl main

main:
	#incarca adresa de inceput a matricii
	#stocheaza dimensiunea matricii

	#cheama functia

	#afiseaza rezultatul

	#exit

.end main

.globl sumaDiagonala

sumaDiagonala:
	#valori initiale pentru suma si indice bucla

	bucla:  #pentru calcularea sumei
		#indice rand * dimensiune rand
		#+ indice coloana

		
		#multiplica valoarea obtinuta anterior cu dimensiuna unui word 
		#aduna valoarea la adresa de inceput

		#incarca valoarea din sir indicata de adresa nou obtinuta

		#aduna elementul la valoarea curenta a sumei

		#incrementeaza indice
		#continua bucla

	jr $ra
.end sumaDiagonala
	
