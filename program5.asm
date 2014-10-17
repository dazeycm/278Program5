#subi $sp, $sp, 40 	#40 is size of stack frame
#sw $ra, 4($sp) 		#store return addressin stack frame
#sw $fp, 8($sp)		#store frame pointer in stack frame -- will be stored at bottom of stack frame
#addi $fp, $sp, 36	#puts frame pointer at top of stack

#sw $t1, 20($sp)		#stores temp registers in stack
#sw $t2, 16($sp)
#sw $t3, 12($sp)

#can then call the function and freely use the temp registers

	.text
main: 
	subi $sp, $sp, 60
	sw $ra, 4($sp)
	sw $fp, 8($sp)
	addi $fp, $sp, 56
	
	li $s0, 5
	li $s1, 10
	li $s2, 15
	li $s3, 20
	li $s4, 25
	
	sw $s0, 12($sp)
	sw $s1, 16($sp)
	sw $s2, 20($sp)
	sw $s3, 24($sp)
	sw $s4, 28($sp)
	
	
	
	