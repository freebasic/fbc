#include "fbcunit.bi"

SUITE( fbc_tests.structs.udt_upcast_4 )

	type t1            : dim as integer i : declare destructor() : end type
	type t2 extends t1 : dim as integer j : declare destructor() : end type
	type t3 extends t2 : dim as integer k : declare destructor() : end type
	type t4 extends t3 : dim as integer l : declare destructor() : end type

	dim shared dtorcount1 as integer = 0
	dim shared dtorcount2 as integer = 0
	dim shared dtorcount3 as integer = 0
	dim shared dtorcount4 as integer = 0

	sub reset_count
		dtorcount1 = 0
		dtorcount2 = 0
		dtorcount3 = 0
		dtorcount4 = 0
	end sub

	destructor t1()
		dtorcount1 += 1
	end destructor

	destructor t2()
		dtorcount2 += 1
	end destructor

	destructor t3()
		dtorcount3 += 1
	end destructor

	destructor t4()
		dtorcount4 += 1
	end destructor

	#macro check_dtor_count( d1, d2, d3, d4 )
		CU_ASSERT_EQUAL( dtorcount1, d1 )
		CU_ASSERT_EQUAL( dtorcount2, d2 )
		CU_ASSERT_EQUAL( dtorcount3, d3 )
		CU_ASSERT_EQUAL( dtorcount4, d4 )
	#endmacro

	TEST( default )

		reset_count
		scope
			dim as t4 x4 = (1, 2, 3, 4)
		end scope
		check_dtor_count( 1, 1, 1, 1 )

		reset_count
		scope
			dim as t3 u3 = type<t3>(1,2,3)
			CU_ASSERT_EQUAL( u3.i, 1 )
			CU_ASSERT_EQUAL( u3.j, 2 )
			CU_ASSERT_EQUAL( u3.k, 3 )
		end scope
		check_dtor_count( 1, 1, 1, 0 )

		reset_count
		scope
			dim as t3 u3 = type<t3>(type<t3>(1,2,3))
			CU_ASSERT_EQUAL( u3.i, 1 )
			CU_ASSERT_EQUAL( u3.j, 2 )
			CU_ASSERT_EQUAL( u3.k, 3 )
		end scope
		check_dtor_count( 1, 1, 1, 0 )

		reset_count
		scope
			dim as t3 u3 = type<t3>(type<t3>(type<t3>(1,2,3)))
			CU_ASSERT_EQUAL( u3.i, 1 )
			CU_ASSERT_EQUAL( u3.j, 2 )
			CU_ASSERT_EQUAL( u3.k, 3 )
		end scope
		check_dtor_count( 1, 1, 1, 0 )

		reset_count
		scope
			dim as t1 u1 = type<t2>(type<t3>(type<t4>(1, 2, 3, 4)))
			CU_ASSERT_EQUAL( u1.i, 1 )
		end scope
		check_dtor_count( 4, 3, 2, 1 )

	END_TEST

END_SUITE
