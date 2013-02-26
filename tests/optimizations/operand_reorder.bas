#include "fbcu.bi"

namespace fbc_tests.optimizations.operand_reorder

sub test cdecl( )
	const u1c = 1U, i1c = -2
	var u1 = u1c, i1 = i1c

	const as longint ut = 4294967295LL

	CU_ASSERT_EQUAL( clngint(u1  + i1 ), ut )
	CU_ASSERT_EQUAL( clngint(u1  + i1c), ut )
	CU_ASSERT_EQUAL( clngint(u1c + i1 ), ut )
	CU_ASSERT_EQUAL( clngint(u1c + i1c), ut )

	CU_ASSERT_EQUAL( clngint(i1  + u1 ), ut )
	CU_ASSERT_EQUAL( clngint(i1  + u1c), ut )
	CU_ASSERT_EQUAL( clngint(i1c + u1 ), ut )
	CU_ASSERT_EQUAL( clngint(i1c + u1c), ut )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/operand-reorder" )
	fbcu.add_test( "test", @test )
end sub

end namespace
