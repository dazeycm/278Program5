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
out:	.asciiz	"The factorial (sum) of "
out2:	.asciiz " is "


	.text
	.globl main
main: 
	subi $sp, $sp, 60
	sw $ra, 4($sp)
	sw $fp, 8($sp)
	addi $fp, $sp, 56
	
	li $a0, 5
	li $a1, 10
	li $a2, 15
	li $a3, 20
	li $s1, 25
	
	jal sum
	
	sw $v0, 12($sp)	#store return value of sum
	
	la $a0, out
	li $v0, 4
	syscall
	
	move $a0, $s6	
	li $v0, 1	
	syscall		#THE FANCY THING WORKS!!!!
	
	la $a0, out2
	li $v0, 4
	syscall
	
	lw $v0, 12($sp)	#load value of sum
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	lw $ra, 4($sp)
	lw $fp, 8($sp)
	addi $fp, $sp, 56
	
	j exit		#time to leave town
	
	.text
sum:
	subu $sp, $sp, 32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	add $t1, $a0, $a1
	add $t1, $t1, $a2
	add $t1, $t1, $a3
	add $t1, $t1, $s1
	
	div $t1, $t1, 5
	move $a0, $t1
	jal factorial
	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
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
	move $s6, $v1	#trying to be fancy

	lw $ra, 20($sp)
	lw $fp, 16($sp)
	addi $sp, $sp, 32
		
	jr $ra
	
exit:
