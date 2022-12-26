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

	TEST( init_parent_parent )
		dim i as integer
		dim as parent p

		'' dim as parent p = 1                '' invalid data types
		'' dim as parent p = i                '' invalid data types
		'' dim as parent p = type<parent>(c)  '' invalid upcast


		dim as parent p1 = ( 1 )
		CU_ASSERT_EQUAL( p1.i, 1 )

		dim as parent p2 = type( 2 )
		CU_ASSERT_EQUAL( p2.i, 2 )

		dim as parent p3 = type<child>( 3 )
		CU_ASSERT_EQUAL( p3.i, 3 )

		dim as parent p4 = type<child>( 4, 5 )
		CU_ASSERT_EQUAL( p4.i, 4 )

		p.i = 5
		dim as parent p5 = p
		CU_ASSERT_EQUAL( p5.i, 5 )

		p.i = 6
		dim as parent p6 = type( p )
		CU_ASSERT_EQUAL( p6.i, 6 )

		i = 7
		dim as parent p7 = ( i )
		CU_ASSERT_EQUAL( p7.i, 7 )

		i = 8
		dim as parent p8 = type( i )
		CU_ASSERT_EQUAL( p8.i, 8 )

		i = 9
		dim as parent p9 = type<parent>( i )
		CU_ASSERT_EQUAL( p9.i, 9 )

	END_TEST

	TEST( init_parent_child )
		dim as integer i, j
		dim as parent p
		dim as child c

		c.i = 1: c.j = 11
		dim as parent p1 = c
		CU_ASSERT_EQUAL( p1.i, 1 )

		c.i = 2: c.j = 12
		dim as parent p2 = type<child>c
		CU_ASSERT_EQUAL( p2.i, 2 )

		c.i = 3: c.j = 13
		dim as parent p3 = type<child>(c)
		CU_ASSERT_EQUAL( p3.i, 3 )

		i = 4: j = 14
		dim as parent p4 = type<child>( i )
		CU_ASSERT_EQUAL( p4.i, 4 )

		i = 5: j = 15
		dim as parent p5 = type<child>( 5, j )
		CU_ASSERT_EQUAL( p5.i, 5 )

		i = 6: j = 16
		dim as parent p6 = type<child>( i, 16 )
		CU_ASSERT_EQUAL( p6.i, 6 )

		i = 7: j = 17
		dim as parent p7 = type<child>( i, j )
		CU_ASSERT_EQUAL( p7.i, 7 )

	END_TEST

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
