# include "fbcu.bi"

namespace fbc_tests.functions.zwstring_params

	sub zfoo( byref z as zstring )

		CU_ASSERT_EQUAL( z, "Test" )

	end sub

	sub wfoo( byref w as wstring )

		CU_ASSERT_EQUAL( w, wstr("Test") )

	end sub

	sub test_1 cdecl ()

		dim s as string, s10 as string * 10, z10 as zstring* 10, w10 as wstring * 10
		s = "Test"
		s10 = "Test"
		z10 = "Test"
		w10 = "Test"

		zfoo( "Test" )
		zfoo( s )
		zfoo( s10 )
		zfoo( z10 )
		zfoo( w10 )

		wfoo( "Test" )
		wfoo( s )
		wfoo( s10 )
		wfoo( z10 )
		wfoo( w10 )

	end sub

	sub ctor () constructor

		fbcu.add_suite("fbc_tests.functions.zwstring_params")
		fbcu.add_test("test_1", @test_1)
	
	end sub

end namespace
