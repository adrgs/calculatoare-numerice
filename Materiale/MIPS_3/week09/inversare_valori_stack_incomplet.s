.data

	sir: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	lungime: .word 10
	nl: .asciiz "\n"
	space: .asciiz " "

.text
.globl main

main:
	#bucla pntru incarcarea (push) valorilor in stiva
	la $t0, sir #adresa de inceput a sirului
	li $t1, 0 #indice bucla i=0
	lw $t2, lungime

citire1:
	#afiseaza elementul [i] din sir

	#afiseaza spatiu

	
#resetare valori (adresa sir, indice bucla)


push:
	lw $t4, ($t0) #ia elementul [i] din array
	subu $sp, $sp, 4 #decrementeaza stiva  
	sw $t4, ($sp) #incarca elementul [i] in stiva

	#i=i+1
	#incrementeaza adresa din sir
	#continua (se intoarce la push) daca i<lungime 
##

#bucla pentrua a scoate (pop) elementele din stiva si a le baga
#inapoi in sir
	
	#resetare valori (adresa sir, indice bucla)

 
pop: #inversul lui push ...

##

	#resetare valori (adresa sir, indice bucla)
	
	#afiseaza linie noua


citire2:
	
	#exit

.end main
