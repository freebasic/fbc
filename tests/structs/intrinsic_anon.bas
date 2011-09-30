# include "fbcu.bi"

namespace fbc_tests.structs.intrinsic_anon

	type f
		as integer x
	end type
	
	sub test1 cdecl( )
		dim as integer z = type(1.5)
		CU_ASSERT_EQUAL( z, cint(1.5) )
	end sub
	
	sub test2 cdecl( )
		dim as integer y = type<typeof(type<typeof(y)>(1.5))>(3)
		CU_ASSERT_EQUAL( y, 3 )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.intrinsic_anon")
		fbcu.add_test("test1", @test1)
		fbcu.add_test("test2", @test2)
	
	end sub

end namespace
