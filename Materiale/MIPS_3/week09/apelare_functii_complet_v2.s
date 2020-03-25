#calcularea functiei x^y
.data

	x: .word 2
	y: .word 4

.text
.globl main

main:
	lw $t2, x #incarca x si y
	lw $t3, y

	jal power #jump and link catre functia (eticheta) power

	#afiseaza valoarea calculata
	move $a0, $t1 
	li $v0, 1
	syscall

	#exit
	li $v0, 10
	syscall
.end main

#functia care calculeaza x^y
.globl power

power:
	#valori de start pentru bucla
	li $t1, 1
	li $t0, 0

	bucla:
		mul $t1, $t1, $t2
		add $t0, $t0, 1
		blt $t0, $t3, bucla

	jr $ra
.end power
