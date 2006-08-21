# include "fbcu.bi"




'//
'// test for UDT's declared locally
'//

namespace fbc_tests.scopes.types

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678
const TEST_VAL3 = &hdeadbeef
const TEST_VAL4 = &hdeadc0de
		
type foo
	bar as integer
end type

sub test_1 cdecl ()
	type baz
		f as foo
	end type
		
	type baz_alias as baz
		
	dim b as baz_alias = ( ( TEST_VAL3 ) )
		
	CU_ASSERT( b.f.bar = TEST_VAL3 )
end sub
		
sub test_2 cdecl ()
	type baz
		f as foo
	end type
		
	type baz_alias as baz
		
	dim b as baz_alias = ( ( TEST_VAL4 ) )
		
	CU_ASSERT( b.f.bar = TEST_VAL4 )
end sub

sub test_3 cdecl ()
	scope
		type baz
			f as foo
		end type
		
		type baz_alias as baz
		
		dim b as baz_alias = ( ( TEST_VAL1 ) )
		
		CU_ASSERT( b.f.bar = TEST_VAL1 )
	end scope
		
	scope
		type baz
			f as foo
		end type
		
		type baz_alias as baz
		
		dim b as baz_alias = ( ( TEST_VAL2 ) )
		
		CU_ASSERT( b.f.bar = TEST_VAL2 )
	end scope
end sub
	
sub ctor () constructor

	fbcu.add_suite("fbc_tests.scopes.types")
	fbcu.add_test("test 1", @test_1)
	fbcu.add_test("test 2", @test_2)
	fbcu.add_test("test 3", @test_3)

end sub

end namespace
