''
'' test for macros defined locally
''

	scope
		#define foo(x) x
		assert( foo(1) = 1 )
	end scope

	scope
		#define foo(x) x
		assert( foo(2) = 2 )
	end scope

sub test1
	#define foo(x) x
	assert( foo(3) = 3 )
end sub

sub test2
	#define foo(x) x
	assert( foo(4) = 4 )
end sub

	dim foo as integer = 5
	assert( foo = 5 )

	test1
	test2