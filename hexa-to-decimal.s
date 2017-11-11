#1. Taking user input 
#2.1 Iterate over the string. 
#2.2 Make sure the strings contain '0' to '9', 'a' to 'f', 'A' to 'F'. If the string is valid, go to step 3, else throw a message "Invalid hexadecimal number"
#3. If string is valid: 
#3.1 Convert the hexadecimal to decimal. For eg: if string, s = "0af34e" 
# decimal(s) = 0 * 16^5 + 10 * 16^4 + 15 * 16^3 + 3 * 16^2 + 4 * 16^1 + 14 * 16^0 
#4 store it to a register and print out the value 

.data 
    prompt: .asciiz "Enter a hexa decimal number: " 
.text
    #prompt the user for input
    la $s0, prompt
    li $t0, 0 #iterator
loop:
    bgt $t0, 15, exit 
    addi $t0, $t0, 1
    add $s1, $s0, $t0
    li $v0 1
    syscall 

    j loop
exit: 
