''
'' test for constants defined locally
''

	scope
		const foo = 1
		assert( foo = 1 )
	end scope

	scope
		const foo = 2
		assert( foo = 2 )
	end scope

sub test1
	const foo = 3
	assert( foo = 3 )
end sub

sub test2
	const foo = 4
	assert( foo = 4 )
end sub

	dim foo as integer = 5
	assert( foo = 5 )

	test1
	test2