#calcularea functiei x^y
.data

	x: .word 3
	y: .word 2

.text
.globl main

main:
	#incarca x si y

	#jump and link catre functia (eticheta) power

	#afiseaza valoarea calculata

	#exit

.end main

#functia care calculeaza x^y
.globl power

power:
	#valori de start pentru bucla


	bucla:


	jr $ra
.end power
