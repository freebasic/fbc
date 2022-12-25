#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_upcast_1 )

	type parent
		dim as integer i
	end type

	type child extends parent
		dim as integer j
	end type

	sub s1( byval p as parent, byval expected as integer )
		CU_ASSERT_EQUAL( p.i, expected )
	end sub

	TEST( pass_byval_1 )

		dim as parent p0
		p0.i = 1
		dim as child c0
		c0.i = 2 : c0.j = 3

		s1( p0, 1 )
		s1( c0, 2 )
		s1( cast(parent, c0), 2 )

	END_TEST

	TEST( init_upcast )
		dim as child c = (1234, 5678)

		dim as parent p = c
		CU_ASSERT_EQUAL( p.i, 1234 )

	END_TEST

END_SUITE
