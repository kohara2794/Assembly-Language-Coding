# Demo
#
# Filename : LoadImmediate

	

    .data

openingStr: .asciiz "Two values to be multiplied...\n"
timesStr: .asciiz "   times   "
equalsStr: .asciiz "\nEquals : "
multiplier:           .half   5    #int multiplier
multiplicand:         .half   5    #int multiplicand
Syscall_PrintString:  .word 4
Syscall_PrintInt:     .word 1



##########################################################################
#                               MAIN PROGRAM                             #
##########################################################################
    .text

main:  
   
    lw $v0, Syscall_PrintString
    la $a0, openingStr            #prints first string
    syscall
    
    lh $t0, multiplier
    li $v0, 1
    move $a0, $t0                 #prints multiplier
    syscall 
    
    li $v0, 4
    la $a0, timesStr              #prints middle string
    syscall
    
    lh $t1, multiplicand
    lw $v0, Syscall_PrintInt
    move $a0, $t1
    syscall                       #prints multiplicand
    
    li $t2, 0                     #initializes product register to zero
    
    
    ##############  LOOP STRUCTURE  ################
    
    li $s0, 0
    li $s1, 16
    forLoop:
        addi $s0, $s0, 1
        slt $t3, $s0, $s1
        beq $t3, $zero, end
        j loopBody
    
    loopBody:
        andi $t4, $t0, 1          #takes first bit from multiplier
        bgtz $t4, innerLoop1      #if first bit is 1, jumps to innerloop1
        j shiftLoop
    
    innerLoop1:
        add $t2, $t2, $t1         #multiplicand is added to product in innerloop1
        j shiftLoop
    
    shiftLoop:
        move $t5, $t0
        move $t6, $t1
        sll $t1, $t6, 1
        srl $t0, $t5, 1
        j forLoop
        
    end:
    
    
    lw $v0, Syscall_PrintString
    la $a0, equalsStr            #prints equals string
    syscall
    
    lw $v0, Syscall_PrintInt
    move $a0, $t2
    syscall                       #prints result
    
    



    # Exit the Program
    li  $v0, 10
    syscall