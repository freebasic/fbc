#include "fbcunit.bi"

SUITE( fbc_tests.overload_.const_ )

	dim shared xlong as long
	dim shared xlongint as longint
	dim shared xinteger as integer
	dim shared xsingle as single
	dim shared xdouble as double

	dim shared xconstlong as const long = 1
	dim shared xconstlongint as const longint = 1
	dim shared xconstinteger as const integer = 1
	dim shared xconstsingle as const single = 1.0f
	dim shared xconstdouble as const double = 1.0

	TEST_GROUP( integer_single )
		function f overload( byval x as integer ) as string : function = "integer" : end function
		function f overload( byval x as single  ) as string : function = "single"  : end function

		TEST( default )
			CU_ASSERT( f( xlong    ) = "integer" )
			CU_ASSERT( f( xlongint ) = "integer" )
			CU_ASSERT( f( xinteger ) = "integer" )
			CU_ASSERT( f( xsingle  ) = "single"  )
			CU_ASSERT( f( xdouble  ) = "single"  )
			CU_ASSERT( f( xconstlong    ) = "integer" )
			CU_ASSERT( f( xconstlongint ) = "integer" )
			CU_ASSERT( f( xconstinteger ) = "integer" )
			CU_ASSERT( f( xconstsingle  ) = "single"  )
			CU_ASSERT( f( xconstdouble  ) = "single"  )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( integer_double )
		function f overload( byval x as integer ) as string : function = "integer" : end function
		function f overload( byval x as double  ) as string : function = "double"  : end function

		TEST( default )
			CU_ASSERT( f( xlong    ) = "integer" )
			CU_ASSERT( f( xlongint ) = "integer" )
			CU_ASSERT( f( xinteger ) = "integer" )
			CU_ASSERT( f( xsingle  ) = "double"  )
			CU_ASSERT( f( xdouble  ) = "double"  )
			CU_ASSERT( f( xconstlong    ) = "integer" )
			CU_ASSERT( f( xconstlongint ) = "integer" )
			CU_ASSERT( f( xconstinteger ) = "integer" )
			CU_ASSERT( f( xconstsingle  ) = "double"  )
			CU_ASSERT( f( xconstdouble  ) = "double"  )
		END_TEST
	END_TEST_GROUP

END_SUITE
