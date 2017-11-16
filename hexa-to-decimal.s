#1. Taking user input 
#2.1 Iterate over the string. 
#2.2 Make sure the strings contain '0' to '9', 'a' to 'f', 'A' to 'F'. If the string is valid, go to step 3, else throw a message "Invalid hexadecimal number"
#3. If string is valid: 
#3.1 Convert the hexadecimal to decimal. For eg: if string, s = "0af34e" 
# decimal(s) = 0 * 16^5 + 10 * 16^4 + 15 * 16^3 + 3 * 16^2 + 4 * 16^1 + 14 * 16^0 
#4 store it to a register and print out the value 

.data
	valid_array: .space 32
	max_input: .space 9
	error: .asciiz "\nInvalid Hexadecimal number"
	newline: .asciiz "\n"
	message: .asciiz "\nDone"
.text
main:
	#defining some "constants" required later 
	add $t8, $zero, 10000
	add $t7, $zero, 16

	#taking the input from the user
	li $v0, 8  
    la $a0, max_input
    li $a1, 9
    syscall
    
    add $t0, $zero, 0 #iterator for the iterate loop
    la $s0, max_input #loading max_input to $s0
    
    #checking if the input is valid
    add $t9, $zero, 0 #counter
    iterate: 
    	add $s1, $s0, $t0   
    	lb $s2, 0($s1)     #loading  
    	
    	#terminating the loop
    	beq $s2, $zero, convert   
    	beq $s2, 10, convert
    	addi $t0, $t0, 1 #iterator++
    	
    	beq $s2, 32, iterate

    	#checking if the number is in 0-9, a-f, A-F
		sub $s3, $s2, 48 
		blt $s3, 0, exit
		blt $s3, 10, store
		sub $s3, $s3, 7
		blt $s3, 10, exit
		blt $s3, 16, store
		sub $s3, $s3, 32
		blt $s3, 10, exit
		blt $s3, 16, store
		bgt $s3, 15, exit
		
    	#addi $t0, $t0, 1 #iterator++
    	
    	j iterate
   	
    store: 
    	# la $a0, convert_section
    	# addi $v0, $zero, 4
    	# syscall
        #storing the valid digits to an array
    	sw $s3, valid_array($t4)
        bgt $t4, 32, exit3
    	add $t4, $t4, 4 #iterator $t4 += 4

    	# move $a0, $s3
    	# addi $v0, $zero, 1
    	# syscall
    	j iterate
    
    bgt $t9, $zero, exit
    add $t1, $zero, 0 #iterator 
    add $t5, $zero, 0 #sum
    convert: 
        blt $t4, $zero, exit3
        sub $t4, $t4, 4
        lw $s4, valid_array($t4)

        add $t2, $zero, 1 #16^x
        add $t6, $zero, 0
        loop2: 
            beq $t1, $t6, out
            multu $t2, $t7
            mflo $t2
            add $t6, $t6, 1
            j loop2
            
        out: 
        	add $t1, $t1, 1
            multu $s4, $t2
            mflo $s4
            addu $t5, $t5, $s4
            divu $t5, $t8
			mflo $s5
			mfhi $s6
            j convert

    exit:
        la $a0, error
        addi $v0, $zero, 4
        syscall 
	exit3:	
		# div $t5, $t8
		# mflo $s5
		# mfhi $s6
		
		la $a0, newline
		li $v0, 4
		syscall
		li $v0, 1 
		addi $a0, $s5, 0
		syscall 
		li $v0, 1 
		addi $a0, $s6, 0
		syscall 
		
    
