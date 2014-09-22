# include "fbcu.bi"

#include once "crt/math.bi"

namespace fbc_tests.optimizations.inline_ops

const EPSILON_SNG as single = 1.19290929e-7
const EPSILON_DBL as double = 2.2204460492503131e-016

#define hFixF( x ) (floorf( abs( x ) ) * sgn( x ))
#define hFixD( x ) ( floor( abs( x ) ) * sgn( x ))

private function hSgnF( byval v as single ) as single
	if( v = 0 ) then
		function = 0
	elseif( v > 0 ) then
		function = 1
	else
		function = -1
	end if
end function

private function hSgnD( byval v as double ) as double
	if( v = 0 ) then
		function = 0
	elseif( v > 0 ) then
		function = 1
	else
		function = -1
	end if
end function

private sub test cdecl( )

	scope
		dim as long l
		dim as longint ll

		l = 0           : CU_ASSERT_EQUAL( sgn( l ), 0 )
		l = 1           : CU_ASSERT_EQUAL( sgn( l ), 1 )
		l = 2           : CU_ASSERT_EQUAL( sgn( l ), 1 )
		l = &h7FFFFFFF  : CU_ASSERT_EQUAL( sgn( l ), 1 )
		l = -1          : CU_ASSERT_EQUAL( sgn( l ), -1 )
		l = -2          : CU_ASSERT_EQUAL( sgn( l ), -1 )
		l = &hFFFFFFFFl : CU_ASSERT_EQUAL( sgn( l ), -1 )
		l = &h80000000l : CU_ASSERT_EQUAL( sgn( l ), -1 )

		ll = 0                    : CU_ASSERT_EQUAL( sgn( ll ), 0 )
		ll = 1                    : CU_ASSERT_EQUAL( sgn( ll ), 1 )
		ll = 2                    : CU_ASSERT_EQUAL( sgn( ll ), 1 )
		ll = &h7FFFFFFF           : CU_ASSERT_EQUAL( sgn( ll ), 1 )
		ll = &hFFFFFFFFll         : CU_ASSERT_EQUAL( sgn( ll ), 1 )
		ll = &h80000000ll         : CU_ASSERT_EQUAL( sgn( ll ), 1 )
		ll = &h7FFFFFFFFFFFFFFFll : CU_ASSERT_EQUAL( sgn( ll ), 1 )
		ll = -1                   : CU_ASSERT_EQUAL( sgn( ll ), -1 )
		ll = -2                   : CU_ASSERT_EQUAL( sgn( ll ), -1 )
		ll = &hFFFFFFFFFFFFFFFFll : CU_ASSERT_EQUAL( sgn( ll ), -1 )
		ll = &h8000000000000000ll : CU_ASSERT_EQUAL( sgn( ll ), -1 )
	end scope

	'' Not all the abs() tests below are useful to test abs(), but they
	'' also help testing -gen gcc's number literal emitting.
	scope
		dim as single float0 =   0.0f
		dim as single float1 =   1.0f
		dim as single float2 = - 1.0f
		dim as single float4 =   3.141592f
		dim as single float5 =   1.0e+10f
		dim as single float6 =   1.0e-10f

		CU_ASSERT_EQUAL( abs(float0), 0.0f )
		CU_ASSERT_EQUAL( abs(float1), 1.0f )
		CU_ASSERT_EQUAL( abs(float2), 1.0f )
		CU_ASSERT_EQUAL( abs(float4), 3.141592f )
		CU_ASSERT_EQUAL( abs(float5), 1.0e+10f )
		CU_ASSERT_EQUAL( abs(float6), 1.0e-10f )
	end scope

	scope
		dim as double double0 =   0.0
		dim as double double1 =   1.0
		dim as double double2 = - 1.0
		dim as double double4 =   3.14159265
		dim as double double5 =   1.0e+10
		dim as double double6 =   1.0e-10

		CU_ASSERT_EQUAL( abs(double0), 0.0 )
		CU_ASSERT_EQUAL( abs(double1), 1.0 )
		CU_ASSERT_EQUAL( abs(double2), 1.0 )
		CU_ASSERT_EQUAL( abs(double4), 3.14159265 )
		CU_ASSERT_EQUAL( abs(double5), 1.0e+10 )
		CU_ASSERT_EQUAL( abs(double6), 1.0e-10 )
	end scope

	scope
		dim as integer int0 =   0
		dim as integer int1 =   1
		dim as integer int2 = - 1
		dim as integer int3 =   2147483647
		dim as integer int4 = - 2147483648u

		CU_ASSERT_EQUAL( abs(int0),   0 )
		CU_ASSERT_EQUAL( abs(int1),   1 )
		CU_ASSERT_EQUAL( abs(int2),   1 )
		CU_ASSERT_EQUAL( abs(int3),   2147483647 )
#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( abs(int4), 2147483648u )
#else
		CU_ASSERT_EQUAL( abs(int4), - 2147483648u ) '' overflows back to same number
		CU_ASSERT_EQUAL( abs(clngint(int4)), 2147483648ll ) '' this one should work though
#endif
	end scope

	scope
		dim as longint longint0 =   0ll
		dim as longint longint1 =   1ll
		dim as longint longint2 = - 1ll
		dim as longint longint3 =   9223372036854775807ll
		dim as longint longint4 = - 9223372036854775808ull
		dim as longint longint5 = - 2147483648ll

		CU_ASSERT_EQUAL( abs(longint0),   0ll )
		CU_ASSERT_EQUAL( abs(longint1),   1ll )
		CU_ASSERT_EQUAL( abs(longint2),   1ll )
		CU_ASSERT_EQUAL( abs(longint3),   9223372036854775807ll )
		CU_ASSERT_EQUAL( abs(longint4), - 9223372036854775808ull ) '' overflows back to same number
		CU_ASSERT_EQUAL( abs(longint5),   2147483648ll ) '' -gen gcc regression test
	end scope

	for v as single = -3 to 3 step .03
		CU_ASSERT_EQUAL( sgn( v ), hSgnF( v ) )
		CU_ASSERT_DOUBLE_EQUAL( int( v ), floorf( v ), EPSILON_SNG )
	next
	for v as double = -3 to 3 step .03
		CU_ASSERT_EQUAL( sgn( v ), hSgnD( v ) )
		CU_ASSERT_DOUBLE_EQUAL( int( v ), floor( v ), EPSILON_DBL )
	next

	for v as single = -1 to 1 step .01
		CU_ASSERT_DOUBLE_EQUAL( frac( v ), (v - hFixF( v )) , EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL(  fix( v ), hFixF( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL(  sin( v ),  sinf( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL( asin( v ), asinf( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL(  cos( v ),  cosf( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL( acos( v ), acosf( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL(  tan( v ),  tanf( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL(  atn( v ), atanf( v ), EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL(  exp( v ),  expf( v ), EPSILON_SNG )
	next
	for v as double = -1 to 1 step .01
		CU_ASSERT_DOUBLE_EQUAL( frac( v ), (v - hFixD( v )), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL(  fix( v ), hFixD( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL(  sin( v ),  sin_( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL( asin( v ), asin_( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL(  cos( v ),  cos_( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL( acos( v ), acos_( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL(  tan( v ),  tan_( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL(  atn( v ), atan_( v ), EPSILON_DBL )
		CU_ASSERT_DOUBLE_EQUAL(  exp( v ),  exp_( v ), EPSILON_DBL )
	next

	for v as single = 0 to 10 step .1
		CU_ASSERT_DOUBLE_EQUAL( sqr( v ), sqrtf( v ), EPSILON_SNG )
		if v > 0 then
			CU_ASSERT_DOUBLE_EQUAL( log( v ),  logf( v ), EPSILON_SNG )
		end if
	next
	for v as double = 0 to 10 step .1
		CU_ASSERT_DOUBLE_EQUAL( sqr( v ), sqrt( v ), EPSILON_DBL )
		if v > 0 then
			CU_ASSERT_DOUBLE_EQUAL( log( v ), log_( v ), EPSILON_DBL )
		end if
	next

	scope
		dim as single a, b
		a = 4.0
		b = 5.0
		CU_ASSERT_DOUBLE_EQUAL( atan2( a, b ), atan2f( a, b ), EPSILON_SNG )
	end scope
	scope
		dim as double a, b
		a = 4.0
		b = 5.0
		CU_ASSERT_DOUBLE_EQUAL( atan2( a, b ), atan2_( a, b ), EPSILON_DBL )
	end scope
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/inline-ops" )
	fbcu.add_test( "1", @test )
end sub

end namespace
