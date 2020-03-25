	.text
	.globl main
main:
	li $t0, 12
	
	#afiseaza prima data
	lw $a0, a($t0)
	li $v0, 1
	syscall
	
	#afiseaza linie noua
	la $a0, nl
	li $v0, 4
	syscall

	#afiseaza a doua oara
	la $t1, a
	lw $a0, 4($t1)
	li $v0, 1
	syscall

	li $v0, 10		# ...si iesim 
	syscall

.end main

	.data
a:	.word 69, 34, 2, 85, 7, 52, 48, 17, 22
nl: 	.asciiz "\n"








