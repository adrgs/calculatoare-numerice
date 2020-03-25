#calcularea functiei x^y
.data

	x: .word 3
	y: .word 2

.text
.globl main

main:
	lw $a0, x #incarca x si y
	lw $t2, y

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
		mul $t1, $t1, $a0
		add $t0, $t0, 1
		blt $t0, $t2, bucla

	jr $ra
.end power
