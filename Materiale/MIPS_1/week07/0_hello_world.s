# Celebrul "Hello World" in MIPS
# Evident tot ce inseamna cod apare dupa directiva .text
      .text

# functia main este o functie globala (vezi documentatia!)
      .globl	main
	
# Actiunea incepe de la eticheta "main", asa cum ne-am obisnuit deja
main:
	# Executa un syscall de tip print_string, actiune (syscall) cu codul 4
	li	$v0,4		# Incarca imediat in v0 codul 4: print_string
	la	$a0, msg	# Pointer pe string (adresa lui "msg")
	syscall			# Apelul syscall propriu-zis

	li	$v0,10		# Codul pentru syscall: exit (dupa cum stim deja din exemplul anterior!)
	syscall

	# Toate alocarile in RAM apar dupa directiva ".data"

.end main
	
	.data

	# Directiva .asciiz creeaza un string ASCII in RAM, terminat cu NULL 
	# ATENTIE: toate stringurile sunt prinse intre ghilimele!
	# 
msg:	.asciiz	"Hello World !\n"
