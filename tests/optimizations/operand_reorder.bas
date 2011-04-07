# include "fbcu.bi"

namespace fbc_tests.optimizations.operand_reorder

	sub test_int_uint cdecl ()

		const u1c = 1U, i1c = -2
		var u1 = u1c, i1 = i1c

		const as longint ut = 4294967295ULL, it = -1LL

		CU_ASSERT_EQUAL( clngint(u1  + i1 ), ut )
		CU_ASSERT_EQUAL( clngint(u1  + i1c), ut )
		CU_ASSERT_EQUAL( clngint(u1c + i1 ), ut )
		CU_ASSERT_EQUAL( clngint(u1c + i1c), ut )

		CU_ASSERT_EQUAL( clngint(i1  + u1 ), it )
		CU_ASSERT_EQUAL( clngint(i1  + u1c), it )
		CU_ASSERT_EQUAL( clngint(i1c + u1 ), it )
		CU_ASSERT_EQUAL( clngint(i1c + u1c), it )

	end sub

	private sub ctor () constructor

		fbcu.add_suite("fbc_tests-optimizations:operand reordering")
		fbcu.add_test("test_int_uint", @test_int_uint)

	end sub

end namespace
