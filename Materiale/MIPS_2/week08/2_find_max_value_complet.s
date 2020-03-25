# programul gaseste valoarea maxima intr-o lista de intregi
	.text
	.globl main
main:
	li $v0, 4		# afisez un prompt
	la $a0, prompt
	syscall

	li $t0, 0		# indicele de lista i in $t0
	li $s0, 0		# valoarea maxima in $s0
	lw $s1, n		# numarul de elemente n din lista in $s1

m1:	bge $t0, $s1, m3	# pseudo-instructiune - if($t0>=$s1) PC=m3. Echivalent cu instructiunile reale:
				# slt $at,$t0,$s1; beq $at,$zero,m3

	mul $t1, $t0, 4		# $t1=$t0 * 4; scaleaza i dupa dimensiunea .word
	lw $t2, a($t1)		# incarca a[i] in $t2
	ble $t2, $s0, m2	# pseudo-instructiune: if($t2<=$s0) PC=m2 (sar direct daca a[i] <= max)
	move $s0, $t2		# altfel: max = a[i]
m2:	addi $t0, $t0, 1	# i++
	b m1			# pseudo-instructiune (ramificare neconditionata, PC=m1)
m3:	move $a0, $s0		# ...ies din bucla
	
	

	li $v0, 1		# afisez rezultatul	
	syscall
	li $v0, 10		# ...si iesim gratios!
	syscall

.end main
# segmentul de date
	.data
a:	.word 69, 34, 2, 85, 7, 52, 48, 17, 22
n:	.word 9
max:	.word 0
prompt: .asciiz "maximum: "



