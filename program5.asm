#subi $sp, $sp, 40 	#40 is size of stack frame
#sw $ra, 4($sp) 		#store return addressin stack frame
#sw $fp, 8($sp)		#store frame pointer in stack frame -- will be stored at bottom of stack frame
#addi $fp, $sp, 36	#puts frame pointer at top of stack

#sw $t1, 20($sp)		#stores temp registers in stack
#sw $t2, 16($sp)
#sw $t3, 12($sp)

#can then call the function and freely use the temp registers

#store number bigget than 32 bit allows
#need to restore ra and fp in main method?
#should the local variables be stored in S? (currently stored in temp memory) If this is yes, then I should put the result of sum in an S registed too

	.data
#out:	.asciiz	"The factorial (sum) of "
#out2:	.asciiz " is "


	.text
	.globl main
main: 
	subi $sp, $sp, 60
	sw $ra, 4($sp)
	sw $fp, 8($sp)
	addi $fp, $sp, 56
	
	sw $s0, 12($sp)		#store old s register values
	sw $s1, 16($sp)
	sw $s2, 20($sp)
	sw $s3, 24($sp)
	sw $s4, 28($sp)
	
	li $s0, 5		#load new variables into s registers
	li $s1, 10
	li $s2, 15
	li $s3, 20
	li $s4, 25
	
	move $a0, $s0		#move s registers into argument registers
	move $a1, $s1
	move $a2, $s2
	move $a3, $s3
	
	jal sum			#go to sum
	
	sw $v0, 12($sp)		#store return value of sum
	
	li $t0, 'T'		#store chars into memory
	sb $t0, 44($sp)  
	li $t0, 'h'
	sb $t0, 45($sp)
	li $t0, 'e'
	sb $t0, 46($sp)
	li $t0, ' '
	sb $t0, 47($sp)
	li $t0, 's'
	sb $t0, 48($sp)
	li $t0, 'u'
	sb $t0, 49($sp)
	li $t0, 'm'
	sb $t0, 50($sp)
	li $t0, ' '
	sb $t0, 51($sp)
	li $t0, 'i'
	sb $t0, 52($sp)
	li $t0, 's'
	sb $t0, 53($sp)
	li $t0, ' '
	sb $t0, 54($sp)
	sb $zero, 58($sp)
	
	li $v0, 4		#print char string
	la $a0, 44($sp)
	syscall
	
	lw $v0, 12($sp)		#load value of sum
	
	move $a0, $v0		#print sum
	li $v0, 1
	syscall
	
	lw $ra, 4($sp)
	lw $fp, 8($sp)
	addi $fp, $sp, 56
	
	lw $s0, 12($sp) 	#reload old s registers
	lw $s1, 16($sp)
	lw $s2, 20($sp)
	lw $s3, 24($sp)
	lw $s4, 28($sp)
	
	j exit			#time to leave town
	
sum:
	subu $sp, $sp, 32
	sw $ra, 28($sp)
	sw $fp, 24($sp)
	addi $fp, $sp, 28
	
	sw $a0, 0($sp) 		#store variables we're passing
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $s4, 16($sp)
	
	add $t1, $a0, $a1	#calculate total
	add $t1, $t1, $a2
	add $t1, $t1, $a3
	add $t1, $t1, $s4
	
	div $t1, $t1, 5	
	sw $t1, 20($sp)		#store the total to be factorial'd
	move $a0, $t1		
	jal factorial
	
	lw $ra, 28($sp)
	lw $fp, 24($sp)
	addi $sp, $sp, 32
	
	jr $ra

factorial: 			#using frame pointer to move around stack frame (not that it matters)
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	sw $a0, 0($fp)
	
	lw $v0, 0($fp)
	bgtz $v0, L2
	li $v0, 1
	
	j L1
	
L2:
	lw $v1, 0($fp)
	subi $v0, $v1, 1
	move $a0, $v0
	jal factorial
	
	lw $v1, 0($fp)
	mul $v0, $v0, $v1
	
L1:
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addi $sp, $sp, 32
		
	jr $ra
	
exit:
