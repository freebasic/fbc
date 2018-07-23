#include "fbcunit.bi"

SUITE( fbc_tests.numbers.tostring )

	TEST( single_ )
		dim as single v1, v2
		v1 = csng( 1.234567 )
		v2 = val( "1.234567" )
		CU_ASSERT( v1 = v2 )

		v1 =       1.234567f
		v2 = val( "1.234567" )
		CU_ASSERT( v1 = v2 )

		v1 =       1.234567890123456
		v2 = val( "1.234567890123456" )
		CU_ASSERT( v1 = v2 )

		dim s as string
		s = "2.5"
		v1 = 2.5f
		CU_ASSERT( str( v1   ) = s     )
		CU_ASSERT( str( v1   ) = "2.5" )
		CU_ASSERT( str( 2.5f ) = s     )
		CU_ASSERT( str( 2.5f ) = "2.5" )
		CU_ASSERT( csng( val( s     ) ) = v1   )
		CU_ASSERT( csng( val( s     ) ) = 2.5f )
		CU_ASSERT( csng( val( "2.5" ) ) = v1   )
		CU_ASSERT( csng( val( "2.5" ) ) = 2.5f )
	END_TEST

	TEST( double_ )
		dim as double v1, v2
		v1 =       1.234567890123456
		v2 = val( "1.234567890123456" )
		CU_ASSERT( v1 = v2 )

		dim s as string
		s = "2.5"
		v1 = 2.5
		CU_ASSERT( str( v1  ) = s     )
		CU_ASSERT( str( v1  ) = "2.5" )
		CU_ASSERT( str( 2.5 ) = s     )
		CU_ASSERT( str( 2.5 ) = "2.5" )
		CU_ASSERT( val( s     ) = v1  )
		CU_ASSERT( val( s     ) = 2.5 )
		CU_ASSERT( val( "2.5" ) = v1  )
		CU_ASSERT( val( "2.5" ) = 2.5 )
	END_TEST

END_SUITE
