#include "fbcunit.bi"

SUITE( fbc_tests.overload_.bydesc )

	TEST_GROUP( simple )
		enum RESULT
			RESULT_ARRAY_INT
			RESULT_ARRAY_UINT
			RESULT_ARRAY_SINGLE
			RESULT_ARRAY_INTPTR
			RESULT_SCALAR_INT
			RESULT_SCALAR_UINT
			RESULT_SCALAR_SINGLE
			RESULT_SCALAR_INTPTR
		end enum

		function proc overload ( array() as integer ) as RESULT
			function = RESULT_ARRAY_INT
		end function

		function proc ( array() as uinteger ) as RESULT
			function = RESULT_ARRAY_UINT
		end function

		function proc ( array() as single ) as RESULT
			function = RESULT_ARRAY_SINGLE
		end function

		function proc ( array() as integer ptr ) as RESULT
			function = RESULT_ARRAY_INTPTR
		end function

		function proc ( byval scalar as integer )  as RESULT
			function = RESULT_SCALAR_INT
		end function 

		function proc ( byval scalar as uinteger )  as RESULT
			function = RESULT_SCALAR_UINT
		end function 

		function proc ( byval scalar as single )  as RESULT
			function = RESULT_SCALAR_SINGLE
		end function 

		function proc ( byval scalar as integer ptr ) as RESULT
			function = RESULT_SCALAR_INTPTR
		end function

		TEST( default )
			dim as integer array_int(0), scalar_int
			dim as uinteger array_uint(0), scalar_uint
			dim as single array_single(0), scalar_single
			dim as integer ptr array_intptr(0), scalar_intptr

			CU_ASSERT( proc( array_int() ) = RESULT_ARRAY_INT )
			CU_ASSERT( proc( array_uint() ) = RESULT_ARRAY_UINT )
			CU_ASSERT( proc( array_single() ) = RESULT_ARRAY_SINGLE )
			CU_ASSERT( proc( array_intptr() ) = RESULT_ARRAY_INTPTR )

			CU_ASSERT( proc( scalar_int ) = RESULT_SCALAR_INT )
			CU_ASSERT( proc( scalar_uint ) = RESULT_SCALAR_UINT )
			CU_ASSERT( proc( scalar_single ) = RESULT_SCALAR_SINGLE )
			CU_ASSERT( proc( scalar_intptr ) = RESULT_SCALAR_INTPTR )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( dimensions1vs2 )
		function f overload( array(any) as integer ) as integer
			function = 1
		end function

		function f overload( array(any, any) as integer ) as integer
			function = 2
		end function

		TEST( default )
			dim array1(any) as integer
			dim array2(any, any) as integer
			CU_ASSERT( f( array1() ) = 1 )
			CU_ASSERT( f( array2() ) = 2 )

			scope
				dim array() as integer
				redim array(0 to 0)
				CU_ASSERT( f( array() ) = 1 )
			end scope

			scope
				dim array() as integer
				redim array(0 to 0, 0 to 0)
				CU_ASSERT( f( array() ) = 2 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( unknownDimensionsDtype )
		function f overload( array() as integer ) as integer
			function = 1
		end function

		function f overload( array() as single ) as integer
			function = 2
		end function

		TEST( default )
			scope
				dim array1() as integer
				dim array2() as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1(any) as integer
				dim array2(any) as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1(any) as integer
				dim array2(any, any) as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1() as integer
				dim array2(any) as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1(any) as integer
				dim array2() as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( knownDimensionsDtype )
		function f overload( array(any) as integer ) as integer
			function = 1
		end function

		function f overload( array(any) as single ) as integer
			function = 2
		end function

		TEST( default )
			scope
				dim array1() as integer
				dim array2() as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1(any) as integer
				dim array2(any) as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1() as integer
				dim array2(any) as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope

			scope
				dim array1(any) as integer
				dim array2() as single
				CU_ASSERT( f( array1() ) = 1 )
				CU_ASSERT( f( array2() ) = 2 )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( unknownDimensionsArgHasDimensionsFilledIn )
		function f overload( array1(any) as integer ) as integer
			function = 1
		end function

		function f overload( array2(any, any) as single ) as integer
			function = 2
		end function

		TEST( default )
			dim array1() as integer
			dim array2() as single

			'' Even though the overloads can't be resolved based on
			'' dimension count here (because the args' dimensions are
			'' unknown), they can and should be resolved based on the dtype.
			'' And then the args' dimension counts should be filled in.
			CU_ASSERT( f( array1() ) = 1 )
			CU_ASSERT( f( array2() ) = 2 )

			'' Should compile without error, now that dimensions counts
			'' were filled in.
			redim array1(0 to 0)
			redim array2(0 to 0, 0 to 0)
		END_TEST
	END_TEST_GROUP

END_SUITE
