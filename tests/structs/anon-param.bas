#include "fbcunit.bi"

SUITE( fbc_tests.structs.anon_param )

	type t1
		a as short
	end type

	sub proc1( byval arg as integer, byval compare1 as integer )
		CU_ASSERT( arg = compare1 )
	end sub

	sub proc2( byref arg as t1, byval compare1 as integer )
		CU_ASSERT( arg.a = compare1 )
	end sub


	TEST( test1 )
		scope
			dim x as integer
			x = type<integer>1
			proc1( x, 1 )
			x = type<integer>(2)
			proc1( x, 2 )
			x = type<integer>((3))
			proc1( x, 3 )
			x = (type<integer>4)
			proc1( x, 4 )
			x = (type<integer>(5))
			proc1( x, 5 )
			x = (type<integer>((6)))
			proc1( x, 6 )
			x = ((type<integer>((7))))
			proc1( x, 7 )
		end scope
		scope
			dim x1 as integer = type<integer>1
			CU_ASSERT( x1 = 1 )
			dim x2 as integer = type<integer>(2)
			CU_ASSERT( x2 = 2 )
			dim x3 as integer = type<integer>((3))
			CU_ASSERT( x3 = 3 )
			dim x4 as integer = (type<integer>4)
			CU_ASSERT( x4 = 4 )
			dim x5 as integer = (type<integer>(5))
			CU_ASSERT( x5 = 5 )
			dim x6 as integer = (type<integer>((6)))
			CU_ASSERT( x6 = 6 )
			dim x7 as integer = ((type<integer>((7))))
			CU_ASSERT( x7 = 7 )
		end scope
		scope
			proc1  1, 1
			proc1( 2, 2 )
			proc1   type<integer>3 ,  3
			proc1  (type<integer>4),  4
			proc1   type<integer>5 , (5)
			proc1 ( type<integer>6 ,  6 )
			proc1 ((type<integer>7),  7 )
			proc1 ( type<integer>8 , (8))
		end scope
	END_TEST

	TEST( test2 )
		scope
			dim x as t1
			x = type<t1>(2)
			proc2( x, 2 )
			x = type<t1>((3))
			proc2( x, 3 )
			x = (type<t1>(5))
			proc2( x, 5 )
			x = (type<t1>((6)))
			proc2( x, 6 )
			x = ((type<t1>((7))))
			proc2( x, 7 )
		end scope
		scope
			dim x2 as t1 = type<t1>(2)
			proc2( x2, 2 )
			dim x3 as t1 = type<t1>((3))
			proc2( x3, 3 )
			dim x5 as t1 = (type<t1>(5))
			proc2( x5, 5 )
			dim x6 as t1 = (type<t1>((6)))
			proc2( x6, 6 )
			dim x7 as t1 = ((type<t1>((7))))
			proc2( x7, 7 )
		end scope
		scope
			proc2   type<t1>(3) ,  3
			proc2  (type<t1>(4)),  4
			proc2   type<t1>(5) , (5)
			proc2 ( type<t1>(6) ,  6 )
			proc2 ((type<t1>(7)),  7 )
			proc2 ( type<t1>(8) , (8))

			proc2   type<t1>(((3))) ,  3
			proc2  (type<t1>(((4)))),  4
			proc2   type<t1>(((5))) , (5)
			proc2 ( type<t1>(((6))) ,  6 )
			proc2 ((type<t1>(((7)))),  7 )
			proc2 ( type<t1>(((8))) , (8))
		end scope
	END_TEST

	TEST( test3 )
		scope
			dim x as t1, y as t1
			y.a = 2
			x = type<t1>(y)
			proc2( x, 2 )
			y.a = 4
			x = type<t1>((y))
			proc2( x, 4 )
			y.a = 5
			x = (type<t1>(y))
			proc2( x, 5 )
			y.a = 6
			x = (type<t1>((y)))
			proc2( x, 6 )
			y.a = 7
			x = ((type<t1>((y))))
			proc2( x, 7 )
		end scope
		scope
			dim x as t1, y as t1
			y.a = 2
			x = type<t1>(y.a)
			proc2( x, 2 )
			y.a = 4
			x = type<t1>((y.a))
			proc2( x, 4 )
			y.a = 5
			x = (type<t1>(y.a))
			proc2( x, 5 )
			y.a = 6
			x = (type<t1>((y.a)))
			proc2( x, 6 )
			y.a = 7
			x = ((type<t1>((y.a))))
			proc2( x, 7 )
		end scope
		scope
			dim x as t1, y as t1
			y.a = 4
			x = type<t1>((y).a)
			proc2( x, 4 )
			y.a = 6
			x = (type<t1>((y).a))
			proc2( x, 6 )
			y.a = 7
			x = ((type<t1>((y).a)))
			proc2( x, 7 )
		end scope
		scope
			dim x as t1, y as t1
			y.a = 4
			x = type<t1>(((y)).a)
			proc2( x, 4 )
			y.a = 6
			x = (type<t1>(((y)).a))
			proc2( x, 6 )
			y.a = 7
			x = ((type<t1>(((y)).a)))
			proc2( x, 7 )
		end scope
	END_TEST

	TEST( test4 )
		scope
			dim y as t1
			y.a = 2
			dim x2 as t1 = type<t1>(y)
			proc2( x2, 2 )
			y.a = 4
			dim x4 as t1 = type<t1>((y))
			proc2( x4, 4 )
			y.a = 5
			dim x5 as t1 = (type<t1>(y))
			proc2( x5, 5 )
			y.a = 6
			dim x6 as t1 = (type<t1>((y)))
			proc2( x6, 6 )
			y.a = 7
			dim x7 as t1 = ((type<t1>((y))))
			proc2( x7, 7 )
		end scope
		scope
			dim y as t1
			y.a = 2
			dim x2 as t1  = type<t1>(y.a)
			proc2( x2, 2 )
			y.a = 4
			dim x4 as t1  = type<t1>((y.a))
			proc2( x4, 4 )
			y.a = 5
			dim x5 as t1  = (type<t1>(y.a))
			proc2( x5, 5 )
			y.a = 6
			dim x6 as t1  = (type<t1>((y.a)))
			proc2( x6, 6 )
			y.a = 7
			dim x7 as t1 = ((type<t1>((y.a))))
			proc2( x7, 7 )
		end scope
		scope
			dim y as t1
			y.a = 4
			dim x4 as t1 = type<t1>((y).a)
			proc2( x4, 4 )
			y.a = 6
			dim x6 as t1 = (type<t1>((y).a))
			proc2( x6, 6 )
			y.a = 7
			dim x7 as t1 = ((type<t1>((y).a)))
			proc2( x7, 7 )
		end scope
		scope
			dim y as t1
			y.a = 4
			dim x4 as t1 = type<t1>(((y)).a)
			proc2( x4, 4 )
			y.a = 6
			dim x6 as t1 = (type<t1>(((y)).a))
			proc2( x6, 6 )
			y.a = 7
			dim x7 as t1 = ((type<t1>(((y)).a)))
			proc2( x7, 7 )
		end scope
	END_TEST

	TEST( test5 )
		scope
			dim y as t1
			y.a = 3
			proc2   type<t1>(y) ,  3
			y.a = 4
			proc2  (type<t1>(y)),  4
			y.a = 5
			proc2   type<t1>(y) , (5)
			y.a = 6
			proc2 ( type<t1>(y) ,  6 )
			y.a = 7
			proc2 ((type<t1>(y)),  7 )
			y.a = 8
			proc2 ( type<t1>(y) , (8))

			y.a = 3
			proc2   type<t1>((y)) ,  3
			y.a = 4
			proc2  (type<t1>((y))),  4
			y.a = 5
			proc2   type<t1>((y)) , (5)
			y.a = 6
			proc2 ( type<t1>((y)) ,  6 )
			y.a = 7
			proc2 ((type<t1>((y))),  7 )
			y.a = 8
			proc2 ( type<t1>((y)) , (8))
		end scope
		scope
			dim y as t1
			y.a = 3
			proc2   type<t1>(y.a) ,  3
			y.a = 4
			proc2  (type<t1>(y.a)),  4
			y.a = 5
			proc2   type<t1>(y.a) , (5)
			y.a = 6
			proc2 ( type<t1>(y.a) ,  6 )
			y.a = 7
			proc2 ((type<t1>(y.a)),  7 )
			y.a = 8
			proc2 ( type<t1>(y.a) , (8))

			y.a = 3
			proc2   type<t1>((y.a)) ,  3
			y.a = 4
			proc2  (type<t1>((y.a))),  4
			y.a = 5
			proc2   type<t1>((y.a)) , (5)
			y.a = 6
			proc2 ( type<t1>((y.a)) ,  6 )
			y.a = 7
			proc2 ((type<t1>((y.a))),  7 )
			y.a = 8
			proc2 ( type<t1>((y.a)) , (8))
		end scope
		scope
			dim y as t1
			y.a = 3
			proc2   type<t1>((y).a) ,  3
			y.a = 4
			proc2  (type<t1>((y).a)),  4
			y.a = 5
			proc2   type<t1>((y).a) , (5)
			y.a = 6
			proc2 ( type<t1>((y).a) ,  6 )
			y.a = 7
			proc2 ((type<t1>((y).a)),  7 )
			y.a = 8
			proc2 ( type<t1>((y).a) , (8))
		end scope
		scope
			dim y as t1
			y.a = 3
			proc2   type<t1>(((y).a)) ,  3
			y.a = 4
			proc2  (type<t1>(((y).a))),  4
			y.a = 5
			proc2   type<t1>(((y).a)) , (5)
			y.a = 6
			proc2 ( type<t1>(((y).a)) ,  6 )
			y.a = 7
			proc2 ((type<t1>(((y).a))),  7 )
			y.a = 8
			proc2 ( type<t1>(((y).a)) , (8))
		end scope
		scope
			dim y as t1
			y.a = 3
			proc2   type<t1>(((y).a+1)) ,  3+1
			y.a = 4
			proc2  (type<t1>(((y).a+1))),  4+1
			y.a = 5
			proc2   type<t1>(((y).a+1)) , (5+1)
			y.a = 6
			proc2 ( type<t1>(((y).a+1)) ,  6+1 )
			y.a = 7
			proc2 ((type<t1>(((y).a+1))),  7+1 )
			y.a = 8
			proc2 ( type<t1>(((y).a+1)) , (8+1))
		end scope
	END_TEST

END_SUITE
