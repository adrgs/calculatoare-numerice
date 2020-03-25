# Calculeaza factorialul unui numar dat de utilizator - exemplu de program recursiv
# Utilizari multiple de tip "call-return"
# Nu voi mai comenta decat liniile cu functionalitate noua. Cele deja intalnite le las necomentate

#####################################################################
# segmentul de date
#####################################################################

            .data
prompt:     .asciiz "Numar: "
nl:         .asciiz "\n"
instr:      .asciiz "0 pentru iesire:\n"
response:   .asciiz "Factorial: "


######################################################################
# main
######################################################################

            .text
            .globl main
main:
            sub $sp, $sp, 16     # $sp=$sp-16 
            sw $fp, 16($sp)	 # salveaza registrii de stare $fp, $ra, $s0
            sw $ra, 12($sp)
            sw $s0,  8($sp)
            add $fp, $sp, 16

            li $v0, 4            # Afiseaza instr.
            la $a0, instr
            syscall

            jal getnum           # Citeste numarul de la tastatura.

            sw $v0, -12($fp)     # ...si stocheaza-l local.
            move $s0, $v0

while1:
            beqz $s0, endwhile1  # Calculeaza pana se tasteaza 0.

            li $v0, 4            # Afiseaza mesajul de raspuns.
            la $a0, response
            syscall

            move $a0, $s0        # Transmite argument

            jal factorial        # Apeleaza subrutina factorial

            move $a0, $v0        # Copiaza valoarea de intoarcere
            li $v0, 1		 # ...si afiseaz-o
            syscall

            li $v0, 4            # Vom citi un nou numar: mai intai o linie noua se va afisa.
            la $a0, nl
            syscall

            jal getnum		 # Citeste noul numar

            sw $v0, -12($fp)     # ... si stocheaza-l local.
            move $s0, $v0

            b while1		 # pseudo-instructiune de ramificare neconditionata
				 # instructiunea reala: beq $0,$0,while1 si are ca efect PC=while1

endwhile1:
            lw $s0,  8($sp)      # Restaureaza registrii $s0, $ra, $fp (atentie la ordinea operatiilor!).
            lw $ra, 12($sp)
            lw $fp, 16($sp)
            add $sp, $sp, 16
            li $v0, 0
            jr $ra               # ...si iesim gratios.


######################################################################
# getnum - citeste o valoare intreaga de la tastatura utilizand $v0.
######################################################################

            .text
getnum:
            sub $sp, $sp, 12     # PUSH & SAVE - ca mai sus, salvez registrii de stare.
            sw $fp, 12($sp)
            sw $ra,  8($sp)
            add $fp, $sp, 12

            li $v0, 4		 # Afiseaza stringul de avertizare de input (prompt)
            la $a0, prompt
            syscall

            li $v0, 5
            syscall              # Valoarea citita e in $v0.

            sw $v0, -8($fp)	 # O stocam local

            lw $ra,  8($sp)      # ...si restauram registrii.
            lw $fp, 12($sp)
            add $sp, $sp, 12
            jr $ra		 # si revin in rutina apelanta


######################################################################
# factorial - calculeaza factorialul valorii din $a0 si intoarce 
# rezultatul prin intermediul $v0
######################################################################

            .text
factorial:
            sub $sp, $sp, 16	 # PUSH & SAVE
            sw $fp, 16($sp)
            sw $ra, 12($sp)
            sw $s0,  8($sp)
            add $fp, $sp, 16

            sw $a0, -12($fp)     # Valoarea n.
            move $s0, $a0

            bgt $s0, 1, recurse  # if(n>1) goto recurse
            li $v0, 1		 # Cazul exceptional 0!=1. Intorc 1
            lw $s0, 8($sp)	 # ...si POP (restaurez registrii)
            lw $ra, 12($sp)
            lw $fp, 16($sp)
            add $sp, $sp, 16
            jr $ra		 # ...si revin in rutina apelanta

recurse:    sub $a0, $a0, 1      # Apelare recursiva. Calculez (n-1)!
            jal factorial	 # (n-1)!
            mul $v0, $v0, $s0    # n * (n-1)!
            lw $s0, 8($sp)	 # POP (restaurez registrii)
            lw $ra, 12($sp)
            lw $fp, 16($sp)
            add $sp, $sp, 16
            jr $ra		 # ...si revin in rutina apelanta
