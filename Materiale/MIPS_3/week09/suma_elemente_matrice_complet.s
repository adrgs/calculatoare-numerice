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
	la $a0, matrice #incarca adresa de inceput a matricii
	lw $a1, dimensiuneArray #stocheaza dimensiunea matricii

	#cheama functia
	jal sumaDiagonala

	#afiseaza rezultatul
	move $a0, $t0
	li $v0, 1
	syscall

	#exit
	li $v0, 10
	syscall
.end main

.globl sumaDiagonala

sumaDiagonala:
	#valori initiale pentru suma si indice bucla
	li $t0, 0 
	li $t1, 0

	bucla:  #pentru calcularea sumei
		mul $t2, $t1, $a1 #indice rand * dimensiune rand
		add $t2, $t2, $t1 #+ indice coloana

		
		mul $t2, $t2, lungimeWord #multiplica valoarea obtinuta anterior cu dimensiuna unui word 
		add $t3, $a0, $t2 #aduna valoarea la adresa de inceput

		lw $t4, ($t3) #incarca valoarea din sir indicata de adresa nou obtinuta

		add $t0, $t0, $t4 #aduna elementul la valoarea curenta a sumei

		add $t1, $t1, 1 #incrementeaza indice
		blt $t1, $a1, bucla #continua bucla

	jr $ra
.end sumaDiagonala
	
