#include once "fbcunit.bi"

enum enumDecl1
	A = 1
	B = 2
end enum

enum enumDecl2
	A = 3
	C = 4
end enum

enum enumDecl3 explicit
	A = 5
	B = 6
end enum

namespace enumNS1

	enum enumDecl1
		A = 11
		B = 12
	end enum

	enum enumDecl2
		A = 13
		C = 14
	end enum

	enum enumDecl3 explicit
		A = 15
		B = 16
	end enum

	namespace enumNS2

		enum enumDecl1
			A = 121
			B = 122
		end enum

		enum enumDecl2
			A = 123
			C = 124
		end enum

		enum enumDecl3 explicit
			A = 125
			B = 126
		end enum

	end namespace

end namespace

SUITE( fbc_tests.namespace_.enum_decls )

	TEST( default )

		'' CU_ASSERT_EQUAL( A, 1 ) '' ambiguous (expected)
		CU_ASSERT_EQUAL( B, 2 )
		CU_ASSERT_EQUAL( C, 4 )

		CU_ASSERT_EQUAL( enumDecl1.A, 1 )
		CU_ASSERT_EQUAL( enumDecl1.B, 2 )

		CU_ASSERT_EQUAL( enumDecl2.A, 3 )
		CU_ASSERT_EQUAL( enumDecl2.C, 4 )

		CU_ASSERT_EQUAL( enumDecl3.A, 5 )
		CU_ASSERT_EQUAL( enumDecl3.B, 6 )

		CU_ASSERT_EQUAL( enumNS1.enumDecl1.A, 11 )
		CU_ASSERT_EQUAL( enumNS1.enumDecl1.B, 12 )

		CU_ASSERT_EQUAL( enumNS1.enumDecl2.A, 13 )
		CU_ASSERT_EQUAL( enumNS1.enumDecl2.C, 14 )

		CU_ASSERT_EQUAL( enumNS1.enumDecl3.A, 15 )
		CU_ASSERT_EQUAL( enumNS1.enumDecl3.B, 16 )

		CU_ASSERT_EQUAL( enumNS1.enumNS2.enumDecl1.A, 121 )
		CU_ASSERT_EQUAL( enumNS1.enumNS2.enumDecl1.B, 122 )

		CU_ASSERT_EQUAL( enumNS1.enumNS2.enumDecl2.A, 123 )
		CU_ASSERT_EQUAL( enumNS1.enumNS2.enumDecl2.C, 124 )

		CU_ASSERT_EQUAL( enumNS1.enumNS2.enumDecl3.A, 125 )
		CU_ASSERT_EQUAL( enumNS1.enumNS2.enumDecl3.B, 126 )

	END_TEST

END_SUITE
