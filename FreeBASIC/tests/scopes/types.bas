''
'' test for UDT's declared locally
''

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678
const TEST_VAL3 = &hdeadbeef
const TEST_VAL4 = &hdeadc0de
		
type foo
	bar as integer
end type

	scope
		type baz
			f as foo
		end type
		
		type baz_alias as baz
		
		dim b as baz_alias = ( ( TEST_VAL1 ) )
		
		assert( b.f.bar = TEST_VAL1 )
	end scope
		
	scope
		type baz
			f as foo
		end type
		
		type baz_alias as baz
		
		dim b as baz_alias = ( ( TEST_VAL2 ) )
		
		assert( b.f.bar = TEST_VAL2 )
	end scope
	
sub test1
	type baz
		f as foo
	end type
		
	type baz_alias as baz
		
	dim b as baz_alias = ( ( TEST_VAL3 ) )
		
	assert( b.f.bar = TEST_VAL3 )
end sub
		
sub test2
	type baz
		f as foo
	end type
		
	type baz_alias as baz
		
	dim b as baz_alias = ( ( TEST_VAL4 ) )
		
	assert( b.f.bar = TEST_VAL4 )
end sub
	
	test1
	test2