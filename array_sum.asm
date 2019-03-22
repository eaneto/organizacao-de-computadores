#
# Edison A. Neto
#

.data
v: .word 0 1 2 3 4 5 6

.text
la $a0, v
la $a1, 0($a0)
la $a2, 0($a0)
jal sum

sum:
	li $t0, 0
	li $t1, 7
	la $s0, ($a0)
while:	beq $t0, $t1, done
	addi $s0, $s0, 4
	lw $t3, 0($s0)
	add $t2, $t2, $t3
	addi $t0, $t0, 1
	j while
	
done:
	jr $ra

#li $a0, 15 # g = $a0 = 15
#li $a1, 20 # h = $a1 = 20
#li $a2, 10 # i = $a1 = 10
#li $a3, 5  # j = $a3 = 5

#addi $sp, $sp, -12
#sw $t1, 8($sp)
#sw $t0, 4($sp)
#sw $s0, 0($sp)

#add $t0, $a0, $a1
#add $t1, $a2, $a3
#sub $s0, $t0, $t1
#add $v0, $s0, $zero

#lw $s0, 0($sp)
#lw $t0, 4($sp)
#lw $t1, 8($sp)
#addi $sp, $sp, 12

#jr $ra