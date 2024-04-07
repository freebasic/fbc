#include once "fbcunit.bi"

enum enumShadowDecl1
	enumShadowA = 1
	enumShadowB = 2
end enum

dim shared enumShadowA as string

private sub module_proc()

	'' explicit
	CU_ASSERT_EQUAL( enumShadowDecl1.enumShadowA, 1 )
	CU_ASSERT_EQUAL( enumShadowDecl1.enumShadowB, 2 )
	CU_ASSERT_EQUAL( ..enumShadowA, "" )

	'' implicit
	CU_ASSERT_EQUAL( enumShadowA, "" )
	CU_ASSERT_EQUAL( enumShadowB, 2 )
end sub

namespace enumShadowNS

	sub proc()
		'' explicit
		CU_ASSERT_EQUAL( enumShadowDecl1.enumShadowA, 1 )
		CU_ASSERT_EQUAL( enumShadowDecl1.enumShadowB, 2 )
		CU_ASSERT_EQUAL( ..enumShadowA, "" )

		'' implicit
		CU_ASSERT_EQUAL( enumShadowA, "" )
		CU_ASSERT_EQUAL( enumShadowB, 2 )
	end sub

end namespace

SUITE( fbc_tests.namespace_.enum_shadowed_by_var )

	TEST( default )

		module_proc()
		enumShadowNS.proc()

	END_TEST

END_SUITE
