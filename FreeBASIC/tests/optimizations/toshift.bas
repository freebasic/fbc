# include "fbcu.bi"

namespace fbc_tests.optimizations.toshift

const TEST_1 as integer = 3
const TEST_2 as integer = -3

	dim shared as byte _sbyte
	dim shared as ubyte _ubyte
	dim shared as short _sshort
	dim shared as ushort _ushort
	dim shared as integer _sint
	dim shared as uinteger _uint
	dim shared as integer div = 2
	
sub test_positive cdecl ()
	_sbyte = TEST_1
	_ubyte = TEST_1
	_sshort = TEST_1
	_ushort = TEST_1
	_sint = TEST_1
	_uint = TEST_1
	
	CU_ASSERT_EQUAL( _sbyte \ 2,  1 )
	CU_ASSERT_EQUAL( _ubyte \ 2,  1 )
	CU_ASSERT_EQUAL( _sshort \ 2,  1 )
	CU_ASSERT_EQUAL( _ushort \ 2,  1 )
	CU_ASSERT_EQUAL( _sint \ 2,  1 )
	CU_ASSERT_EQUAL( _uint \ 2,  1 )
	
	CU_ASSERT_EQUAL( _sbyte \ div,  1 )
	CU_ASSERT_EQUAL( _ubyte \ div,  1 )
	CU_ASSERT_EQUAL( _sshort \ div,  1 )
	CU_ASSERT_EQUAL( _ushort \ div,  1 )
	CU_ASSERT_EQUAL( _sint \ div,  1 )
	CU_ASSERT_EQUAL( _uint \ div,  1 )
end sub

sub test_negative cdecl ()
	_sbyte = TEST_2
	_ubyte = TEST_2
	_sshort = TEST_2
	_ushort = TEST_2
	_sint = TEST_2
	_uint = TEST_2
	
	CU_ASSERT_EQUAL( _sbyte \ 2,  -1 )
	CU_ASSERT_EQUAL( _ubyte \ 2,  &h7E )
	CU_ASSERT_EQUAL( _sshort \ 2,  -1 )
	CU_ASSERT_EQUAL( _ushort \ 2,  &h7FFE )
	CU_ASSERT_EQUAL( _sint \ 2,  -1 )
	CU_ASSERT_EQUAL( _uint \ 2,  &h7FFFFFFE )
	
	CU_ASSERT_EQUAL( _sbyte \ div,  -1 )
	CU_ASSERT_EQUAL( _ubyte \ div,  &h7E )
	CU_ASSERT_EQUAL( _sshort \ div,  -1 )
	CU_ASSERT_EQUAL( _ushort \ div,  &h7FFE )
	CU_ASSERT_EQUAL( _sint \ div,  -1 )
	CU_ASSERT_EQUAL( _uint \ div,  &h7FFFFFFE )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:multiplication association")
	fbcu.add_test("test_positive", @test_positive)
	fbcu.add_test("test_negative", @test_negative)

end sub

end namespace
