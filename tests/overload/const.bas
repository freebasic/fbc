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

	dim shared axlong(1 to ...) as long = {1, 2}
	dim shared axlongint(1 to ...) as longint = {1, 2}
	dim shared axinteger(1 to ...) as integer = {1, 2}
	dim shared axsingle(1 to ...) as single = {1.0f, 2.0f}
	dim shared axdouble(1 to ...) as double = {1.0, 2.0}

	dim shared axconstlong(1 to ...) as const long = {1, 2}
	dim shared axconstlongint(1 to ...) as const longint = {1, 2}
	dim shared axconstinteger(1 to ...) as const integer = {1, 2}
	dim shared axconstsingle(1 to ...) as const single = {1.0f, 2.0f}
	dim shared axconstdouble(1 to ...) as const double = {1.0, 2.0}

	dim shared axconstbyte(1 to ...) as const byte = {1, 2}

	TEST_GROUP( array )

		function f overload( x() as integer ) as string : function = "integer" : end function
		function f overload( x() as longint ) as string : function = "longint" : end function
		function f overload( x() as single  ) as string : function = "single"  : end function
		function f overload( x() as double  ) as string : function = "double"  : end function
		function f overload( x() as long    ) as string : function = "long"    : end function

		TEST( non_const_array )
			CU_ASSERT( f( axlong()    ) = "long"    )
			CU_ASSERT( f( axlongint() ) = "longint" )
			CU_ASSERT( f( axinteger() ) = "integer" )
			CU_ASSERT( f( axsingle()  ) = "single"  )
			CU_ASSERT( f( axdouble()  ) = "double"  )
		END_TEST

		function fc overload( x() as const integer ) as string : function = "integer" : end function
		function fc overload( x() as const longint ) as string : function = "longint" : end function
		function fc overload( x() as const single  ) as string : function = "single"  : end function
		function fc overload( x() as const double  ) as string : function = "double"  : end function
		function fc overload( x() as const long    ) as string : function = "long"    : end function

		TEST( const_array )
			CU_ASSERT( fc( axlong()    ) = "long"    )
			CU_ASSERT( fc( axlongint() ) = "longint" )
			CU_ASSERT( fc( axinteger() ) = "integer" )
			CU_ASSERT( fc( axsingle()  ) = "single"  )
			CU_ASSERT( fc( axdouble()  ) = "double"  )
			CU_ASSERT( fc( axconstlong()    ) = "long"    )
			CU_ASSERT( fc( axconstlongint() ) = "longint" )
			CU_ASSERT( fc( axconstinteger() ) = "integer" )
			CU_ASSERT( fc( axconstsingle()  ) = "single"  )
			CU_ASSERT( fc( axconstdouble()  ) = "double"  )
		END_TEST

	END_TEST_GROUP

	TEST_GROUP( array )

		'' base test using scalars
		function f0 overload( byref a as integer, byval x as integer ) as string
			function = "integer, integer"
		end function
		function f0 overload( byref a as integer, byval x as double ) as string
			function = "integer, double"
		end function

		function f1 overload( byref a as const integer, byval x as integer ) as string
			function = "const integer, integer"
		end function
		function f1 overload( byref a as const integer, byval x as double ) as string
			function = "const integer, double"
		end function

		'' array() tests
		function f2 overload( a() as integer, byval x as integer ) as string
			function = "() const integer, integer"
		end function
		function f2 overload( a() as integer, byval x as double ) as string
			function = "() const integer, double"
		end function

		function f3 overload( a() as const integer, byval x as integer ) as string
			function = "() const integer, integer"
		end function
		function f3 overload( a() as const integer, byval x as double ) as string
			function = "() const integer, double"
		end function

		function f4 overload( a() as integer, byval x as integer ) as string
			function = "() integer, integer"
		end function
		function f4 overload( a() as const integer, byval x as double ) as string
			function = "() const integer, double"
		end function

		function f5 overload( a() as const integer, byval x as integer ) as string
			function = "() const integer, integer"
		end function
		function f5 overload( a() as integer, byval x as double ) as string
			function = "() integer, double"
		end function

		TEST( array_number )

			dim a(1 to ... ) as integer = {1, 2}
			dim ca( 1 to ...) as const integer = {1, 2}
			dim i as integer, ci as const integer = 1
			dim d as double

			CU_ASSERT( f0( i, i ) = "integer, integer" )
			CU_ASSERT( f0( i, d ) = "integer, double" )
			
			CU_ASSERT( f1( ci, i ) = "const integer, integer" )
			CU_ASSERT( f1( ci, d ) = "const integer, double" )

			CU_ASSERT( f2(  a(), i ) = "() const integer, integer" )
			CU_ASSERT( f2(  a(), d ) = "() const integer, double" )

			CU_ASSERT( f3(  a(), i ) = "() const integer, integer" )
			CU_ASSERT( f3( ca(), i ) = "() const integer, integer" )
			CU_ASSERT( f3(  a(), d ) = "() const integer, double" )
			CU_ASSERT( f3( ca(), d ) = "() const integer, double" )

			CU_ASSERT( f4(  a(), i ) = "() integer, integer" )
			CU_ASSERT( f4( ca(), i ) = "() const integer, double" )
			CU_ASSERT( f4(  a(), d ) = "() const integer, double" )
			CU_ASSERT( f4( ca(), d ) = "() const integer, double" )

			CU_ASSERT( f5(  a(), i ) = "() const integer, integer" )
			CU_ASSERT( f5( ca(), i ) = "() const integer, integer" )
			CU_ASSERT( f5(  a(), d ) = "() integer, double" )
			CU_ASSERT( f5( ca(), d ) = "() const integer, integer" )

		END_TEST

	END_TEST_GROUP

END_SUITE
