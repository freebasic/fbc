#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_access )

	const TEST_W = 200
	const TEST_H = 100
		
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

	TEST( test1 )

		dim as foo_1 f
		
		f.w = TEST_W
		f.h = TEST_H
		
		dim as integer res = f.w * f.h
		
		CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

	END_TEST

	TEST( test2 )

		dim as foo_2 f
		
		f.w = TEST_W
		f.h = TEST_H
		
		dim as integer res = f.w * f.h
		
		CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

	END_TEST

	TEST( test3 )

		dim as foo_3 f
		
		f.w = TEST_W
		f.h = TEST_H
		
		dim as integer res = f.w * f.h
		
		CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

	END_TEST

	dim shared as foo_1 f4

	TEST( test4 )

		f4.w = TEST_W
		f4.h = TEST_H
		
		dim as integer res = f4.w * f4.h
		
		CU_ASSERT_EQUAL( res, TEST_W * TEST_H )

	END_TEST

	'' Nested field access
	TEST( nested )
		type A
			as integer i : 1
		end type

		type B
			as A a
		end type

		dim as B b

		b.a.i = 1

		CU_ASSERT( b.a.i = 1 )
	END_TEST

END_SUITE
