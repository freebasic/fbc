''
'' Fixed-size arrays:
''
	dim a(0 to 9) as integer '' 10 elements
	dim b(9) as integer      '' 10 elements (default lower bound is 0)
	dim c(5 to 6) as integer '' 2 elements

	print lbound(a), ubound(a)
	print lbound(b), ubound(b)
	print lbound(c), ubound(c)

''
'' Dynamic arrays (up to 2 GB in size):
''
	dim d() as integer '' empty array

	redim d(1 to 10)   '' allocate memory for the array
	redim preserve d(1 to 20) '' to resize the array while keeping its contents

	print lbound(d), ubound(d)

	erase d            '' free the array's memory

''
'' Multiple dimensions (up to 8 supported):
''
	dim matrix(0 to 3, 0 to 3, 0 to 3, 0 to 3) as integer
	print matrix(0, 0, 0, 0)

''
'' Array fields:
'' (Note: Dynamic arrays are currently not allowed in UDTs,
'' only fixed-size ones)
''
	type MyType
		foo(0 to 9) as integer
	end type

	dim x as MyType
	print lbound(x.foo), ubound(x.foo)

''
'' Passing arrays to procedures:
''
	sub fillWithSomeData( array() as integer )
		for i as integer = lbound(array) to ubound(array)
			array(i) = i
		next
	end sub

	sub printArrayData( array() as integer )
		for i as integer = lbound(array) to ubound(array)
			print array(i);" ";
		next
		print
	end sub

	fillWithSomeData( a() )
	fillWithSomeData( c() )

	printArrayData( a() )
	printArrayData( c() )
