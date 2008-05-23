# include "fbcu.bi"

#define FALSE 0
#define TRUE -1

namespace fbc_tests.boolean_.field_

	type T1
		i as integer
		b1 as boolean byte
		b4 as boolean integer
		j as integer
	end type

	type T2
		i as integer
		b1 as byte
		b4 as integer
		j as integer
	end type

	union U
		a as T1
		b as T2
	end union

	''
	sub test1 cdecl ( )

		dim as T1 a
		dim as T2 b

		CU_ASSERT_EQUAL( offsetof(T1, i), offsetof(T2, i) )
		CU_ASSERT_EQUAL( offsetof(T1, b1), offsetof(T2, b1) )
		CU_ASSERT_EQUAL( offsetof(T1, b4), offsetof(T2, b4) )
		CU_ASSERT_EQUAL( offsetof(T1, j), offsetof(T2, j) )

	end sub

	''
	sub test2 cdecl ( )

		dim as T1 a

		a.b1 = 0
		CU_ASSERT_EQUAL( a.b1, 0 )

		a.b1 = 1
		CU_ASSERT_EQUAL( a.b1, TRUE )

		a.b1 = 256
		CU_ASSERT_EQUAL( a.b1, TRUE )


		a.b4 = 0
		CU_ASSERT_EQUAL( a.b4, 0 )

		a.b4 = 1
		CU_ASSERT_EQUAL( a.b4, TRUE )

		a.b4 = 256
		CU_ASSERT_EQUAL( a.b4, TRUE )

	end sub

	''
	sub test3 cdecl ( )

		dim as U a

		a.a.b1 = 0
		CU_ASSERT_EQUAL( a.a.b1, 0 )
		CU_ASSERT_EQUAL( a.b.b1, 0 )

		a.a.b1 = 1
		CU_ASSERT_EQUAL( a.a.b1, TRUE )
		CU_ASSERT_EQUAL( a.b.b1, TRUE )

		a.a.b1 = 256
		CU_ASSERT_EQUAL( a.a.b1, TRUE )
		CU_ASSERT_EQUAL( a.b.b1, TRUE )


		a.a.b4 = 0
		CU_ASSERT_EQUAL( a.a.b4, 0 )
		CU_ASSERT_EQUAL( a.b.b4, 0 )

		a.a.b4 = 1
		CU_ASSERT_EQUAL( a.a.b4, TRUE )
		CU_ASSERT_EQUAL( a.b.b4, TRUE )

		a.a.b4 = 256
		CU_ASSERT_EQUAL( a.a.b4, TRUE )
		CU_ASSERT_EQUAL( a.b.b4, TRUE )

	end sub
	
	''
	sub test4 cdecl ( )

		dim as U a

		a.b.b1 = 0
		CU_ASSERT_EQUAL( a.a.b1, 0 )
		CU_ASSERT_EQUAL( a.b.b1, 0 )

		a.b.b1 = 1
		CU_ASSERT_EQUAL( a.a.b1, TRUE )
		CU_ASSERT_EQUAL( a.b.b1, 1 )

		a.b.b1 = 2
		CU_ASSERT_EQUAL( a.a.b1, TRUE )
		CU_ASSERT_EQUAL( a.b.b1, 2 )


		a.b.b4 = 0
		CU_ASSERT_EQUAL( a.a.b4, 0 )
		CU_ASSERT_EQUAL( a.b.b4, 0 )

		a.b.b4 = 1
		CU_ASSERT_EQUAL( a.a.b4, TRUE )
		CU_ASSERT_EQUAL( a.b.b4, 1 )

		a.b.b4 = 256
		CU_ASSERT_EQUAL( a.a.b4, TRUE )
		CU_ASSERT_EQUAL( a.b.b4, 256 )

	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.boolean_.field_")
		fbcu.add_test("test1", @test1)
		fbcu.add_test("test2", @test2)
		fbcu.add_test("test3", @test3)
		fbcu.add_test("test4", @test4)
		
	end sub
	
end namespace
