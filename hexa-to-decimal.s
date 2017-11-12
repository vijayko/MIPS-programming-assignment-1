#1. Taking user input 
#2.1 Iterate over the string. 
#2.2 Make sure the strings contain '0' to '9', 'a' to 'f', 'A' to 'F'. If the string is valid, go to step 3, else throw a message "Invalid hexadecimal number"
#3. If string is valid: 
#3.1 Convert the hexadecimal to decimal. For eg: if string, s = "0af34e" 
# decimal(s) = 0 * 16^5 + 10 * 16^4 + 15 * 16^3 + 3 * 16^2 + 4 * 16^1 + 14 * 16^0 
#4 store it to a register and print out the value 

.data
	array: .word 4:6
.text 
	#index 
	add $t0, $zero, 0
	add $t1, $zero, 0
	add $s0, $zero, 0
	while: 
		bne $t0, 24, exit
		
		lw $t6, array($t0)
		add $t3, $zero, 0
		add $t4, $zero, 16
		add $t2, $zero, 16
		innerLoop:
			bne $t3, $t1, exit2 
			mult $t2, $t2
			mflo $t2
			j innerLoop
		exit2: 
		add $t0, $t0, 4
		add $t1, $t1, 1
		j while 
	exit: 
