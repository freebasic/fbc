#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.self_concat )

	'' test optimizations for a = a + expr
	'' - possibly using fb_StrConcatByref()

	dim shared m as string

	sub concat_shared_1( byref a as string )
		m = m + a
	end sub

	sub concat_shared_2( byref a as string )
		m += a
	end sub

	sub concat_shared_3( byref a as string )
		m = m & a
	end sub

	sub concat_shared_4( byref a as string )
		m &= a
	end sub

	sub concat_self_1( byref a as string )
		a = a + a
	end sub

	sub concat_self_2( byref a as string )
		a += a
	end sub

	sub concat_self_3( byref a as string )
		a = a & a
	end sub

	sub concat_self_4( byref a as string )
		a &= a
	end sub

	sub concat_self2_1( byref a as string, byref b as string )
		a = a + b + a
	end sub

	sub concat_self2_2( byref a as string, byref b as string )
		a += b + a
	end sub

	sub concat_self2_3( byref a as string, byref b as string )
		a = a & b & a
	end sub

	sub concat_self2_4( byref a as string, byref b as string )
		a &= b & a
	end sub

	TEST( self )

		dim t as string  = "Test"
		dim s as string  = "FreeBASIC"
		dim ts as string = "TestFreeBASIC"
		dim ss as string = "FreeBASICFreeBASIC"
		dim sts as string = "FreeBASICTestFreeBASIC"
		dim a as string
		dim b as string

		'' pass in shared string argument

		m = s
		concat_shared_1( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_shared_2( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_shared_3( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_shared_4( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_self_1( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_self_2( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_self_3( m )
		CU_ASSERT_EQUAL( m, ss )

		m = s
		concat_self_4( m )
		CU_ASSERT_EQUAL( m, ss )

		'' pass in local string argument

		m = t
		a = s
		concat_shared_1( a )
		CU_ASSERT_EQUAL( a, s )
		CU_ASSERT_EQUAL( m, ts )

		m = t
		a = s
		concat_shared_2( a )
		CU_ASSERT_EQUAL( a, s )
		CU_ASSERT_EQUAL( m, ts )

		m = t
		a = s
		concat_shared_3( a )
		CU_ASSERT_EQUAL( a, s )
		CU_ASSERT_EQUAL( m, ts )

		m = t
		a = s
		concat_shared_4( a )
		CU_ASSERT_EQUAL( a, s )
		CU_ASSERT_EQUAL( m, ts )

		a = s
		concat_self_1( a )
		CU_ASSERT_EQUAL( a, ss )

		a = s
		concat_self_2( a )
		CU_ASSERT_EQUAL( a, ss )

		a = s
		concat_self_3( a )
		CU_ASSERT_EQUAL( a, ss )

		a = s
		concat_self_4( a )
		CU_ASSERT_EQUAL( a, ss )

		'' pass in local string argument

		a = s
		b = t
		concat_self2_1( a, b )
		CU_ASSERT_EQUAL( a, sts )

		a = s
		b = t
		concat_self2_2( a, b )
		CU_ASSERT_EQUAL( a, sts )

		a = s
		b = t
		concat_self2_3( a, b )
		CU_ASSERT_EQUAL( a, sts )

		a = s
		b = t
		concat_self2_4( a, b )
		CU_ASSERT_EQUAL( a, sts )

	END_TEST

END_SUITE
