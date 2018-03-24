#include "fbcunit.bi"

SUITE( fbc_tests.typedef.syntax )

	TEST( singleForward )

		'' Forwarding with single decl syntax
		type a as UDT, b as UDT, c as UDT ptr

		type UDT
			as integer x, y, z
		end type

		dim as a x = (1, 2, 3)
		dim as b y = x
		dim as c z = @x

		CU_ASSERT_EQUAL( x.x, 1 )
		CU_ASSERT_EQUAL( y.x, 1 )
		CU_ASSERT_EQUAL( z->x, 1 )

	END_TEST

	TEST( singleAlias )

		type UDT
			as integer x, y, z
		end type

		'' Aliasing with single decl syntax
		type a as integer, b as double, c as integer ptr, d as UDT, e as UDT ptr ptr ptr

		dim x1 as a = 5
		dim x2 as b = 1.5
		dim x3 as c = @x1
		dim x4 as d = (1, 2, 3)
		dim p as UDT ptr = @x4
		dim pp as UDT ptr ptr = @p
		dim ppp as e = @pp

		CU_ASSERT_EQUAL( x1, 5 )
		CU_ASSERT_EQUAL( x2, 1.5 )
		CU_ASSERT_EQUAL( *x3, 5 )
		CU_ASSERT_EQUAL( x4.y, 2 )
		CU_ASSERT_EQUAL( (**ppp)->z, 3 )

	END_TEST

	TEST( multiForward )

		'' Forwarding with multi decl syntax
		type as UDT a, b
		type as UDT ptr c, d

		type UDT
			as integer x, y, z
		end type

		dim as a w = (2, 3, 4)
		dim as b x = w
		dim as c y = @w
		dim as d z = @w

		CU_ASSERT_EQUAL( w.y, 3 )
		CU_ASSERT_EQUAL( x.y, 3 )
		CU_ASSERT_EQUAL( y->y, 3 )
		CU_ASSERT_EQUAL( z->y, 3 )

	END_TEST

	TEST( multiAlias )

		type UDT
			as integer x, y, z
		end type

		'' Multi decl syntax, aliasing only, no forwarding
		type as integer ti
		type as double td1, td2, td3
		type as integer ptr tpi1, tpi2

		type as UDT tu1, tu2
		type as UDT ptr ptr ptr tpppu1, tpppu2

		dim i as ti = 5
		dim d1 as td1 = 1.5
		dim d2 as td2 = 1.5
		dim d3 as td3 = 1.5
		dim pi1 as tpi1 = @i
		dim pi2 as tpi2 = @i

		dim u1 as tu1 = (1, 2, 3)
		dim u2 as tu2 = (4, 5, 6)
		dim as UDT ptr pu1 = @u1
		dim as UDT ptr pu2 = @u2
		dim as UDT ptr ptr ppu1 = @pu1
		dim as UDT ptr ptr ppu2 = @pu2
		dim pppu1 as tpppu1 = @ppu1
		dim pppu2 as tpppu2 = @ppu2

		CU_ASSERT_EQUAL( i, 5 )
		CU_ASSERT_EQUAL( d1, 1.5 )
		CU_ASSERT_EQUAL( d2, 1.5 )
		CU_ASSERT_EQUAL( d3, 1.5 )
		CU_ASSERT_EQUAL( *pi1, 5 )
		CU_ASSERT_EQUAL( *pi2, 5 )

		CU_ASSERT_EQUAL( u1.x, 1 )
		CU_ASSERT_EQUAL( u2.z, 6 )
		CU_ASSERT_EQUAL( (**pppu1)->x, 1 )
		CU_ASSERT_EQUAL( (**pppu2)->z, 6 )

	END_TEST

END_SUITE
