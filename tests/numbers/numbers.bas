''
'' tests for implicit number conversion due to math overflows
''

'' these ensure numeric constants are properly parsed, so that corrent types
'' get assigned to them (taking care of signedness and number length). If bad
'' types get assigned, wrong print rtlib functions will get called to print
'' the value.

#include "fbcunit.bi"

SUITE( fbc_tests.numbers.numbers_ )

	#if 0
		'' !!! TODO !!! purpose of this ?
		print 1
		print -1
		print &h00000003
		print &b00000011
		print 2147483647
		print -2147483648
		print 4294967295
		print 2147483648
		print 9223372036854775807
		print -9223372036854775808
		print 18446744073709551615
		print 9223372036854775808
	#endif

	dim shared as byte      b_lb,  b_ub,  test_b_lb,  test_b_ub
	dim shared as ubyte    ub_lb, ub_ub, test_ub_lb, test_ub_ub
	dim shared as short     s_lb,  s_ub,  test_s_lb,  test_s_ub
	dim shared as ushort   us_lb, us_ub, test_us_lb, test_us_ub
	dim shared as integer   i_lb,  i_ub,  test_i_lb,  test_i_ub
	dim shared as uinteger ui_lb, ui_ub, test_ui_lb, test_ui_ub
	dim shared as longint   l_lb,  l_ub,  test_l_lb,  test_l_ub
	dim shared as ulongint ul_lb, ul_ub, test_ul_lb, test_ul_ub

	TEST( signed_byte )

		test_b_lb = -128
		test_b_ub = 127
		b_lb = -129
		b_ub = 128
		cu_assert( b_lb = test_b_ub )
		cu_assert( b_ub = test_b_lb )

	END_TEST

	TEST( unsigned_byte )

		test_ub_lb = 0
		test_ub_ub = 255
		ub_lb = -1
		ub_ub = 256
		cu_assert( ub_lb = test_ub_ub )
		cu_assert( ub_ub = test_ub_lb )

	END_TEST

	TEST( signed_short )

		test_s_lb = -32768
		test_s_ub = 32767
		s_lb = -32769
		s_ub = 32768
		cu_assert( s_lb = test_s_ub )
		cu_assert( s_ub = test_s_lb )

	END_TEST

	TEST( unsigned_short )

		test_us_lb = 0
		test_us_ub = 65535
		us_lb = -1
		us_ub = 65536
		cu_assert( us_lb = test_us_ub )
		cu_assert( us_ub = test_us_lb )

	END_TEST

	TEST( signed_integer )

	#ifdef __FB_64BIT__
		test_i_lb = -9223372036854775808
		test_i_ub = 9223372036854775807
	#else
		test_i_lb = -2147483648
		test_i_ub = 2147483647
	#endif
	#ifdef __FB_64BIT__
		i_lb = -9223372036854775809
		i_ub = 9223372036854775808
	#else
		i_lb = -2147483649
		i_ub = 2147483648
	#endif
		cu_assert( i_lb = test_i_ub )
		cu_assert( i_ub = test_i_lb )

	END_TEST

	TEST( unsigned_integer )

	#ifdef __FB_64BIT__
		test_ui_lb = 0
		test_ui_ub = 18446744073709551615

		ui_lb = -1
		'' is truncated to 18446744073709551615, not wrapping around
		ui_ub = 18446744073709551616

		cu_assert( ui_lb = test_ui_ub )
		cu_assert( ui_ub = test_ui_ub )
	#else
		test_ui_lb = 0
		test_ui_ub = 4294967295
		ui_lb = -1
		ui_ub = 4294967296
		cu_assert( ui_lb = test_ui_ub )
		cu_assert( ui_ub = test_ui_lb )
	#endif

	END_TEST

	TEST( signed_longint )

		test_l_lb = -9223372036854775808
		test_l_ub = 9223372036854775807
		l_lb = -9223372036854775809
		l_ub = 9223372036854775808
		cu_assert( l_lb = test_l_ub )
		cu_assert( l_ub = test_l_lb )

	END_TEST

	TEST( unsigned_longint )

		test_ul_lb = 0
		test_ul_ub = 18446744073709551615
		ul_lb = -1
		'' is truncated to 18446744073709551615, not wrapping around
		ul_ub = 18446744073709551616
		cu_assert( ul_lb = test_ul_ub )
		cu_assert( ul_ub = test_ul_ub )

	END_TEST

END_SUITE
