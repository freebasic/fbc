''
'' tests for implicit number conversion due to math overflows
''

'' these ensure numeric constants are properly parsed, so that corrent types
'' get assigned to them (taking care of signedness and number length). If bad
'' types get assigned, wrong print rtlib functions will get called to print
'' the value.

# include "fbcu.bi"

namespace fbc_tests.numbers.numbers_

#if 0
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

dim shared as byte b_lb,			b_ub,		test_b_lb,	test_b_ub
dim shared as ubyte ub_lb,		ub_ub,	test_ub_lb,	test_ub_ub
dim shared as short s_lb,		s_ub,		test_s_lb,	test_s_ub
dim shared as ushort us_lb,		us_ub,	test_us_lb,	test_us_ub
dim shared as integer i_lb,		i_ub,		test_i_lb,	test_i_ub
dim shared as uinteger ui_lb,	ui_ub,	test_ui_lb,	test_ui_ub
dim shared as longint l_lb,		l_ub,		test_l_lb,	test_l_ub
dim shared as ulongint ul_lb,	ul_ub,	test_ul_lb,	test_ul_ub

sub test_1 cdecl ()

	test_b_lb = -128
	test_b_ub = 127
	# print two warnings follow
	b_lb = -129
	b_ub = 128
	cu_assert( b_lb = test_b_ub )
	cu_assert( b_ub = test_b_lb )

end sub

sub test_2 cdecl ()

	test_ub_lb = 0
	test_ub_ub = 255
	# print two warnings follow
	ub_lb = -1
	ub_ub = 256
	cu_assert( ub_lb = test_ub_ub )
	cu_assert( ub_ub = test_ub_lb )

end sub

sub test_3 cdecl ()

	test_s_lb = -32768
	test_s_ub = 32767
	# print two warnings follow
	s_lb = -32769
	s_ub = 32768
	cu_assert( s_lb = test_s_ub )
	cu_assert( s_ub = test_s_lb )

end sub

sub test_4 cdecl ()

	test_us_lb = 0
	test_us_ub = 65535
	# print two warnings follow
	us_lb = -1
	us_ub = 65536
	cu_assert( us_lb = test_us_ub )
	cu_assert( us_ub = test_us_lb )

end sub

sub test_5 cdecl ()

	test_i_lb = -2147483648
	test_i_ub = 2147483647
	# print two warnings follow
	i_lb = -2147483649
	i_ub = 2147483648
	cu_assert( i_lb = test_i_ub )
	cu_assert( i_ub = test_i_lb )

end sub

sub test_6 cdecl ()

	test_ui_lb = 0
	test_ui_ub = 4294967295
	# print two warnings follow
	ui_lb = -1
	ui_ub = 4294967296
	cu_assert( ui_lb = test_ui_ub )
	cu_assert( ui_ub = test_ui_lb )

end sub

sub test_7 cdecl ()

	test_l_lb = -9223372036854775808
	test_l_ub = 9223372036854775807
	# print two warnings follow
	l_lb = -9223372036854775809
	l_ub = 9223372036854775808
	cu_assert( l_lb = test_l_ub )
	cu_assert( l_ub = test_l_lb )

end sub

sub test_8 cdecl ()

	test_ul_lb = 0
	test_ul_ub = 18446744073709551615
	# print one warning follow
	ul_lb = -1
	#if 0
	'' this should issue an error if uncommented:
	'' the lexer will complain the number is too big
	ul = 18446744073709551616
	#endif
	cu_assert( ul_lb = test_ul_ub )
	#if 0
	cu_assert( ul_ub = test_ul_lb )
	#endif

end sub

sub ctor () constructor

	fbcu.add_suite("fb-tests-numbers:numbers")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)
	fbcu.add_test("test_5", @test_5)
	fbcu.add_test("test_6", @test_6)
	fbcu.add_test("test_7", @test_7)
	fbcu.add_test("test_8", @test_8)

end sub

end namespace
