# include "fbcu.bi"




namespace fbc_tests.compound.scope_array

const TEST_1 = -1
const TEST_2 = -2
const TEST_3 = -3

type bar
	a as short
	b as integer
	c as single
end type
	
declare sub proc ()

	dim shared array(0 to 3) as bar = { (TEST_1) }
	
sub test_scope_array cdecl ()

	scope		
		scope 
			dim array(0 to 3) as bar = { (TEST_2) }
			scope
				CU_ASSERT_EQUAL( array(0).a, TEST_2 )
			end scope
		end scope
		CU_ASSERT_EQUAL( array(0).a, TEST_1 )
	end scope
	
	scope		
		scope
			scope
				dim array(0 to 3) as bar = { (TEST_3) }
			end scope
			CU_ASSERT_EQUAL( array(0).a, TEST_1 )
		end scope
	end scope
	
	proc()
	
	CU_ASSERT_EQUAL( array(0).a, TEST_1 )
	
end sub

''::::
sub proc ()

	scope		
		scope 
			dim array(0 to 3) as bar = { (TEST_2) }
			scope
				CU_ASSERT_EQUAL( array(0).a, TEST_2 )
			end scope
		end scope
		CU_ASSERT_EQUAL( array(0).a, TEST_1 )
	end scope
	
	scope		
		scope
			scope
				dim array(0 to 3) as bar = { (TEST_3) }
			end scope
			CU_ASSERT_EQUAL( array(0).a, TEST_1 )
		end scope
	end scope
	
	CU_ASSERT_EQUAL( array(0).a, TEST_1 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.scoped_array")
	fbcu.add_test("test scope array", @test_scope_array)
	
end sub

end namespace
