
'' test for implicit vars with same name as structs

type foo
	bar as integer
end type

	foo = 5678
	
	dim f as foo = ( 1234 )

	assert( f.bar = 1234 )
	assert( foo = 5678 )