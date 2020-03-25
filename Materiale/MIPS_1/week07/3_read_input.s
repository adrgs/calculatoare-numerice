# Operatiuni input/output simple in MIPS
# Asta e un exemplu standard

	# Aici incepe codul (programul)
	.text
	
	.globl	main	# "main" e globala
main:
	# Afiseaza stringul str1
	li	$v0,4		# codul syscall:print_string  = 4
	la	$a0, str1	# incarca adresa lui str1
	syscall			# afiseaza-l

	# Input V1 de la utilizator si salveaza
	li	$v0,5		# codul syscall:read_int = 5
	syscall	
	move	$t0,$v0		# rezultatul de la apelul syscall intors in v0 mutat in t0

	# Afiseaza stringul str2
	li	$v0,4		# codul syscall:print_string = 4
	la	$a0, str2	# incarca adresa lui str2
	syscall

	# Input V2 de la utilizator si salveaza
	li	$v0,5		# codul syscall:read_int = 5
	syscall	
	move	$t1,$v0		# rezultatul de la apelul syscall intors in v0, mutat in t1

	# Ceva aritmetica simpla, ca prelucrare a datelor de intrare
	add	$t0, $t0, $t1	# R = V1 + V2

	# Afiseaza str3
	li	$v0, 4		# codul syscall:print_string  = 4
	la	$a0, str3	# incarca adresa lui str3
	syscall

	# Afiseaza suma calculata anterior
	li	$v0,1		# codul syscall:print_int = 1
	move	$a0, $t0	# intregul de afisat trebuie incarcat in a0
	syscall

	# Afiseaza o linie noua (\n)
	li	$v0,4		# codul syscall:print_string = 4
	la	$a0, newline
	syscall

	li	$v0,10		# ...si iesim gratios
	syscall

	# incepe segmentul de date (".data")
	.data
str1:	.asciiz	"Valoarea A:   "
str2:	.asciiz	"Valoarea B:   "
str3:	.asciiz	"A + B = "
newline:   .asciiz	"\n"
