''
'' tests for implicit number conversion due to math overflows
''


'' these ensure numeric constants are properly parsed, so that corrent types
'' get assigned to them (taking care of signedness and number length). If bad
'' types get assigned, wrong print rtlib functions will get called to print
'' the value.

dim as byte b_lb, b_ub, test_b_lb, test_b_ub
dim as ubyte ub_lb, ub_ub, test_ub_lb, test_ub_ub
dim as short s_lb, s_ub, test_s_lb, test_s_ub
dim as ushort us_lb, us_ub, test_us_lb, test_us_ub
dim as integer i_lb, i_ub, test_i_lb, test_i_ub
dim as uinteger ui_lb, ui_ub, test_ui_lb, test_ui_ub
dim as longint l_lb, l_ub, test_l_lb, test_l_ub
dim as ulongint ul_lb, ul_ub, test_ul_lb, test_ul_ub

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

test_b_lb = -128
test_b_ub = 127
'' these should issue 2 warnings
b_lb = -129
b_ub = 128
ASSERT( b_lb = test_b_ub )
ASSERT( b_ub = test_b_lb )

test_ub_lb = 0
test_ub_ub = 255
'' these should issue 2 warnings
ub_lb = -1
ub_ub = 256
ASSERT( ub_lb = test_ub_ub )
ASSERT( ub_ub = test_ub_lb )

test_s_lb = -32768
test_s_ub = 32767
'' these should issue 2 warnings
s_lb = -32769
s_ub = 32768
ASSERT( s_lb = test_s_ub )
ASSERT( s_ub = test_s_lb )

test_us_lb = 0
test_us_ub = 65535
'' these should issue 2 warnings
us_lb = -1
us_ub = 65536
ASSERT( us_lb = test_us_ub )
ASSERT( us_ub = test_us_lb )

test_i_lb = -2147483648
test_i_ub = 2147483647
'' these should issue 2 warnings
i_lb = -2147483649
i_ub = 2147483648
ASSERT( i_lb = test_i_ub )
ASSERT( i_ub = test_i_lb )

test_ui_lb = 0
test_ui_ub = 4294967295
'' these should issue 2 warnings
ui_lb = -1
ui_ub = 4294967296
ASSERT( ui_lb = test_ui_ub )
ASSERT( ui_ub = test_ui_lb )

test_l_lb = -9223372036854775808
test_l_ub = 9223372036854775807
'' these should issue 2 warnings
l_lb = -9223372036854775809
l_ub = 9223372036854775808
ASSERT( l_lb = test_l_ub )
ASSERT( l_ub = test_l_lb )

test_ul_lb = 0
test_ul_ub = 18446744073709551615
'' this should issue a warning
#ifdef FIXME
ul_lb = -1LL
#else
ul_lb = -1
#endif
#if 0
'' this should issue an error if uncommented
'' from mjs: really?
ul = 18446744073709551616
#endif
ASSERT( ul_lb = test_ul_ub )
#if 0
ASSERT( ul_ub = test_ul_lb )
#endif

