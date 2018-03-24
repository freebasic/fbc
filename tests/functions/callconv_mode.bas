# include "fbcunit.bi"

#define PARAM1 byval a as integer
#define PARAM2 byref b as string
#define PARAM3 byval c as double

#define A1 1
#define A2 "2"
#define A3 3.5

SUITE( fbc_tests.functions.callconv_mode )

	'' STDCALL proc
	sub Fstdcall stdcall ( PARAM1, PARAM2, PARAM3 )
		CU_ASSERT_EQUAL( a, A1 )
		CU_ASSERT_EQUAL( b, A2 )
		CU_ASSERT_EQUAL( c, A3 )
	end sub

	'' PASCAL proc
	sub Fpascal pascal ( PARAM1, PARAM2, PARAM3 )
		CU_ASSERT_EQUAL( a, A1 )
		CU_ASSERT_EQUAL( b, A2 )
		CU_ASSERT_EQUAL( c, A3 )
	end sub

	'' CDECL proc
	sub Fcdecl cdecl ( PARAM1, PARAM2, PARAM3 )
		CU_ASSERT_EQUAL( a, A1 )
		CU_ASSERT_EQUAL( b, A2 )
		CU_ASSERT_EQUAL( c, A3 )
	end sub
	
	''
	TEST( callStdCall )

		'' Call STDCALL proc
		Fstdcall( A1, A2, A3 )

	END_TEST

	''
	TEST( callPascal )

		'' Call PASCAL proc
		Fpascal( A1, A2, A3 )

	END_TEST

	''
	TEST( callCdecl )

		'' Call CDECL proc
		Fcdecl( A1, A2, A3 )

	END_TEST

	''
	TEST( callStdcallPascalReversed )

		'' Call STDCALL proc with PASCAL call-convention
		'' arguments are reversed, but stack clean-up is the same

		dim F as sub pascal ( PARAM3, PARAM2, PARAM1 )

		'' Cast away the function ptr type to quiet warning
		F = cast( any ptr, procptr(Fstdcall))

		F( A3, A2, A1 )

	END_TEST

	''
	TEST( callPascalStdcallReversed )

		'' Call PASCAL proc with STDCALL call-convention
		'' arguments are reversed, but stack clean-up is the same

		dim F as sub stdcall ( PARAM3, PARAM2, PARAM1 )

		'' Cast away the function ptr type to quiet warning
		F = cast( any ptr, procptr(Fpascal))

		F( A3, A2, A1 )

	END_TEST

END_SUITE
