''
'' test for enums defined locally
''

	scope
		enum foo: foo_val = 1: end enum
		assert( foo_val = 1 )
	end scope

	scope
		enum foo: foo_val = 2: end enum
		assert( foo_val = 2 )
	end scope

sub test1
	enum foo: foo_val = 3: end enum
	assert( foo_val = 3 )
end sub

sub test2
	enum foo: foo_val = 4: end enum
	assert( foo_val = 4 )
end sub

	dim foo as integer = 5
	assert( foo = 5 )

	test1
	test2