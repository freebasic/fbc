#include once "fbcunit.bi"

SUITE( fbc_tests.structs.udt_upcast_2 )

	type t1
		i as integer
	end type
	type t2 extends t1
		j as integer
	end type
	type t3 extends t2
		k as integer
	end type

	TEST( initializers )
		dim as integer i, j, k

		#macro incrementValues()
			i += 1
			j = i + 5
			k = i + 13
		#endmacro

		incrementValues()
		scope
			dim x1 as t1 = (i)
			CU_ASSERT_EQUAL( x1.i, i )
		end scope

		incrementValues()
		scope
			dim x2 as t2 = (i, j)
			CU_ASSERT_EQUAL( x2.i, i )
			CU_ASSERT_EQUAL( x2.j, j )
		end scope

		incrementValues()
		scope
			dim x3 as t3 = (i, j, k)
			CU_ASSERT_EQUAL( x3.i, i )
			CU_ASSERT_EQUAL( x3.j, j )
			CU_ASSERT_EQUAL( x3.k, k )
		end scope

		incrementValues()
		scope
			dim x1 as t1 = type(i)
			CU_ASSERT_EQUAL( x1.i, i )
		end scope

		incrementValues()
		scope
			dim x2 as t2 = type(i, j)
			CU_ASSERT_EQUAL( x2.i, i )
			CU_ASSERT_EQUAL( x2.j, j )
		end scope

		incrementValues()
		scope
			dim x3 as t3 = type(i, j, k)
			CU_ASSERT_EQUAL( x3.i, i )
			CU_ASSERT_EQUAL( x3.j, j )
			CU_ASSERT_EQUAL( x3.k, k )
		end scope

		incrementValues()
		scope
			dim x1 as T1 = type<t1>(i)
			CU_ASSERT_EQUAL( x1.i, i )
		end scope

		incrementValues()
		scope
			dim x2 as T2 = type<t2>(i, j)
			CU_ASSERT_EQUAL( x2.i, i )
			CU_ASSERT_EQUAL( x2.j, j )
		end scope

		incrementValues()
		scope
			dim x3 as T3 = type<t3>(i, j, k)
			CU_ASSERT_EQUAL( x3.i, i )
			CU_ASSERT_EQUAL( x3.j, j )
			CU_ASSERT_EQUAL( x3.k, k )
		end scope

		incrementValues()
		scope
			dim px1 as T1 ptr = new T1(i)
			CU_ASSERT_EQUAL( px1->i, i )
			delete px1
		end scope

		incrementValues()
		scope
			dim px2 as T2 ptr = new T2(i, j)
			CU_ASSERT_EQUAL( px2->i, i )
			CU_ASSERT_EQUAL( px2->j, j )
			delete px2
		end scope

		incrementValues()
		scope
			dim px3 as T3 ptr = new T3(i, j, k)
			CU_ASSERT_EQUAL( px3->i, i )
			CU_ASSERT_EQUAL( px3->j, j )
			CU_ASSERT_EQUAL( px3->k, k )
			delete px3
		end scope

	END_TEST

	TEST( upcast_initializer )
		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim y1 as T1 = x2
			CU_ASSERT_EQUAL( y1.i, 2 )
		end scope

		scope
			dim y1 as T1 = x3
			CU_ASSERT_EQUAL( y1.i, 3 )
		end scope

	END_TEST

	TEST( upcast_new_t1 )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim py1 as T1 ptr = new T1(x1)
			CU_ASSERT_EQUAL( py1->i, 1 )
		end scope

		scope
			dim py1 as T1 ptr = new T1(x2)
			CU_ASSERT_EQUAL( py1->i, 2 )
		end scope

		scope
			dim py1 as T1 ptr = new T1(x3)
			CU_ASSERT_EQUAL( py1->i, 3 )
		end scope

	END_TEST

	TEST( upcast_new_polymorphism_1_2 )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim py1 as T1 ptr = new T2(x1)
			CU_ASSERT_EQUAL( py1->i, 1 )
			CU_ASSERT_EQUAL( cast( T2 ptr, py1 )->j, 0 )
		end scope

		scope
			dim py1 as T1 ptr = new T2(x2)
			CU_ASSERT_EQUAL( py1->i, 2 )
			CU_ASSERT_EQUAL( cast( T2 ptr, py1 )->j, 20 )
		end scope

		scope
			dim py1 as T1 ptr = new T2(x3)
			CU_ASSERT_EQUAL( py1->i, 3 )
			CU_ASSERT_EQUAL( cast( T2 ptr, py1 )->j, 30 )
		end scope

	END_TEST

	TEST( upcast_new_polymorphism_1_3 )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim py1 as T1 ptr = new T3(x1)
			CU_ASSERT_EQUAL( py1->i, 1 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 0 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

		scope
			dim py1 as T1 ptr = new T3(x2)
			CU_ASSERT_EQUAL( py1->i, 2 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 20 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

		scope
			dim py1 as T1 ptr = new T3(x3)
			CU_ASSERT_EQUAL( py1->i, 3 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 30 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 300 )
		end scope

	END_TEST

	TEST( upcast_new_polymorphism_2_3 )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim py1 as T2 ptr = new T3(x1)
			CU_ASSERT_EQUAL( py1->i, 1 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 0 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

		scope
			dim py1 as T2 ptr = new T3(x2)
			CU_ASSERT_EQUAL( py1->i, 2 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 20 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

		scope
			dim py1 as T2 ptr = new T3(x3)
			CU_ASSERT_EQUAL( py1->i, 3 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 30 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 300 )
		end scope

	END_TEST

	TEST( upcast_new_with_cast_to_base )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim py1 as T3 ptr = new T3(cast(T1,x1))
			CU_ASSERT_EQUAL( py1->i, 1 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 0 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

		scope
			dim py1 as T3 ptr = new T3(cast(T1,x2))
			CU_ASSERT_EQUAL( py1->i, 2 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 0 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

		scope
			dim py1 as T3 ptr = new T3(cast(T1,x3))
			CU_ASSERT_EQUAL( py1->i, 3 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->j, 0 )
			CU_ASSERT_EQUAL( cast( T3 ptr, py1 )->k, 0 )
		end scope

	END_TEST

	TEST( no_upcast )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim y1 as T3 = (x1, 31, 301)
			CU_ASSERT_EQUAL( y1.i, 1 )
			CU_ASSERT_EQUAL( y1.j, 31 )
			CU_ASSERT_EQUAL( y1.k, 301 )
		end scope

		scope
			dim y1 as T3 = (x2, 301)
			CU_ASSERT_EQUAL( y1.i, 2 )
			CU_ASSERT_EQUAL( y1.j, 20 )
			CU_ASSERT_EQUAL( y1.k, 301 )
		end scope

		scope
			dim y1 as T3 = (x3)
			CU_ASSERT_EQUAL( y1.i, 3 )
			CU_ASSERT_EQUAL( y1.j, 30 )
			CU_ASSERT_EQUAL( y1.k, 300 )
		end scope

	END_TEST

	TEST( no_upcast_with_cast )

		dim x1 as t1 = (1)
		dim x2 as t2 = (2, 20)
		dim x3 as t3 = (3, 30, 300)

		scope
			dim y1 as T3 = (cast(t1,x2), 31, 301)
			CU_ASSERT_EQUAL( y1.i, 2 )
			CU_ASSERT_EQUAL( y1.j, 31 )
			CU_ASSERT_EQUAL( y1.k, 301 )
		end scope

		scope
			dim y1 as T3 = (cast(t1,x3), 31, 301)
			CU_ASSERT_EQUAL( y1.i, 3 )
			CU_ASSERT_EQUAL( y1.j, 31 )
			CU_ASSERT_EQUAL( y1.k, 301 )
		end scope

		scope
			dim y1 as T3 = (cast(t2,x3), 301)
			CU_ASSERT_EQUAL( y1.i, 3 )
			CU_ASSERT_EQUAL( y1.j, 30 )
			CU_ASSERT_EQUAL( y1.k, 301 )
		end scope

	END_TEST

END_SUITE
