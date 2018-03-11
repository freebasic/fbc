# include "fbcunit.bi"

SUITE( fbc_tests.dim_.decl_var_cast )

	type Rational
		declare operator cast () as double
		as integer num, den
	end type
	
	operator Rational.cast () as double
		return iif (0 = den, cast(double, 0), num / den)
	end operator
	
	TEST( declCast )
		dim x as Rational = (3, 4)
		dim float as double = x
		CU_ASSERT( abs(float-.75) < .1 )
	END_TEST

END_SUITE
