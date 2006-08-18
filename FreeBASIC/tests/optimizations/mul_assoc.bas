

const TEST_VAL0 as integer = 10
const TEST_VAL1 as integer = 1
const TEST_VAL2 as double = 2.0
const TEST_VAL3 as integer = 3
const TEST_VAL4 as integer = 4
const TEST_VAL5 as double = 5.0

function foo( byval value as double ) as double
	function = value
end function

function bar( ) as double
	function = TEST_VAL5
end function

#define TEST(type_)																	_
	dim as type_ v = TEST_VAL0														:_
	dim as double res1, res2														:_
	dim as double tmp1, tmp2, tmp3													:_
																					:_
	res1 = TEST_VAL1 + foo( TEST_VAL2 * v * (bar() * TEST_VAL3) ) * TEST_VAL4		:_
																					:_
	res2 = TEST_VAL1																:_
	tmp1 = TEST_VAL2 * v															:_
	tmp2 = bar() * TEST_VAL3														:_
	tmp3 = foo( tmp1 * tmp2 ) * TEST_VAL4											:_
 	res2 += tmp3																	:_
																					:_
	assert( res1 = res2 )


sub test_1
	TEST(byte)
end sub

sub test_2
	TEST(short)
end sub

sub test_3
	TEST(integer)
end sub

sub test_4
	TEST(ubyte)
end sub

sub test_5
	TEST(ushort)
end sub

sub test_6
	TEST(uinteger)
end sub

sub test_7
	TEST(single)
end sub

sub test_8
	TEST(double)
end sub

sub test_9
	TEST(longint)
end sub

sub test_10
	TEST(ulongint)
end sub
	
	test_1
	test_2
	test_3
	test_4
	test_5
	test_6
	test_7
	test_8
	test_9
	test_10