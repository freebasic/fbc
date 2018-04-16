#include "fbcunit.bi"

SUITE( fbc_tests.overload_.addressof )

	enum RESULT
	   RESULT_INT
	   RESULT_UINT
	   RESULT_SINGLE
	   RESULT_INTPTR
	end enum

	type fnint as function ( byval scalar as integer )  as RESULT
	type fnuint as function ( byval scalar as uinteger )  as RESULT
	type fnsng as function ( byval scalar as single )  as RESULT
	type fnintp as function ( byval scalar as integer ptr ) as RESULT

	function proc overload ( byval scalar as integer )  as RESULT
	   function = RESULT_INT
	end function 

	function proc ( byval scalar as uinteger )  as RESULT
	   function = RESULT_UINT
	end function 

	function proc ( byval scalar as single )  as RESULT
	   function = RESULT_SINGLE
	end function 

	function proc ( byval scalar as integer ptr ) as RESULT
	   function = RESULT_INTPTR
	end function

	TEST( static_initialization )
		static fint		as fnint = @proc
		static fuint	as fnuint = @proc
		static fsng		as fnsng = @proc
		static fintp	as fnintp = @proc

		CU_ASSERT_EQUAL( fint( 0 ), RESULT_INT )
		CU_ASSERT_EQUAL( fuint( 0 ), RESULT_UINT )
		CU_ASSERT_EQUAL( fsng( 0 ), RESULT_SINGLE )
		CU_ASSERT_EQUAL( fintp( 0 ), RESULT_INTPTR )
	END_TEST

	TEST( static_assignment )
		static fint		as fnint
		static fuint	as fnuint
		static fsng		as fnsng
		static fintp	as fnintp
		
		fint = @proc
		fuint = @proc
		fsng = @proc
		fintp = @proc

		CU_ASSERT_EQUAL( fint( 0 ), RESULT_INT )
		CU_ASSERT_EQUAL( fuint( 0 ), RESULT_UINT )
		CU_ASSERT_EQUAL( fsng( 0 ), RESULT_SINGLE )
		CU_ASSERT_EQUAL( fintp( 0 ), RESULT_INTPTR )
	END_TEST

	TEST( nonstatic_initialization )
		dim fint		as fnint		= @proc
		dim fuint	as fnuint	= @proc
		dim fsng		as fnsng		= @proc
		dim fintp	as fnintp	= @proc
		
		CU_ASSERT_EQUAL( fint( 0 ), RESULT_INT )
		CU_ASSERT_EQUAL( fuint( 0 ), RESULT_UINT )
		CU_ASSERT_EQUAL( fsng( 0 ), RESULT_SINGLE )
		CU_ASSERT_EQUAL( fintp( 0 ), RESULT_INTPTR )
	END_TEST

	TEST( nonstatic_assignment )
		dim fint		as fnint
		dim fuint	as fnuint
		dim fsng		as fnsng
		dim fintp	as fnintp
		
		fint = @proc
		fuint = @proc
		fsng = @proc
		fintp = @proc

		CU_ASSERT_EQUAL( fint( 0 ), RESULT_INT )
		CU_ASSERT_EQUAL( fuint( 0 ), RESULT_UINT )
		CU_ASSERT_EQUAL( fsng( 0 ), RESULT_SINGLE )
		CU_ASSERT_EQUAL( fintp( 0 ), RESULT_INTPTR )
	END_TEST

END_SUITE
