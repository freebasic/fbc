# include "fbcu.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

namespace fbc_tests.boolean_.field_

	type T1
		i as integer
		b as boolean
		j as integer
	end type

	type T2
		i as integer
		b as byte
		j as integer
	end type

	union U
		a as T1
		b as T2
	end union

	sub test1 cdecl ( )
		dim as T1 a
		dim as T2 b

		CU_ASSERT_EQUAL( offsetof(T1, i), offsetof(T2, i) )
		CU_ASSERT_EQUAL( offsetof(T1, b), offsetof(T2, b) )
		CU_ASSERT_EQUAL( offsetof(T1, j), offsetof(T2, j) )
	end sub

	sub test2 cdecl ( )
		dim as T1 a

		a.b = 0
		CU_ASSERT_EQUAL( a.b, 0 )

		a.b = 1
		CU_ASSERT_EQUAL( a.b, TRUE )

		a.b = 256
		CU_ASSERT_EQUAL( a.b, TRUE )
	end sub

	sub test3 cdecl ( )
		dim as U a

		a.a.b = 0
		CU_ASSERT_EQUAL( a.a.b, 0 )
		CU_ASSERT_EQUAL( a.b.b, 0 )

		a.a.b = 1
		CU_ASSERT_EQUAL( a.a.b, TRUE )
		CU_ASSERT_EQUAL( a.b.b, 1 )

		a.a.b = 256
		CU_ASSERT_EQUAL( a.a.b, TRUE )
		CU_ASSERT_EQUAL( a.b.b, 1 )
	end sub

	sub test4 cdecl ( )
		dim as U a

		'' Storing into the byte, instead of the boolean -- should only
		'' write values that are valid for the boolean type.

		a.b.b = 0
		CU_ASSERT_EQUAL( a.a.b, 0 )
		CU_ASSERT_EQUAL( a.b.b, 0 )

		a.b.b = 1
		CU_ASSERT_EQUAL( a.a.b, TRUE )
		CU_ASSERT_EQUAL( a.b.b, 1 )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fbc_tests.boolean.boolean_field")
		fbcu.add_test("test1", @test1)
		fbcu.add_test("test2", @test2)
		fbcu.add_test("test3", @test3)
		fbcu.add_test("test4", @test4)
	end sub

end namespace
