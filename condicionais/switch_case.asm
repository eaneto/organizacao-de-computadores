#
# Edison A. Neto
#

.data
jTable: .word L0, L1, L2, L3
a: .word 1 3 5 7 9

.text

# Variáveis
li $s1, 15
li $s2, 20
li $s3, 10
li $s4, 5
li $s5, 3
la $s6, a
la $t4, jTable

# Verificação dos limites de K
slt $t3, $s5, $zero
bne $t3, $zero, EXIT
slti $t3, $s5, 4
beq $t3, $zero, EXIT

# Cálculo do endereço correto do label
sll $t1, $s5, 2
add $t1, $t1, $t4
lw $t0, 0($t1)

# Seleção do label
jr $t0

# Cases

# If
L0:	li $t0, 1
	lw $t1, 0($s6)
	beq $t0, $t1, IF
	j EXIT

# If/Else
L1:	lw $t0, 0($s6)
	li $t1, 2
	bne $t0, $t1, ELSE
	addi $t0, $t1, 2
	j EXIT

# While
L2:	li $t0, 1
	li $t1, 100
	j WHILE

WHILE:	beq $t0, $t1, EXIT
	addi $t0, $t0, 1
	j WHILE

# Do/while
L3:	li $t0, 90
	li $t1, 10
	j DOWHILE

DOWHILE:
	subi $t0, $t0, 1
	beq $t0, $t1, EXIT
	j DOWHILE
		
IF:	add $s0, $s3, $s4
	j EXIT
	
ELSE:	sub $s0, $s1, $s2
	j EXIT

EXIT:
