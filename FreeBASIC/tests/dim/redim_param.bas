# include "fbcu.bi"

namespace fbc_tests.dim_.redim_param
	
	sub foo ( b() as integer )
		redim b(1)
	end sub

	sub bar cdecl( )
		dim as integer b( )
		foo( b() )

		CU_ASSERT_EQUAL( 1, ubound(b) )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fbc_tests.dim.redim_param")
		fbcu.add_test("ok_to_redim_array_params", @bar)
	end sub

end namespace
