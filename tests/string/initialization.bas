#include "fbcunit.bi"

SUITE( fbc_tests.string_.initialization )

	Type foo
		As String one, two, three
		declare operator let( byref as foo )
	End Type

	TEST( test1 )
		dim As foo bar
		
		with bar
			.one = "1"
			.two = "2"
			.three = "2"
		end with

		Dim As String Array(0 to 2) = { bar.one, bar.two, bar.three }
		
		CU_ASSERT_EQUAL( array(0), bar.one )
		CU_ASSERT_EQUAL( array(1), bar.two )
		CU_ASSERT_EQUAL( array(2), bar.three )
		
	END_TEST

	TEST( test2 )
		static zarray( 0 to 2, 0 to 2 ) as zstring * 10 => { { "abc", "def" }, { "ghi", "jkl" } }
		CU_ASSERT_EQUAL( zarray(1, 1), "jkl" )

		static farray( 0 to 2, 0 to 2 ) as string * 5 => { { "xxx", "yyy" }, { "zzz", "aaa" } }
		CU_ASSERT_EQUAL( farray(1, 0), "zzz" )

		static warray( 0 to 2, 0 to 2 ) as wstring * 6 => { { "123", "456" }, { "789", "012" } }
		CU_ASSERT_EQUAL( warray(1, 1), wstr("012") )
		
	END_TEST

	TEST( test3 )
		dim zarray( 0 to 2, 0 to 2 ) as zstring * 10 => { { "abc", "def" }, { "ghi", "jkl" } }
		CU_ASSERT_EQUAL( zarray(1, 1), "jkl" )

		dim farray( 0 to 2, 0 to 2 ) as string * 5 => { { "xxx", "yyy" }, { "zzz", "aaa" } }
		CU_ASSERT_EQUAL( farray(1, 0), "zzz" )

		dim warray( 0 to 2, 0 to 2 ) as wstring * 6 => { { "123", "456" }, { "789", "012" } }
		CU_ASSERT_EQUAL( warray(1, 1), wstr("012") )
		
	END_TEST

END_SUITE
