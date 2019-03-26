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
j exit

sum:
	li $t0, 0
	li $t1, 7
	la $s0, ($a0)
while:
    beq $t0, $t1, done
	addi $s0, $s0, 4
	lw $t3, 0($s0)
	add $t2, $t2, $t3
	addi $t0, $t0, 1
	j while
	
done:
	jr $ra

exit: