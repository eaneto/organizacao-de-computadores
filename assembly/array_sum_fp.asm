#
# Edison A. Neto
#

.data
v: .float 1.12 2.456 3.346 4.978 5.851 6.719
size: .float 6

.text
la $a0, v
jal sum

j exit

sum:
	li $t0, 0
	li $t1, 6
	la $s0, ($a0)
while:
    	beq $t0, $t1, done
	addi $s0, $s0, 4
	l.s $f0, 0($s0)
	add.s $f1, $f1, $f0
	addi $t0, $t0, 1
	j while
	
	done:
		la $s0, size
		l.s $f3, 0($s0)
		div.s $f1, $f1, $f2
		cvt.w.s $f0, $f1
		mfc1 $t0, $f0
		move $v0, $t0
		jr $ra

exit:
