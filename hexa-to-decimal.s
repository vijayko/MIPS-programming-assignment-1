#1. Taking user input 
#2.1 Iterate over the string. 
#2.2 Make sure the strings contain '0' to '9', 'a' to 'f', 'A' to 'F'. If the string is valid, go to step 3, else throw a message "Invalid hexadecimal number"
#3. If string is valid: 
#3.1 Convert the hexadecimal to decimal. For eg: if string, s = "0af34e" 
# decimal(s) = 0 * 16^5 + 10 * 16^4 + 15 * 16^3 + 3 * 16^2 + 4 * 16^1 + 14 * 16^0 
#4 store it to a register and print out the value 

.data 
	array: .space 32
	newline: .asciiz "\n"
.text
	add $t0, $zero, 0 #index of the array
	add $t1, $zero, 0 #index for the 16s
	add $s0, $zero, 0 #total sum 
	add $t7, $zero, 16
	
	
	loop0:
		beq $t0, 32, exit0
		li $v0, 5
		syscall 
		
		move $t5, $v0
		sw $t5, array($t0)
		add $t0, $t0, 4  
		
		j loop0
	exit0: 
	add $t0, $zero, 0
	loop1: 
		beq $t0, 32, exit1
		add $t6, $zero, 0 #counter for inner loop 
		add $t4, $zero, 1 #temp value for 16^x 
		
		loop2: 
			beq $t1, $t6, exit2 
			mult $t4, $t7
			mflo $t4
			add $t6, $t6, 1 #increasing the inner counter 
			
			j loop2
		exit2:
		add $t1, $t1, 1
		lw $t3, array($t0)
		li $v0, 1 
		addi $a0, $t3, 0 
		syscall
		
		li $v0, 4 
		la $a0, newline
		syscall
		
		mult $t3, $t4 
		mflo $t3 
		add $s0, $s0, $t3
		
		li $v0, 1 
		addi $a0, $s0, 0
		syscall
		li $v0, 4 
		la $a0, newline
		syscall
		add $t0, $t0, 4
		j loop1
	exit1:
	li $v0, 1 
	addi $a0, $s0, 0
	syscall 
	
	li $v0, 10 
	syscall 
	
