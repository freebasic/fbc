# include "fbcunit.bi"

SUITE( fbc_tests.dim_.static_ )

	TEST( staticFixedArray )
		static as integer array(0 to 3) = { 0, 1, 2, 3 }
		
		dim as integer i
		for i = 0 to 3
			CU_ASSERT( array(i) = i )
		next
		
	END_TEST

	private sub staticSubFixedArray_proc( ) static
		dim as integer array(0 to 3) = { 0, 1, 2, 3 }
		
		dim as integer i
		for i = 0 to 3
			CU_ASSERT( array(i) = i )
		next
	end sub
	TEST( staticSubFixedArray )
		staticSubFixedArray_proc()
	END_TEST

	TEST( staticDynamicArray )
		static as integer array()
		
		redim array(0 to 3)

		dim as integer i
		for i = 0 to 3
			array(i) = i
		next
		
		for i = 0 to 3
			CU_ASSERT( array(i) = i )
		next
		
	END_TEST

	private sub staticSubDynamicArray_proc( ) static
		dim as integer array()
		
		redim array(0 to 3)

		dim as integer i
		for i = 0 to 3
			array(i) = i
		next
		
		for i = 0 to 3
			CU_ASSERT( array(i) = i )
		next
	end sub

	TEST( staticSubDynamicArray )
		staticSubDynamicArray_proc()
	END_TEST

	static shared as integer global_i = 111

	static as integer mainstatic_i = 222
	static as integer ptr mainstatic_pi1 = @mainstatic_i
	static as integer ptr mainstatic_pi2 = @global_i

	TEST( staticVariables )
		static as integer procstatic_i = 333
		static as integer ptr procstatic_pi1 = @procstatic_i
		static as integer ptr procstatic_pi2 = @global_i

		CU_ASSERT( *mainstatic_pi1 = 222 )
		CU_ASSERT( *mainstatic_pi2 = 111 )

		CU_ASSERT( *procstatic_pi1 = 333 )
		CU_ASSERT( *procstatic_pi2 = 111 )
	END_TEST
	
	'' STATIC + non-constant array subscripts
	TEST( staticArrayVariableSubscripts )
		dim as integer l = 5, u = 6

		dim array1(l to u) as integer
		CU_ASSERT( lbound( array1 ) = 5 )
		CU_ASSERT( ubound( array1 ) = 6 )

		static array2(l to u) as integer
		CU_ASSERT( lbound( array2 ) = 5 )
		CU_ASSERT( ubound( array2 ) = 6 )
	END_TEST

	private sub fTestDynamic( byval pass as integer ) static
		'' STATIC dynamic array, should be initialized to those default
		'' dimensions only once
		redim array(1 to 2) as integer

		if( pass = 2 ) then
			redim array(3 to 4)
		end if

		if( pass = 1 ) then
			CU_ASSERT( lbound( array ) = 1 )
			CU_ASSERT( ubound( array ) = 2 )
		else
			CU_ASSERT( lbound( array ) = 3 )
			CU_ASSERT( ubound( array ) = 4 )
		end if
	end sub

	'' STATIC dynamic array REDIM at declaration
	TEST( staticSubDynamicArrayRedim )
		fTestDynamic( 1 )
		fTestDynamic( 2 )
		fTestDynamic( 3 )
	END_TEST

END_SUITE
