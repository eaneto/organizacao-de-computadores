.data
a: .word 0,1,2,3
b: .word 4
c: .word 5,6,7,8
x: .word 9
y: .word 10

.text
la $s0,a
la $s1,b
la $s2,c
la $s3,x
la $s4, y

lw $t0, 0($s3)
lw $t1, 0($s4)

beq $t0, $t1, L0
slt $t2, $t0, $t1
beq $t2, $0, done

add $t0, $t0, $t1
sw $t0, 0($s3)
j L1

L0:
	lw $t0, 0($s0)

L1:
	lw $t0, 0($s1)

done:
