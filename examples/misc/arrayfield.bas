''
'' static field arrays test
''

type t
	a(3) as integer
	b as integer
	c(3) as string * 4
end type

redim x(10) as t
dim y as t

declare sub foo( array() as integer )
declare sub bar( array() as t )

	for i as integer = 0 to 3
		x(10).a(i) = i
		y.a(i) = 3-i
	next i
		
	x(10).c(3) = "abcd"
	
	foo x(10).a()

	foo y.a()
	
	bar x()
	
	print lbound( y.a ); ubound( y.a )
	
	print lbound( x(10).a ); ubound( x(10).a )
	
	sleep
	

'':::::
sub foo( array() as integer )

	for i as integer = 0 to 3
		print array(i);
	next i
	print

end sub

'':::::
sub uppercaseme( byref s as string )

	s = ucase( s )

end sub

'':::::
sub bar( array() as t )
	
	dim as integer i, a
	
	i = 10
	a = 3
	
	foo array(i).a()
	
	'' array + array fields + fix-len strings 
	uppercaseme array(i).c(a)

	print array(i).c(a)

end sub
