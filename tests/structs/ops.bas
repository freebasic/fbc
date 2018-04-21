#include "fbcunit.bi"

SUITE( fbc_tests.structs.ops )

	type mytype
		as integer value
	end type


	#macro makeop(op)
		operator op (byref a as mytype) as string
			return (#op " ") & a.value
		end operator
	#endmacro

	#define testop(op) CU_ASSERT_EQUAL(op(a), #op " 1")


	#macro makebop(op)
		operator op (byref a as mytype, byref b as mytype) as string
			return a.value & (" " #op " ") & b.value
		end operator
	#endmacro

	#define testbop(op) CU_ASSERT_EQUAL(a op b, "1 " #op " 2")


	makeop(ABS)
	makeop(FIX)
	makeop(SGN)
	makeop(FRAC)
	makeop(INT)
	makeop(EXP)
	makeop(LOG)
	makeop(SQR)
	makeop(SIN)
	makeop(ASIN)
	makeop(COS)
	makeop(ACOS)
	makeop(TAN)
	makeop(ATN)
	makeop(LEN)

	makeop(NOT)
	makeop(+)
	makeop(-)

	makebop(+)
	makebop(-)
	makebop(*)
	makebop(/)
	makebop(\)
	makebop(^)
	makebop(&)
	makebop(=)
	makebop(>)
	makebop(<)
	makebop(<>)
	makebop(<=)
	makebop(>=)
	makebop(AND)
	makebop(OR)
	makebop(XOR)
	makebop(IMP)
	makebop(EQV)


	TEST( all )
		dim as mytype a = (1), b = (2)

		testop(ABS)
		testop(FIX)
		testop(SGN)
		testop(FRAC)
		testop(INT)
		testop(EXP)
		testop(LOG)
		testop(SQR)
		testop(SIN)
		testop(ASIN)
		testop(COS)
		testop(ACOS)
		testop(TAN)
		testop(ATN)
		testop(LEN)

		testop(NOT)
		testop(+)
		testop(-)

		testbop(+)
		testbop(-)
		testbop(*)
		testbop(/)
		testbop(\)
		testbop(^)
		testbop(&)
		testbop(=)
		testbop(>)
		testbop(<)
		testbop(<>)
		testbop(<=)
		testbop(>=)
		testbop(AND)
		testbop(OR)
		testbop(XOR)
		testbop(IMP)
		testbop(EQV)

	END_TEST

END_SUITE
