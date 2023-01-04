#include "fbcunit.bi"

SUITE( fbc_tests.structs.udt_upcast_3 )

	type t1            : dim as integer i : end type
	type t2 extends t1 : dim as integer j : end type
	type t3 extends t2 : dim as integer k : end type
	type t4 extends t3 : dim as integer l : end type

	TEST( init1_type_2 )
		dim as t4 x4 = (1, 2, 3, 4)

		scope
			dim as t3 w3 = type<t4>(x4)
			CU_ASSERT_EQUAL( w3.i, 1 )
			CU_ASSERT_EQUAL( w3.j, 2 )
			CU_ASSERT_EQUAL( w3.k, 3 )
		end scope

		scope
			dim as t2 w2 = type<t4>(x4)
			CU_ASSERT_EQUAL( w2.i, 1 )
			CU_ASSERT_EQUAL( w2.j, 2 )
		end scope

		scope
			dim as t1 w1 = type<t4>(x4)
			CU_ASSERT_EQUAL( w1.i, 1 )
		end scope
	END_TEST


	TEST( init_type_2 )
		dim as t4 x4 = (1, 2, 3, 4)

		scope
			dim as t3 ptr q33 = new t3(type<t4>(x4))
			CU_ASSERT_EQUAL( q33->i, 1 )
			CU_ASSERT_EQUAL( q33->j, 2 )
			CU_ASSERT_EQUAL( q33->k, 3 )
			delete q33
		end scope

		scope
			dim as t2 ptr q23 = new t3(type<t4>(x4))
			CU_ASSERT_EQUAL( q23->i, 1 )
			CU_ASSERT_EQUAL( q23->j, 2 )
			CU_ASSERT_EQUAL( cptr(t3 ptr, q23)->k, 3 )
			delete q23
		end scope

		scope
			dim as t1 ptr q13 = new t3(type<t4>(x4))
			CU_ASSERT_EQUAL( q13->i, 1 )
			CU_ASSERT_EQUAL( cptr(t3 ptr, q13)->j, 2 )
			CU_ASSERT_EQUAL( cptr(t3 ptr, q13)->k, 3 )
			delete q13
		end scope

		scope
			dim as t2 ptr q22 = new t2(type<t4>(x4))
			CU_ASSERT_EQUAL( q22->i, 1 )
			CU_ASSERT_EQUAL( q22->j, 2 )
			delete q22
		end scope

		scope
			dim as t1 ptr q12 = new t2(type<t4>(x4))
			CU_ASSERT_EQUAL( q12->i, 1 )
			CU_ASSERT_EQUAL( cptr(t2 ptr, q12)->j, 2 )
			delete q12
		end scope

		scope
			dim as t1 ptr q11 = new t1(type<t4>(x4))
			CU_ASSERT_EQUAL( q11->i, 1 )
			delete q11
		end scope

	END_TEST

	TEST( init_new_1 )

		dim as t4 x4 = (1, 2, 3, 4)

		scope
			dim as any ptr p1 = callocate(sizeof(t4))
			dim as t4 ptr p14 = cptr(t4 ptr, new(p1) t2(x4))
			CU_ASSERT_EQUAL( p14->i, 1 )
			CU_ASSERT_EQUAL( p14->j, 2 )
			CU_ASSERT_EQUAL( p14->k, 0 )
			CU_ASSERT_EQUAL( p14->l, 0 )
			deallocate( p1 )
		end scope

		scope
			dim as any ptr p2 = callocate(sizeof(t4))
			dim as t4 ptr p24 = cptr(t4 ptr, new(p2) t2(type<t4>(x4)))
			CU_ASSERT_EQUAL( p24->i, 1 )
			CU_ASSERT_EQUAL( p24->j, 2 )
			CU_ASSERT_EQUAL( p24->k, 0 )
			CU_ASSERT_EQUAL( p24->l, 0 )
			deallocate( p2 )
		end scope

	END_TEST

	TEST( init_array_1 )
		dim as t4 x4 = (1, 2, 3, 4)

		dim as t2 u21(0 to 1) = {x4}
		CU_ASSERT_EQUAL( u21(0).i, 1 )
		CU_ASSERT_EQUAL( u21(0).j, 2 )
		CU_ASSERT_EQUAL( u21(1).i, 0 )
		CU_ASSERT_EQUAL( u21(1).j, 0 )

		dim as t2 u22(0 to 1) = {type<t4>(x4)}
		CU_ASSERT_EQUAL( u22(0).i, 1 )
		CU_ASSERT_EQUAL( u22(0).j, 2 )
		CU_ASSERT_EQUAL( u22(1).i, 0 )
		CU_ASSERT_EQUAL( u22(1).j, 0 )

	END_TEST

	dim shared func_count as integer = 0

	sub reset_count
		func_count = 0
	end sub

	function f() as integer
		func_count += 1
		return func_count
	end function

	TEST( init_func )

		scope
			reset_count
			dim as t4 x4 = type<t4>(f(), f(), f(), f())
			CU_ASSERT_EQUAL( x4.i, 1 )
			CU_ASSERT_EQUAL( x4.j, 2 )
			CU_ASSERT_EQUAL( x4.k, 3 )
			CU_ASSERT_EQUAL( x4.l, 4 )
			CU_ASSERT_EQUAL( func_count, 4 )
		end scope

		scope
			reset_count
			dim as t3 x3 = type<t4>(f(), f(), f(), f())
			CU_ASSERT_EQUAL( x3.i, 1 )
			CU_ASSERT_EQUAL( x3.j, 2 )
			CU_ASSERT_EQUAL( x3.k, 3 )
			CU_ASSERT_EQUAL( func_count, 4 )
		end scope

		scope
			reset_count
			dim as t2 x2 = type<t4>(f(), f(), f(), f())
			CU_ASSERT_EQUAL( x2.i, 1 )
			CU_ASSERT_EQUAL( x2.j, 2 )
			CU_ASSERT_EQUAL( func_count, 4 )
		end scope

		scope
			reset_count
			dim as t1 x1 = type<t4>(f(), f(), f(), f())
			CU_ASSERT_EQUAL( x1.i, 1 )
			CU_ASSERT_EQUAL( func_count, 4 )
		end scope

	END_TEST

END_SUITE
