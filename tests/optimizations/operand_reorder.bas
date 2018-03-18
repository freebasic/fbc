#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.operand_reorder )

	#macro TEST_OP(n1, n2, op, n3)
	scope

		const n1c as typeof(n1) = (n1), n2c as typeof(n2) = (n2)
		dim n1v as typeof(n1) = n1c, n2v as typeof(n2) = n2c

		CU_ASSERT_EQUAL( str(n1c op n2c), str(n3) )
		CU_ASSERT_EQUAL( str(n1c op n2v), str(n3) )
		CU_ASSERT_EQUAL( str(n1v op n2c), str(n3) )
		CU_ASSERT_EQUAL( str(n1v op n2v), str(n3) )

	end scope
	#endmacro

	TEST( integer_ )

		'' These tests ensure that swapping the operands doesn't change the result,
		'' and also that mixing signed and unsigned integers results in an unsigned integer.

		'' Note: all negative constants seen are converted to uinteger,
		'' either explicitly with cuint() or implicitly by combining in an op with a uinteger.


		'' arithmetic ops
		TEST_OP(cuint(1), cint(-2), +, cuint(-1))
		TEST_OP(cint(-2), cuint(1), +, cuint(-1))

		TEST_OP(cuint(2), cint(-3), *, cuint(-6))
		TEST_OP(cint(-2), cuint(3), *, cuint(-6))

		TEST_OP(cuint(1), cint(3),  -, cuint(-2))
		TEST_OP(cint(1), cuint(3),  -, cuint(-2))


		'' (test that the '\' op is never swapped)
		TEST_OP(cint(-4), cuint(2), \, cuint(-4) shr 1)
		TEST_OP(cuint(4), cint(-2), \, cuint(0))


		'' bitwise ops
		TEST_OP(cuint(-2), cint(-3), AND, cuint(-4))
		TEST_OP(cint(-2), cuint(-3), AND, cuint(-4))

		TEST_OP(cuint(1), cint(-4),  OR,  cuint(-3))
		TEST_OP(cint(-4), cuint(1),  OR,  cuint(-3))

		TEST_OP(cuint(2), cint(-1),  XOR, cuint(-3))
		TEST_OP(cint(-1), cuint(2),  XOR, cuint(-3))

		TEST_OP(cuint(1), cint(2),   EQV, cuint(-4))
		TEST_OP(cint(1), cuint(2),   EQV, cuint(-4))


		'' equality and nonequality ops
		TEST_OP(cuint(-1), cint(-1), =, -1)
		TEST_OP(cint(-1), cuint(-1), =, -1)
		TEST_OP(cuint(1), cint(-1), =, 0)
		TEST_OP(cint(-1), cuint(1), =, 0)

		TEST_OP(cuint(-1), cint(-1), <>, 0)
		TEST_OP(cint(-1), cuint(-1), <>, 0)
		TEST_OP(cuint(1), cint(-1), <>, -1)
		TEST_OP(cint(-1), cuint(1), <>, -1)


		'' inequality ops
		TEST_OP(cuint(1), cint(2), >,  0)
		TEST_OP(cint(2), cuint(2), >,  0)
		TEST_OP(cuint(3), cint(2), >, -1)

		TEST_OP(cuint(1), cint(2), >=,  0)
		TEST_OP(cint(2), cuint(2), >=, -1)
		TEST_OP(cuint(3), cint(2), >=, -1)

		TEST_OP(cuint(1), cint(2), <, -1)
		TEST_OP(cint(2), cuint(2), <,  0)
		TEST_OP(cuint(3), cint(2), <,  0)

		TEST_OP(cuint(1), cint(2), <=, -1)
		TEST_OP(cint(2), cuint(2), <=, -1)
		TEST_OP(cuint(3), cint(2), <=,  0)


		'' signedness of inequality comparison ops
		TEST_OP(cint(-1), cuint(0), > , -1)
		TEST_OP(cint(-1), cuint(0), >=, -1)
		TEST_OP(cint(-1), cuint(0), < ,  0)
		TEST_OP(cint(-1), cuint(0), <=,  0)

		TEST_OP(cuint(0), cint(-1), > ,  0)
		TEST_OP(cuint(0), cint(-1), >=,  0)
		TEST_OP(cuint(0), cint(-1), < , -1)
		TEST_OP(cuint(0), cint(-1), <=, -1)

	END_TEST

END_SUITE
