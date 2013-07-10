#include "fbcu.bi"

namespace fbc_tests.optimizations.operand_reorder

#macro TEST_OP(n1, n2, op, n3)
scope

	const n1c as typeof(n1) = (n1), n2c as typeof(n2) = (n2)
	dim n1v as typeof(n1) = n1c, n2v as typeof(n2) = n2c

	CU_ASSERT_EQUAL( n1c op n2c, clngint(n3) )
	CU_ASSERT_EQUAL( n1c op n2v, clngint(n3) )
	CU_ASSERT_EQUAL( n1v op n2c, clngint(n3) )
	CU_ASSERT_EQUAL( n1v op n2v, clngint(n3) )

end scope
#endmacro

sub test_int cdecl( )

	TEST_OP(cuint(1), cint(-2), +, cuint(-1))
	TEST_OP(cint(-2), cuint(1), +, cuint(-1))

	TEST_OP(cuint(2), cint(-3), *, cuint(-6))
	TEST_OP(cint(-2), cuint(3), *, cuint(-6))

	TEST_OP(cuint(1), cint(3),  -, cuint(-2))
	TEST_OP(cint(1), cuint(3),  -, cuint(-2))

	TEST_OP(cint(-4), cuint(2), \, cuint(-4) shr 1)
	TEST_OP(cuint(4), cint(-2), \, cuint(0))


	TEST_OP(cuint(-2), cint(-3), AND, cuint(-4))
	TEST_OP(cint(-2), cuint(-3), AND, cuint(-4))

	TEST_OP(cuint(1), cint(-4),  OR,  cuint(-3))
	TEST_OP(cint(-4), cuint(1),  OR,  cuint(-3))

	TEST_OP(cuint(2), cint(-1),  XOR, cuint(-3))
	TEST_OP(cint(-1), cuint(2),  XOR, cuint(-3))

	TEST_OP(cuint(1), cint(2),   EQV, cuint(-4))
	TEST_OP(cint(1), cuint(2),   EQV, cuint(-4))


	TEST_OP(cuint(-1), cint(-1), =, -1)
	TEST_OP(cint(-1), cuint(-1), =, -1)
	TEST_OP(cuint(1), cint(-1), =, 0)
	TEST_OP(cint(-1), cuint(1), =, 0)

	TEST_OP(cuint(-1), cint(-1), <>, 0)
	TEST_OP(cint(-1), cuint(-1), <>, 0)
	TEST_OP(cuint(1), cint(-1), <>, -1)
	TEST_OP(cint(-1), cuint(1), <>, -1)


end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/operand-reorder" )
	fbcu.add_test( "test_int", @test_int )
end sub

end namespace
