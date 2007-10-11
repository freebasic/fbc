# include "fbcu.bi"

#include once "crt/math.bi"

namespace fbc_tests.optimizations.inline_logexpsqr

const EPSILON_SNG as single = 1.1929093e-7
const EPSILON_DBL as double = 2.2204460492503131e-016
	
sub test_log cdecl
	for v as single = 0 to 10 step .1
		CU_ASSERT( abs( log( v ) - logf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = 0 to 10 step .1
		CU_ASSERT( abs( log( v ) - log_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_exp cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( exp( v ) - expf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( exp( v ) - exp_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_sqr cdecl
	for v as single = 0 to 10 step .1
		CU_ASSERT( abs( sqr( v ) - sqrtf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = 0 to 10 step .1
		CU_ASSERT( abs( sqr( v ) - sqrt( v ) ) < EPSILON_DBL )
	next
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:inline logexpsqr")
	fbcu.add_test("log", @test_log)
	fbcu.add_test("exp", @test_exp)
	fbcu.add_test("sqr", @test_sqr)
	
end sub

end namespace

