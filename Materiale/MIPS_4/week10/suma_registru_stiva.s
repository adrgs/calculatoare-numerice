# Calculez suma patratelor (i^2) i=1..4
# cu utilizarea corecta a registrilor de stare
# ATENTIE:
#		
#	$sp este pointerul de stiva; trebuie manipulat corect, pentru a avea spatiul necesar pentru parametri in stiva  
#	$ra contine adresa de revenire dintr-o subrutina
#	$zero este mereu 0

	.text
	.globl main
main:
	subu	$sp, $sp, 4	# asigur spatiul necesar pentru parametri in stiva (1 valoare word) (PUSH)
    				# $sp = $sp - 4


	sw	$ra, 0($sp)	# salvez registrul $ra in stiva, la adresa de offset 0 fata de $sp, adica fix
				# in spatiul asigurat prin comanda precedenta

    	move	$s0, $zero	# $s0 : i (valoarea initiala, inainte de intrarea in bucla)
	move	$s1, $zero	# $s1 : suma (valoarea initiala, inainte de intrarea in bucla)

loop:
	mul	$t0, $s0, $s0	# calculez i^2
	addu	$s1, $s1, $t0	# calculez suma (acumulez valorile i^2 in $s1)
	addiu	$s0, $s0, 1	# incrementez i
	ble	$s0, 4, loop	# instructiunea de control a buclei:
				# if (i <= 4) goto loop

				# Pregatirea afisarii rezultatului:
	li	$v0,4		# 4 = print_string (incarc valoarea corecta pentru optiunea de afisare cu care se va apela intreruperea syscall)
	la	$a0, str	# $a0 (argumentul) contine acum adresa stringului str (stringul de afisat)
	syscall			# apel syscall.

	li	$v0,1		# 1 = print_integer (vom afisa o valoare intreaga)
	move	$a0, $s1	# pe care o incarc in deja celebrul $a0 (REMEMBER: reprezentarea interna a datelor depinde de context!)
	syscall			

	li	$v0,4		# afisez o linie noua
	la	$a0, newline	 
	syscall

				# ...si gata. Dar, inainte de a iesi: 
				# eliberez spatiul utilizat in stiva si revin la valoarea initiala din $ra
	lw	$ra, 0($sp)	# restaurez registrul 31 ($ra)
	addu	$sp, $sp, 4	# POP in stiva (duc pointerul de stiva la valoarea initiala)
	jr	$ra		# ...si ies

	# Segmentul de date
	.data
str:
	.asciiz	"\nSuma valorilor i^2 cu i = 1 .. 4 este "
newline:
	.asciiz	"\n"
