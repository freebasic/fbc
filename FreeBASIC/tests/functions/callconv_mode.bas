# include "fbcu.bi"


#define PARAM1 byval a as integer
#define PARAM2 byref b as string
#define PARAM3 byval c as double

#define A1 1
#define A2 "2"
#define A3 3.5

namespace fbc_tests.functions.callconv_mode

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
	sub test1 cdecl( )

		'' Call STDCALL proc
		Fstdcall( A1, A2, A3 )

	end sub

	''
	sub test2 cdecl( )

		'' Call PASCAL proc
		Fpascal( A1, A2, A3 )

	end sub

	''
	sub test3 cdecl( )

		'' Call CDECL proc
		Fcdecl( A1, A2, A3 )

	end sub

#if defined( __FB_WIN32__ )

	'' This is a valid test but only on win since
	'' for linux, stdcall is the same as cdecl

	''
	sub test4 cdecl( )

		'' Call STDCALL proc with PASCAL call-convention
		'' arguments are reversed, but stack clean-up is the same

		dim F as sub pascal ( PARAM3, PARAM2, PARAM1 )

		'' Cast away the function ptr type to quiet warning
		F = cast( any ptr, procptr(Fstdcall))

		F( A3, A2, A1 )

	end sub

	''
	sub test5 cdecl( )

		'' Call PASCAL proc with STDCALL call-convention
		'' arguments are reversed, but stack clean-up is the same

		dim F as sub stdcall ( PARAM3, PARAM2, PARAM1 )

		'' Cast away the function ptr type to quiet warning
		F = cast( any ptr, procptr(Fpascal))

		F( A3, A2, A1 )

	end sub

#endif
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.functions.callconv_mode")
		fbcu.add_test("test1", @test1)
		fbcu.add_test("test2", @test2)
		fbcu.add_test("test3", @test3)

#if defined( __FB_WIN32__ )
		fbcu.add_test("test4", @test4)
		fbcu.add_test("test5", @test5)
#endif
	
	end sub

end namespace
