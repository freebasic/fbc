# include "fbcunit.bi"

SUITE( fbc_tests.dim_.redim_param )
	
	sub foo ( b() as integer )
		redim b(1)
	end sub

	TEST( ok_to_redim_array_params )
		dim as integer b( )
		foo( b() )

		CU_ASSERT_EQUAL( 1, ubound(b) )
	END_TEST

END_SUITE
