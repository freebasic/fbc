# include "fbcu.bi"

#include once "crt/math.bi"

namespace fbc_tests.optimizations.inline_trans

const EPSILON_SNG as single = 1.1929093e-7
const EPSILON_DBL as double = 2.2204460492503131e-016
	
sub test_sin cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( sin( v ) - sinf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( sin( v ) - sin_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_asin cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( asin( v ) - asinf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( asin( v ) - asin_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_cos cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( cos( v ) - cosf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( cos( v ) - cos_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_acos cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( acos( v ) - acosf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( acos( v ) - acos_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_tan cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( tan( v ) - tanf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( tan( v ) - tan_( v ) ) < EPSILON_DBL )
	next
end sub

sub test_atan cdecl
	for v as single = -1 to 1 step .01
		CU_ASSERT( abs( atn( v ) - atanf( v ) ) < EPSILON_SNG )
	next
	
	for v as double = -1 to 1 step .01
		CU_ASSERT( abs( atn( v ) - atan_( v ) ) < EPSILON_DBL )
	next
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:inline transcendental")
	fbcu.add_test("sin", @test_sin)
	fbcu.add_test("asin", @test_asin)
	fbcu.add_test("cos", @test_cos)
	fbcu.add_test("acos", @test_acos)
	fbcu.add_test("tan", @test_tan)
	fbcu.add_test("atan", @test_atan)
	
end sub

end namespace

