.data

decimo: .float 0.1
centesimo: .float 0.01
epsilon: .float 1.0e-7

.text
la $a0, decimo
la $a1, centesimo
la $a2, epsilon

l.s $f0, ($a0)
l.s $f1, ($a1)
l.s $f1, ($a2)

mul.s $f0, $f0, $f0	# $f0 := 0.1 * 0.1
sub.s $f3, $f0, $f1	# $f3 := (0.1 * 0.1) - 0.01
abs.s $f3, $f3		# $f3 := |(0.1 * 0.1) - 0.01|
c.lt.s 6 $f3, $f2	# flag 6 = $f3 < 1.0e-7 ?

bc1f 6 not_quite	# if(not flag6) goto not_quite

not_quite: