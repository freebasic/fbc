# include "fbcu.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

namespace fbc_tests.boolean_.ptr_

	''
	sub test1 cdecl ( )

		dim as boolean i
		dim as boolean ptr b = @i

		i =  0: CU_ASSERT_EQUAL( *b, cbool(i) )
		i =  1: CU_ASSERT_EQUAL( *b, cbool(i) )
		i =  2: CU_ASSERT_EQUAL( *b, cbool(i) )
		i = -1: CU_ASSERT_EQUAL( *b, cbool(i) )

	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.boolean.boolean_ptr")
		fbcu.add_test("test1", @test1)
		
	end sub
	
end namespace
