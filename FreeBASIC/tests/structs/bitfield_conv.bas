# include "fbcu.bi"

 

namespace fbc_tests.structs.bitfield_conversions

const TEST_W = 123
const TEST_H = 77
	
type foo_1 field=1 
	as short                 bpp :3
	as short                 w   :8 
	as short                 h   :8
end type 

type foo_2 field=1 
	as short                 bpp :3
	as short                 w   :8
	as short                 h
end type 

type foo_3 field=1 
	as short                 bpp :3
	as integer               w   :8 
	as integer               h
end type 

# macro testw(type_)
	dim w_##type_ as type_ = f.w
	CU_ASSERT_EQUAL( w_##type_, TEST_W )
# endmacro

# macro testh(type_)
	dim h_##type_ as type_ = f.h
	CU_ASSERT_EQUAL( h_##type_, TEST_H )
# endmacro

# macro dotest_w()
	testw(byte)		:	testw(ubyte)
	testw(short)	:	testw(ushort)
	testw(integer)	:	testw(uinteger)
	testw(longint)	:	testw(ulongint)
	testw(single)	:	testw(double)
# endmacro

# macro dotest_h()
	testh(byte)		:	testh(ubyte)
	testh(short)	:	testh(ushort)
	testh(integer)	:	testh(uinteger)
	testh(longint)	:	testh(ulongint)
	testh(single)	:	testh(double)
# endmacro

sub test_1 cdecl ()

	dim as foo_1 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dotest_w()
	dotest_h()

end sub

sub test_2 cdecl ()

	dim as foo_2 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dotest_w()
	dotest_h()

end sub

sub test_3 cdecl ()

	dim as foo_3 f
	
	f.w = TEST_W
	f.h = TEST_H
	
	dotest_w()
	dotest_h()

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.bitfield_conv")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)

end sub

end namespace
