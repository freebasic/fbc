#include "fbcunit.bi"

SUITE( fbc_tests.compound.with_type )

	dim shared dtor_count as integer = 0

	type T0
	    dim as integer i
	    dim as integer j
	end type

	TEST( udt0 )
		with type<T0>(11, 12)
			CU_ASSERT_EQUAL( .i, 11 )
			CU_ASSERT_EQUAL( .j, 12 )
		end with
	END_TEST

	'' ---------

	type T1
	    dim as integer i
	    dim as integer j
	    declare destructor()
	end type

	destructor T1()
		CU_ASSERT_EQUAL( this.i, 21 )
		CU_ASSERT_EQUAL( this.j, 22 )
	    this.i = 0
	    this.j = 0
		dtor_count += 1
	end destructor

	TEST( udt1 )
		dtor_count = 0
		with type<T1>(21, 22)
			CU_ASSERT_EQUAL( .i, 21 )
			CU_ASSERT_EQUAL( .j, 22 )
			CU_ASSERT_EQUAL( dtor_count, 0 )
		end with
		CU_ASSERT_EQUAL( dtor_count, 1 )
	END_TEST

	'' ---------

	type T2
	    dim as integer i
	    dim as integer j
	    declare constructor(byval i0 as integer, byval j0 as integer)
	    declare destructor()
	end type

	constructor T2(byval i0 as integer, byval j0 as integer)
	    this.i = i0
	    this.j = j0
	end constructor

	destructor T2()
		CU_ASSERT_EQUAL( this.i, 31 )
		CU_ASSERT_EQUAL( this.j, 32 )
	    this.i = 0
	    this.j = 0
		dtor_count += 1
	end destructor

	TEST( udt2 )
		dtor_count = 0
		with type<T2>(31, 32)
			CU_ASSERT_EQUAL( .i, 31 )
			CU_ASSERT_EQUAL( .j, 32 )
			CU_ASSERT_EQUAL( dtor_count, 0 )
		end with
		CU_ASSERT_EQUAL( dtor_count, 1 )
	END_TEST


END_SUITE
