# include "fbcu.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

namespace fbc_tests.boolean_.bitfield
	type T1
		union
			type
				as boolean b0:1
				as boolean b1:1
				as boolean b2:1
				as boolean b3:1
			end type
			type
				as byte xb0:1
				as byte xb1:1
				as byte xb2:1
				as byte xb3:1
			end type
		end union
	end type

	sub test1 cdecl ( )
		dim as T1 a

		a.xb1 = 1

		CU_ASSERT_EQUAL( a.xb0, 0 )
		CU_ASSERT_EQUAL( a.xb1, 1 )
		CU_ASSERT_EQUAL( a.xb2, 0 )
		CU_ASSERT_EQUAL( a.xb3, 0 )

		CU_ASSERT_EQUAL( a.b0, 0 )
		CU_ASSERT_EQUAL( a.b1, -1 )
		CU_ASSERT_EQUAL( a.b2, 0 )
		CU_ASSERT_EQUAL( a.b3, 0 )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fbc_tests.boolean.boolean_bitfield")
		fbcu.add_test("test1", @test1)
	end sub
end namespace
