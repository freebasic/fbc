option explicit

type foo1
	a as integer
	b as integer
end type

type foo2
	a as integer
	b as integer
	c as integer
end type

function bar overload (byref x as foo1) as foo1
	
	function = type<foo1>( x.a, x.b )
	
end function

function bar (byref x as foo2) as foo1
	
	function = type<foo1>( x.a, x.b )
	
end function

''
const TEST1_A = 1, TEST1_B = 2
const TEST2_A = 3, TEST2_B = 4, TEST2_C = 3
	
	dim as foo1 res
	
	res = bar( type<foo1>( TEST1_A, TEST1_B ) )
	assert( res.a = TEST1_A and res.b = TEST1_B )
	
	res = bar( type<foo2>( TEST2_A, TEST2_B, TEST2_C ) )
	assert( res.a = TEST2_A and res.b = TEST2_B )
	
