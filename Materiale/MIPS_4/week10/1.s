.data

fout: .asciiz "test.txt"
reservedspace: .space 1024
cont: .asciiz "reading file... "

buffer: .asciiz "some text to test the program."
##################################################

.text 

main:

menu:

getinput:   

li $v0, 5
syscall
move $s0, $v0

beq $s0, 0, create  
beq $s0, 1, read    
beq $s0, 2, delete
beq $s0, 3, show
beq $s0, 4, exit

j getinput

#######################################

create:
    #write on file
    #open
    li $v0, 13
    la $a0, fout
    li $a1, 1
    li $a2, 0
    syscall
    move $s6, $v0

    #write
    li $v0, 15
    move $a0, $s6
    la $a1, buffer
    li $a2, 30
    syscall


#  la $a0, reservedspace
#  li  $v0, 4
#  syscall




    #close
    li $v0, 16
    move $a0, $s6
    syscall
j menu

search:
    li $v0, 13
    la $a0, fout
    li $a1, 0
    li $a2, 0
    syscall
    move $s6, $v0

    li $v0, 14
    move $a0, $s6
    la $a1, reservedspace
    li $a2, 1024
    syscall

    li  $v0, 4
    la  $a0, cont
    syscall

    close:
    li $v0, 16
    move $a0, $s6
    syscall
j menu


