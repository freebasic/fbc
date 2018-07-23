#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_conv )

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

	TEST( test1 )

		dim as foo_1 f
		
		f.w = TEST_W
		f.h = TEST_H
		
		dotest_w()
		dotest_h()

	END_TEST

	TEST( test2 )

		dim as foo_2 f
		
		f.w = TEST_W
		f.h = TEST_H
		
		dotest_w()
		dotest_h()

	END_TEST

	TEST( test3 )

		dim as foo_3 f
		
		f.w = TEST_W
		f.h = TEST_H
		
		dotest_w()
		dotest_h()

	END_TEST

END_SUITE
