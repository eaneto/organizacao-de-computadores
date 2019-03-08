.data
a: .word 0,1,2,3,4,5
b: .word 1
c: .word 0,1,2,3,4,5
x: .word 1
y: .word 2

.text
la $s0,a
la $s1,b
la $s2,c
la $s3,x
la $s4, y

beq $s3, $s4, L2

sub $t0, $s0, $s1
sw $t0, 1($s0)

lw $t0, 2($s0)
add $t1, $t0, $s2
sw $t1, 2($s0)

lw $t0, 3($s2)
add $t1, $s1, $t0
sw $t1, 3($s2)

L2:
	lw $t0, 4($s0)
	lw $t1, 4($s0)
	lw $t2, 4($s0)
	sw $t0, $t1, $t2
