.data
	pi: .double 3.141592653589793

.text
	.globl main

main:
	li $v0, 7
	syscall # radius <- user input

	la $a0, pi
	l.d $f12, 0($a0) 	# a := pi
	mul.d $f12, $f12, $f0	# a := a * r
	mul.d $f12, $f12, $f0	# a: a * r
	li $v0, 3		# print_double
	syscall			# print area

exit: