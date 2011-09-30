# include "fbcu.bi"

#include once "crt/math.bi"

namespace fbc_tests.optimizations.inline_fixfrac

const EPSILON_SNG as single = 1.1929093e-7
const EPSILON_DBL as double = 2.2204460492503131e-016
	
#define hFixF(x) (floorf( abs( (x) ) ) * sgn( (x) ))
#define hFixD(x) (floor( abs( (x) ) ) * sgn( (x) ))

sub test_fix cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( fix( v ) - hFixF( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( fix( v ) - hFixD( v ) ) < EPSILON_DBL )
	next
end sub

sub test_frac cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( frac( v ) - (v - hFixF( v )) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( frac( v ) - (v - hFixD( v )) ) < EPSILON_DBL )
	next
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:inline fixfrac")
	fbcu.add_test("fix", @test_fix)
	fbcu.add_test("frac", @test_frac)
	
end sub

end namespace

