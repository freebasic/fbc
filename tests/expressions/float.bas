#include "fbcunit.bi"

SUITE( fbc_tests.expressions.float )

	const EPSILON_SNG as single = 1.1929093e-7

	TEST( regression1 )
		'' Regression test: The complex expression below triggered a bug with spilling
		'' of x86 FPU stack registers in the ASM backend.

		'' In the hopes of ensuring the expression is evaluated correctly (i.e.
		'' correct code is generated despite the spilling), we
		''  - use multiple different input values
		''  - and check the single expression's result against that of the same
		''    calculation split up into multiple statements. This makes a difference
		''    to the ASM backend, because register usage is reset between statements,
		''    and there shouldn't be spilling when introducing temp vars manually.
		#macro check(VarType, constant)
			for i1 as integer = 0 to 3
			for i2 as integer = 0 to 3
			for i3 as integer = 0 to 3
				dim as VarType t = i1
				dim as VarType a = i2
				dim as VarType b = i3

				var temp0 = a + (constant * b)
				var temp1 = a + (t * temp0)
				var temp2 = a + (t * temp1)
				var temp3 = b + (t * temp2)
				dim as VarType result1 = temp3

				#define expr b + (t * (a + (t * (a + (t * (a + constant * b))))))
				CU_ASSERT( abs( (expr) - result1 ) < EPSILON_SNG )
				dim as VarType result2 = (expr)
				CU_ASSERT( abs( result1 - result2 ) < EPSILON_SNG )
				#undef expr
			next
			next
			next
		#endmacro

		check( single, 1.0f )
		check( single, 1.0  )
		check( double, 1.0f )
		check( double, 1.0  )
	END_TEST

END_SUITE
