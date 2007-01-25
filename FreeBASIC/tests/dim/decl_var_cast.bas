# include "fbcu.bi"

namespace fbc_tests.dim_.decl_var_cast

	type Rational
		declare operator cast () as double
		as integer num, den
	end type
	
	operator Rational.cast () as double
		return iif (0 = den, cast(double, 0), num / den)
	end operator
	
	sub test_decl_cast cdecl ()
		dim x as Rational = (3, 4)
		dim float as double = x
		CU_ASSERT( abs(float-.75) < .1 )
	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.dim.decl_var_cast")
		fbcu.add_test("test_decl_Cast", @test_decl_cast)
	
	end sub

end namespace
	