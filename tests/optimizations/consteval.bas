#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.consteval )

	TEST( uopSingle )
		dim as single f

		const EPSILON_SNG as single = 1.19290929e-7

		'' fast floating point is NOT precise, the compiler should have been
		'' built with -fpmode precise, so we may have differences when
		'' comparing const evaulation and runtime evaluation

		#if __FB_FPMODE__ = "fast"
			const EPSILON_SNG_FPU as single = EPSILON_SNG * 1000
		#else
			const EPSILON_SNG_FPU as single = EPSILON_SNG
		#endif

		#macro checkUop( func, value )
			f = value
			CU_ASSERT_DOUBLE_EQUAL( func( value ), func( f     ), EPSILON_SNG )
			CU_ASSERT_DOUBLE_EQUAL( func( f     ), func( value ), EPSILON_SNG )
		#endmacro

		#macro checkUopFPU( func, value )
			f = value
			CU_ASSERT_DOUBLE_EQUAL( func( value ), func( f     ), EPSILON_SNG_FPU )
			CU_ASSERT_DOUBLE_EQUAL( func( f     ), func( value ), EPSILON_SNG_FPU )
		#endmacro

		'' -
		f =  1.0f : CU_ASSERT_DOUBLE_EQUAL( (- 1.0f), (- f)   , EPSILON_SNG )
		f = -1.0f : CU_ASSERT_DOUBLE_EQUAL( (- 1.0f), f       , EPSILON_SNG )
		f =  1.0f : CU_ASSERT_DOUBLE_EQUAL( (- f)   , (- 1.0f), EPSILON_SNG )
		f = -1.0f : CU_ASSERT_DOUBLE_EQUAL( f       , (- 1.0f), EPSILON_SNG )
		'' abs
		CU_ASSERT_EQUAL( abs(  1.0f ), 1.0f )
		CU_ASSERT_EQUAL( abs( -1.0f ), 1.0f )
		'' sgn
		CU_ASSERT_EQUAL( sgn(  1.0f ),  1 )
		CU_ASSERT_EQUAL( sgn(  0.0f ),  0 )
		CU_ASSERT_EQUAL( sgn( -1.0f ), -1 )
		'' sin
		checkUopFPU( sin,  1.0f )
		checkUopFPU( sin,  0.5f )
		checkUopFPU( sin, -0.5f )
		checkUopFPU( sin, -1.0f )
		'' asin
		checkUop( asin,  1.0f )
		checkUop( asin,  0.5f )
		checkUop( asin, -0.5f )
		checkUop( asin, -1.0f )
		'' cos
		checkUopFPU( cos,  1.0f )
		checkUopFPU( cos,  0.5f )
		checkUopFPU( cos, -0.5f )
		checkUopFPU( cos, -1.0f )
		'' acos
		checkUop( acos,  1.0f )
		checkUop( acos,  0.5f )
		checkUop( acos, -0.5f )
		checkUop( acos, -1.0f )
		'' tan
		checkUop( tan,  1.0f )
		checkUop( tan,  0.5f )
		checkUop( tan, -0.5f )
		checkUop( tan, -1.0f )
		'' atan
		checkUop( atn,  1.0f )
		checkUop( atn,  0.5f )
		checkUop( atn, -0.5f )
		checkUop( atn, -1.0f )
		'' sqrt
		checkUop( sqr, 0.5f )
		checkUop( sqr, 1.0f )
		checkUop( sqr, 2.5f )
		checkUop( sqr, 5.0f )
		'' log
		checkUop( log, 0.5f )
		checkUop( log, 1.0f )
		checkUop( log, 2.5f )
		checkUop( log, 5.0f )
		'' exp
		checkUop( exp,  1.0f )
		checkUop( exp,  0.5f )
		checkUop( exp, -0.5f )
		checkUop( exp, -1.0f )
		'' int
		checkUop( int, -4.4f )
		checkUop( int, -2.5f )
		checkUop( int, -1.0f )
		checkUop( int, -0.5f )
		checkUop( int,  0.0f )
		checkUop( int,  0.5f )
		checkUop( int,  1.0f )
		checkUop( int,  2.5f )
		checkUop( int,  4.4f )
		'' fix
		checkUop( fix, -4.4f )
		checkUop( fix, -2.5f )
		checkUop( fix, -1.0f )
		checkUop( fix, -0.5f )
		checkUop( fix,  0.0f )
		checkUop( fix,  0.5f )
		checkUop( fix,  1.0f )
		checkUop( fix,  2.5f )
		checkUop( fix,  4.4f )
		'' frac
		checkUop( frac, -4.4f )
		checkUop( frac, -2.5f )
		checkUop( frac, -1.0f )
		checkUop( frac, -0.5f )
		checkUop( frac,  0.0f )
		checkUop( frac,  0.5f )
		checkUop( frac,  1.0f )
		checkUop( frac,  2.5f )
		checkUop( frac,  4.4f )
	END_TEST

	TEST( mathBopSingle )
		dim as single f1, f2, f3, f4

		const EPSILON_SNG as single = 1.19290929e-7

		#macro checkMathBop( bop, val1, val2 )
			f1 = val1
			f2 = val2
			f3 = ((val1) bop (val2))
			f4 = (f1 bop f2)
			CU_ASSERT_DOUBLE_EQUAL( f3, f4, EPSILON_SNG )
			CU_ASSERT_DOUBLE_EQUAL( f4, f3, EPSILON_SNG )
		#endmacro

		#macro checkMathBopAllVals2( bop, val1 )
			checkMathBop( bop, val1, -4.4f )
			checkMathBop( bop, val1, -2.5f )
			checkMathBop( bop, val1, -1.0f )
			checkMathBop( bop, val1,  0.0f )
			checkMathBop( bop, val1,  1.0f )
			checkMathBop( bop, val1,  2.5f )
			checkMathBop( bop, val1,  4.4f )
		#endmacro

		#macro checkMathBopAllVals1( bop )
			checkMathBopAllVals2( bop, -4.4f )
			checkMathBopAllVals2( bop, -2.5f )
			checkMathBopAllVals2( bop, -1.0f )
			checkMathBopAllVals2( bop,  0.0f )
			checkMathBopAllVals2( bop,  1.0f )
			checkMathBopAllVals2( bop,  2.5f )
			checkMathBopAllVals2( bop,  4.4f )
		#endmacro

		'' +, -, *, ^
		checkMathBopAllVals1( + )
		checkMathBopAllVals1( - )
		checkMathBopAllVals1( * )
		'checkMathBopAllVals1( ^ )

		#macro checkMathDivAllVals2( val1 )
			checkMathBop( /, val1, -4.4f )
			checkMathBop( /, val1, -2.5f )
			checkMathBop( /, val1, -1.0f )
			checkMathBop( /, val1,  1.0f )
			checkMathBop( /, val1,  2.5f )
			checkMathBop( /, val1,  4.4f )
		#endmacro

		'' /
		checkMathDivAllVals2( -4.4f )
		checkMathDivAllVals2( -2.5f )
		checkMathDivAllVals2( -1.0f )
		checkMathDivAllVals2(  0.0f )
		checkMathDivAllVals2(  1.0f )
		checkMathDivAllVals2(  2.5f )
		checkMathDivAllVals2(  4.4f )

		'' atan2
		f1 = 4.0f
		f2 = 5.0f
		f3 = atan2( 4.0f, 5.0f )
		f4 = atan2( f1, f2 )
		CU_ASSERT_DOUBLE_EQUAL( f3, f4, EPSILON_SNG )
		CU_ASSERT_DOUBLE_EQUAL( f4, f3, EPSILON_SNG )
	END_TEST

	TEST( logicBopSingle )
		dim as single f1, f2, f3, f4

		#macro checkLogicBop( val1, bop, val2, result )
			f1 = val1
			f2 = val2
			f3 = ((val1) bop (val2))
			f4 = (f1 bop f2)
			CU_ASSERT_EQUAL( f3, (result) )
			CU_ASSERT_EQUAL( f4, (result) )
			CU_ASSERT_EQUAL( f3, f4 )
		#endmacro

		'' <>
		'' =
		'' >
		'' <
		'' <=
		'' >=
		'' andalso
		'' orelse

		checkLogicBop( -1.0f, <>, -1.0f,  0 )
		checkLogicBop( -1.0f, <>,  0.0f, -1 )
		checkLogicBop( -1.0f, <>,  1.0f, -1 )
		checkLogicBop(  0.0f, <>, -1.0f, -1 )
		checkLogicBop(  0.0f, <>,  0.0f,  0 )
		checkLogicBop(  0.0f, <>,  1.0f, -1 )
		checkLogicBop(  1.0f, <>, -1.0f, -1 )
		checkLogicBop(  1.0f, <>,  0.0f, -1 )
		checkLogicBop(  1.0f, <>,  1.0f,  0 )

		checkLogicBop( -1.0f, =, -1.0f, -1 )
		checkLogicBop( -1.0f, =,  0.0f,  0 )
		checkLogicBop( -1.0f, =,  1.0f,  0 )
		checkLogicBop(  0.0f, =, -1.0f,  0 )
		checkLogicBop(  0.0f, =,  0.0f, -1 )
		checkLogicBop(  0.0f, =,  1.0f,  0 )
		checkLogicBop(  1.0f, =, -1.0f,  0 )
		checkLogicBop(  1.0f, =,  0.0f,  0 )
		checkLogicBop(  1.0f, =,  1.0f, -1 )

		checkLogicBop( -1.0f, >, -1.0f,  0 )
		checkLogicBop( -1.0f, >,  0.0f,  0 )
		checkLogicBop( -1.0f, >,  1.0f,  0 )
		checkLogicBop(  0.0f, >, -1.0f, -1 )
		checkLogicBop(  0.0f, >,  0.0f,  0 )
		checkLogicBop(  0.0f, >,  1.0f,  0 )
		checkLogicBop(  1.0f, >, -1.0f, -1 )
		checkLogicBop(  1.0f, >,  0.0f, -1 )
		checkLogicBop(  1.0f, >,  1.0f,  0 )

		checkLogicBop( -1.0f, <, -1.0f,  0 )
		checkLogicBop( -1.0f, <,  0.0f, -1 )
		checkLogicBop( -1.0f, <,  1.0f, -1 )
		checkLogicBop(  0.0f, <, -1.0f,  0 )
		checkLogicBop(  0.0f, <,  0.0f,  0 )
		checkLogicBop(  0.0f, <,  1.0f, -1 )
		checkLogicBop(  1.0f, <, -1.0f,  0 )
		checkLogicBop(  1.0f, <,  0.0f,  0 )
		checkLogicBop(  1.0f, <,  1.0f,  0 )

		checkLogicBop( -1.0f, <=, -1.0f, -1 )
		checkLogicBop( -1.0f, <=,  0.0f, -1 )
		checkLogicBop( -1.0f, <=,  1.0f, -1 )
		checkLogicBop(  0.0f, <=, -1.0f,  0 )
		checkLogicBop(  0.0f, <=,  0.0f, -1 )
		checkLogicBop(  0.0f, <=,  1.0f, -1 )
		checkLogicBop(  1.0f, <=, -1.0f,  0 )
		checkLogicBop(  1.0f, <=,  0.0f,  0 )
		checkLogicBop(  1.0f, <=,  1.0f, -1 )

		checkLogicBop( -1.0f, >=, -1.0f, -1 )
		checkLogicBop( -1.0f, >=,  0.0f,  0 )
		checkLogicBop( -1.0f, >=,  1.0f,  0 )
		checkLogicBop(  0.0f, >=, -1.0f, -1 )
		checkLogicBop(  0.0f, >=,  0.0f, -1 )
		checkLogicBop(  0.0f, >=,  1.0f,  0 )
		checkLogicBop(  1.0f, >=, -1.0f, -1 )
		checkLogicBop(  1.0f, >=,  0.0f, -1 )
		checkLogicBop(  1.0f, >=,  1.0f, -1 )

		checkLogicBop( -1.0f, andalso, -1.0f, -1 )
		checkLogicBop( -1.0f, andalso,  0.0f,  0 )
		checkLogicBop( -1.0f, andalso,  1.0f, -1 )
		checkLogicBop(  0.0f, andalso, -1.0f,  0 )
		checkLogicBop(  0.0f, andalso,  0.0f,  0 )
		checkLogicBop(  0.0f, andalso,  1.0f,  0 )
		checkLogicBop(  1.0f, andalso, -1.0f, -1 )
		checkLogicBop(  1.0f, andalso,  0.0f,  0 )
		checkLogicBop(  1.0f, andalso,  1.0f, -1 )

		checkLogicBop( -1.0f, orelse, -1.0f, -1 )
		checkLogicBop( -1.0f, orelse,  0.0f, -1 )
		checkLogicBop( -1.0f, orelse,  1.0f, -1 )
		checkLogicBop(  0.0f, orelse, -1.0f, -1 )
		checkLogicBop(  0.0f, orelse,  0.0f,  0 )
		checkLogicBop(  0.0f, orelse,  1.0f, -1 )
		checkLogicBop(  1.0f, orelse, -1.0f, -1 )
		checkLogicBop(  1.0f, orelse,  0.0f, -1 )
		checkLogicBop(  1.0f, orelse,  1.0f, -1 )
	END_TEST

	TEST( uopDouble )
		dim d as double

		const EPSILON_DBL as double = 2.2204460492503131e-016

		#macro checkUop( func, value )
			d = value : CU_ASSERT_DOUBLE_EQUAL( func( value ), func( d     ), EPSILON_DBL )
			d = value : CU_ASSERT_DOUBLE_EQUAL( func( d     ), func( value ), EPSILON_DBL )
		#endmacro

		'' -
		d =  1.0 : CU_ASSERT_DOUBLE_EQUAL( (- 1.0), (- d)  , EPSILON_DBL )
		d = -1.0 : CU_ASSERT_DOUBLE_EQUAL( (- 1.0), d      , EPSILON_DBL )
		d =  1.0 : CU_ASSERT_DOUBLE_EQUAL( (- d)  , (- 1.0), EPSILON_DBL )
		d = -1.0 : CU_ASSERT_DOUBLE_EQUAL( d      , (- 1.0), EPSILON_DBL )
		'' abs
		CU_ASSERT_EQUAL( abs(  1.0 ), 1.0 )
		CU_ASSERT_EQUAL( abs( -1.0 ), 1.0 )
		'' sgn
		CU_ASSERT_EQUAL( sgn(  1.0 ),  1 )
		CU_ASSERT_EQUAL( sgn(  0.0 ),  0 )
		CU_ASSERT_EQUAL( sgn( -1.0 ), -1 )
		'' sin
		checkUop( sin,  1.0 )
		checkUop( sin,  0.5 )
		checkUop( sin, -0.5 )
		checkUop( sin, -1.0 )
		'' asin
		checkUop( asin,  1.0 )
		checkUop( asin,  0.5 )
		checkUop( asin, -0.5 )
		checkUop( asin, -1.0 )
		'' cos
		checkUop( cos,  1.0 )
		checkUop( cos,  0.5 )
		checkUop( cos, -0.5 )
		checkUop( cos, -1.0 )
		'' acos
		checkUop( acos,  1.0 )
		checkUop( acos,  0.5 )
		checkUop( acos, -0.5 )
		checkUop( acos, -1.0 )
		'' tan
		checkUop( tan,  1.0 )
		checkUop( tan,  0.5 )
		checkUop( tan, -0.5 )
		checkUop( tan, -1.0 )
		'' atan
		checkUop( atn,  1.0 )
		checkUop( atn,  0.5 )
		checkUop( atn, -0.5 )
		checkUop( atn, -1.0 )
		'' sqrt
		checkUop( sqr, 0.5 )
		checkUop( sqr, 1.0 )
		checkUop( sqr, 2.5 )
		checkUop( sqr, 5.0 )
		'' log
		checkUop( log, 0.5 )
		checkUop( log, 1.0 )
		checkUop( log, 2.5 )
		checkUop( log, 5.0 )
		'' exp
		checkUop( exp,  1.0 )
		checkUop( exp,  0.5 )
		checkUop( exp, -0.5 )
		checkUop( exp, -1.0 )
		'' int
		checkUop( int, -4.4 )
		checkUop( int, -2.5 )
		checkUop( int, -1.0 )
		checkUop( int, -0.5 )
		checkUop( int,  0.0 )
		checkUop( int,  0.5 )
		checkUop( int,  1.0 )
		checkUop( int,  2.5 )
		checkUop( int,  4.4 )
		'' fix
		checkUop( fix, -4.4 )
		checkUop( fix, -2.5 )
		checkUop( fix, -1.0 )
		checkUop( fix, -0.5 )
		checkUop( fix,  0.0 )
		checkUop( fix,  0.5 )
		checkUop( fix,  1.0 )
		checkUop( fix,  2.5 )
		checkUop( fix,  4.4 )
		'' frac
		checkUop( frac, -4.4 )
		checkUop( frac, -2.5 )
		checkUop( frac, -1.0 )
		checkUop( frac, -0.5 )
		checkUop( frac,  0.0 )
		checkUop( frac,  0.5 )
		checkUop( frac,  1.0 )
		checkUop( frac,  2.5 )
		checkUop( frac,  4.4 )
	END_TEST

	TEST( mathBopDouble )
		dim as double d1, d2, d3, d4

		const EPSILON_DBL as double = 2.2204460492503131e-016

		#macro checkMathBop( bop, val1, val2 )
		#if( (val1 < 0) and (#bop = "^") and (frac(val2) <> .0) )
			'' returns nan
		#elseif( (val1 = 0) and (#bop = "^") and (val2 < 0) )
			'' returns inf
			d1 = val1
			d2 = val2
			d3 = ((val1) bop (val2))
			d4 = (d1 bop d2)
			CU_ASSERT_EQUAL( d3, d4 )
		#else
			d1 = val1
			d2 = val2
			d3 = ((val1) bop (val2))
			d4 = (d1 bop d2)
			CU_ASSERT_DOUBLE_EQUAL( d3, d4, EPSILON_DBL )
		#endif
		#endmacro

		#macro checkMathBopAllVals2( bop, val1 )
			checkMathBop( bop, val1, -4.4 )
			checkMathBop( bop, val1, -2.5 )
			checkMathBop( bop, val1, -1.0 )
			checkMathBop( bop, val1,  0.0 )
			checkMathBop( bop, val1,  1.0 )
			checkMathBop( bop, val1,  2.5 )
			checkMathBop( bop, val1,  4.4 )
		#endmacro

		#macro checkMathBopAllVals1( bop )
			checkMathBopAllVals2( bop, -4.4 )
			checkMathBopAllVals2( bop, -2.5 )
			checkMathBopAllVals2( bop, -1.0 )
			checkMathBopAllVals2( bop,  0.0 )
			checkMathBopAllVals2( bop,  1.0 )
			checkMathBopAllVals2( bop,  2.5 )
			checkMathBopAllVals2( bop,  4.4 )
		#endmacro

		'' +, -, *, ^
		checkMathBopAllVals1( + )
		checkMathBopAllVals1( - )
		checkMathBopAllVals1( * )
		checkMathBopAllVals1( ^ )

		#macro checkMathDivAllVals2( val1 )
			checkMathBop( /, val1, -4.4 )
			checkMathBop( /, val1, -2.5 )
			checkMathBop( /, val1, -1.0 )
			checkMathBop( /, val1,  1.0 )
			checkMathBop( /, val1,  2.5 )
			checkMathBop( /, val1,  4.4 )
		#endmacro

		'' /
		checkMathDivAllVals2( -4.4 )
		checkMathDivAllVals2( -2.5 )
		checkMathDivAllVals2( -1.0 )
		checkMathDivAllVals2(  0.0 )
		checkMathDivAllVals2(  1.0 )
		checkMathDivAllVals2(  2.5 )
		checkMathDivAllVals2(  4.4 )

		'' atan2
		d1 = 4.0
		d2 = 5.0
		d3 = atan2( 4.0, 5.0 )
		d4 = atan2( d1, d2 )
		CU_ASSERT_DOUBLE_EQUAL( d3, d4, EPSILON_DBL )
	END_TEST

	TEST( logicBopDouble )
		dim as double d1, d2, d3, d4

		#macro checkLogicBop( val1, bop, val2, result )
			d1 = val1
			d2 = val2
			d3 = ((val1) bop (val2))
			d4 = (d1 bop d2)
			CU_ASSERT_EQUAL( d3, (result) )
			CU_ASSERT_EQUAL( d4, (result) )
			CU_ASSERT_EQUAL( d3, d4 )
		#endmacro

		'' <>
		'' =
		'' >
		'' <
		'' <=
		'' >=
		'' andalso
		'' orelse

		checkLogicBop( -1.0, <>, -1.0,  0 )
		checkLogicBop( -1.0, <>,  0.0, -1 )
		checkLogicBop( -1.0, <>,  1.0, -1 )
		checkLogicBop(  0.0, <>, -1.0, -1 )
		checkLogicBop(  0.0, <>,  0.0,  0 )
		checkLogicBop(  0.0, <>,  1.0, -1 )
		checkLogicBop(  1.0, <>, -1.0, -1 )
		checkLogicBop(  1.0, <>,  0.0, -1 )
		checkLogicBop(  1.0, <>,  1.0,  0 )

		checkLogicBop( -1.0, =, -1.0, -1 )
		checkLogicBop( -1.0, =,  0.0,  0 )
		checkLogicBop( -1.0, =,  1.0,  0 )
		checkLogicBop(  0.0, =, -1.0,  0 )
		checkLogicBop(  0.0, =,  0.0, -1 )
		checkLogicBop(  0.0, =,  1.0,  0 )
		checkLogicBop(  1.0, =, -1.0,  0 )
		checkLogicBop(  1.0, =,  0.0,  0 )
		checkLogicBop(  1.0, =,  1.0, -1 )

		checkLogicBop( -1.0, >, -1.0,  0 )
		checkLogicBop( -1.0, >,  0.0,  0 )
		checkLogicBop( -1.0, >,  1.0,  0 )
		checkLogicBop(  0.0, >, -1.0, -1 )
		checkLogicBop(  0.0, >,  0.0,  0 )
		checkLogicBop(  0.0, >,  1.0,  0 )
		checkLogicBop(  1.0, >, -1.0, -1 )
		checkLogicBop(  1.0, >,  0.0, -1 )
		checkLogicBop(  1.0, >,  1.0,  0 )

		checkLogicBop( -1.0, <, -1.0,  0 )
		checkLogicBop( -1.0, <,  0.0, -1 )
		checkLogicBop( -1.0, <,  1.0, -1 )
		checkLogicBop(  0.0, <, -1.0,  0 )
		checkLogicBop(  0.0, <,  0.0,  0 )
		checkLogicBop(  0.0, <,  1.0, -1 )
		checkLogicBop(  1.0, <, -1.0,  0 )
		checkLogicBop(  1.0, <,  0.0,  0 )
		checkLogicBop(  1.0, <,  1.0,  0 )

		checkLogicBop( -1.0, <=, -1.0, -1 )
		checkLogicBop( -1.0, <=,  0.0, -1 )
		checkLogicBop( -1.0, <=,  1.0, -1 )
		checkLogicBop(  0.0, <=, -1.0,  0 )
		checkLogicBop(  0.0, <=,  0.0, -1 )
		checkLogicBop(  0.0, <=,  1.0, -1 )
		checkLogicBop(  1.0, <=, -1.0,  0 )
		checkLogicBop(  1.0, <=,  0.0,  0 )
		checkLogicBop(  1.0, <=,  1.0, -1 )

		checkLogicBop( -1.0, >=, -1.0, -1 )
		checkLogicBop( -1.0, >=,  0.0,  0 )
		checkLogicBop( -1.0, >=,  1.0,  0 )
		checkLogicBop(  0.0, >=, -1.0, -1 )
		checkLogicBop(  0.0, >=,  0.0, -1 )
		checkLogicBop(  0.0, >=,  1.0,  0 )
		checkLogicBop(  1.0, >=, -1.0, -1 )
		checkLogicBop(  1.0, >=,  0.0, -1 )
		checkLogicBop(  1.0, >=,  1.0, -1 )

		checkLogicBop( -1.0, andalso, -1.0, -1 )
		checkLogicBop( -1.0, andalso,  0.0,  0 )
		checkLogicBop( -1.0, andalso,  1.0, -1 )
		checkLogicBop(  0.0, andalso, -1.0,  0 )
		checkLogicBop(  0.0, andalso,  0.0,  0 )
		checkLogicBop(  0.0, andalso,  1.0,  0 )
		checkLogicBop(  1.0, andalso, -1.0, -1 )
		checkLogicBop(  1.0, andalso,  0.0,  0 )
		checkLogicBop(  1.0, andalso,  1.0, -1 )

		checkLogicBop( -1.0, orelse, -1.0, -1 )
		checkLogicBop( -1.0, orelse,  0.0, -1 )
		checkLogicBop( -1.0, orelse,  1.0, -1 )
		checkLogicBop(  0.0, orelse, -1.0, -1 )
		checkLogicBop(  0.0, orelse,  0.0,  0 )
		checkLogicBop(  0.0, orelse,  1.0, -1 )
		checkLogicBop(  1.0, orelse, -1.0, -1 )
		checkLogicBop(  1.0, orelse,  0.0, -1 )
		checkLogicBop(  1.0, orelse,  1.0, -1 )
	END_TEST

	TEST( uopInt )
		dim l as long
		dim ul as ulong
		dim ll as longint
		dim ull as ulongint

		#macro checkUop( uop, var, val )
			var = val : CU_ASSERT_EQUAL( (uop(val)), (uop(var)) )
		#endmacro

		#macro checkUopAllVals( uop )
			checkUop( uop, l, &h80000000l )
			checkUop( uop, l, &hFFFFFFFFl )
			checkUop( uop, l, -1l )
			checkUop( uop, l, 0l )
			checkUop( uop, l, 1l )
			checkUop( uop, l, &h7FFFFFFFl )

			checkUop( uop, ul, &h80000000ul )
			checkUop( uop, ul, &hFFFFFFFFul )
			checkUop( uop, ul, 0ul )
			checkUop( uop, ul, 1ul )
			checkUop( uop, ul, &h7FFFFFFFul )

			checkUop( uop, ll, &h8000000000000000ll )
			checkUop( uop, ll, &hFFFFFFFFFFFFFFFFll )
			checkUop( uop, ll, &h80000000ll )
			checkUop( uop, ll, &hFFFFFFFFll )
			checkUop( uop, ll, -1ll )
			checkUop( uop, ll, 0ll )
			checkUop( uop, ll, 1ll )
			checkUop( uop, ll, &h7FFFFFFFll )
			checkUop( uop, ll, &h7FFFFFFFFFFFFFFFll )

			checkUop( uop, ull, &h8000000000000000ull )
			checkUop( uop, ull, &hFFFFFFFFFFFFFFFFull )
			checkUop( uop, ull, &h80000000ull )
			checkUop( uop, ull, &hFFFFFFFFull )
			checkUop( uop, ull, 0ull )
			checkUop( uop, ull, 1ull )
			checkUop( uop, ull, &h7FFFFFFFull )
			checkUop( uop, ull, &h7FFFFFFFFFFFFFFFull )
		#endmacro

		'' not, -, abs, sgn
		checkUopAllVals( not )
		checkUopAllVals( - )
		checkUopAllVals( abs )
		checkUopAllVals( sgn )

	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( (not &h80000000l ), &h000000007FFFFFFF  )  '' sign-extended to &hFFFFFFFF80000000 before the NOT
		CU_ASSERT_EQUAL( (not &hFFFFFFFFl ),                  0  )  '' sign-extended to -1 before the NOT
		CU_ASSERT_EQUAL( (not         -1l ),                  0  )
		CU_ASSERT_EQUAL( (not          0l ),                 -1  )
		CU_ASSERT_EQUAL( (not          1l ), &hFFFFFFFFFFFFFFFE  )
		CU_ASSERT_EQUAL( (not &h7FFFFFFFl ), &hFFFFFFFF80000000  )
		CU_ASSERT_EQUAL( (not &h80000000ul), &hFFFFFFFF7FFFFFFFu )
		CU_ASSERT_EQUAL( (not &hFFFFFFFFul), &hFFFFFFFF00000000u )
		CU_ASSERT_EQUAL( (not          0ul), &hFFFFFFFFFFFFFFFFu )
		CU_ASSERT_EQUAL( (not          1ul), &hFFFFFFFFFFFFFFFEu )
		CU_ASSERT_EQUAL( (not &h7FFFFFFFul), &hFFFFFFFF80000000u )
	#else
		CU_ASSERT_EQUAL( (not &h80000000l ), &h7FFFFFFF  )
		CU_ASSERT_EQUAL( (not &hFFFFFFFFl ),          0  )
		CU_ASSERT_EQUAL( (not         -1l ),          0  )
		CU_ASSERT_EQUAL( (not          0l ),         -1  )
		CU_ASSERT_EQUAL( (not          1l ), &hFFFFFFFE  )
		CU_ASSERT_EQUAL( (not &h7FFFFFFFl ), &h80000000  )
		CU_ASSERT_EQUAL( (not &h80000000ul), &h7FFFFFFFu )
		CU_ASSERT_EQUAL( (not &hFFFFFFFFul),          0  )
		CU_ASSERT_EQUAL( (not          0ul), &hFFFFFFFFu )
		CU_ASSERT_EQUAL( (not          1ul), &hFFFFFFFEu )
		CU_ASSERT_EQUAL( (not &h7FFFFFFFul), &h80000000u )
	#endif
		CU_ASSERT_EQUAL( (not &h8000000000000000ll ), &h7FFFFFFFFFFFFFFFll  )
		CU_ASSERT_EQUAL( (not &hFFFFFFFFFFFFFFFFll ),                  0ll  )
		CU_ASSERT_EQUAL( (not         &h80000000ll ), &hFFFFFFFF7FFFFFFFll  )
		CU_ASSERT_EQUAL( (not         &hFFFFFFFFll ), &hFFFFFFFF00000000ll  )
		CU_ASSERT_EQUAL( (not                 -1ll ),                  0ll  )
		CU_ASSERT_EQUAL( (not                  0ll ),                 -1ll  )
		CU_ASSERT_EQUAL( (not                  1ll ), &hFFFFFFFFFFFFFFFEll  )
		CU_ASSERT_EQUAL( (not         &h7FFFFFFFll ), &hFFFFFFFF80000000ll  )
		CU_ASSERT_EQUAL( (not &h7FFFFFFFFFFFFFFFll ), &h8000000000000000ll  )
		CU_ASSERT_EQUAL( (not &h8000000000000000ull), &h7FFFFFFFFFFFFFFFull )
		CU_ASSERT_EQUAL( (not &hFFFFFFFFFFFFFFFFull),                  0    )
		CU_ASSERT_EQUAL( (not         &h80000000ull), &hFFFFFFFF7FFFFFFFull )
		CU_ASSERT_EQUAL( (not         &hFFFFFFFFull), &hFFFFFFFF00000000ull )
		CU_ASSERT_EQUAL( (not                  0ull), &hFFFFFFFFFFFFFFFFull )
		CU_ASSERT_EQUAL( (not                  1ull), &hFFFFFFFFFFFFFFFEull )
		CU_ASSERT_EQUAL( (not         &h7FFFFFFFull), &hFFFFFFFF80000000ull )
		CU_ASSERT_EQUAL( (not &h7FFFFFFFFFFFFFFFull), &h8000000000000000ull )

		CU_ASSERT_EQUAL( (-1l), -1 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( (-&h7FFFFFFF), &hFFFFFFFF80000001 )
	#else
		CU_ASSERT_EQUAL( (-&h7FFFFFFF), &h80000001 )
	#endif
		CU_ASSERT_EQUAL( (-&h7FFFFFFFll), &hFFFFFFFF80000001ll )

	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( abs( &h80000000l  ), &h80000000  ) '' sign-extended to &hFFFFFFFF80000000, abs() of that is &h80000000
		CU_ASSERT_EQUAL( abs( &h80000000   ), &h80000000  )
		CU_ASSERT_EQUAL( abs( &hFFFFFFFF   ), &hFFFFFFFF  )
	#else
		CU_ASSERT_EQUAL( abs( &h80000000l  ), &h80000000l ) '' abs(-2147483648) = 2147483648, too big for 32bit, so result is -2147483648 (unchanged), same as gcc
		CU_ASSERT_EQUAL( abs( &h80000000   ), &h80000000  ) '' ditto
		CU_ASSERT_EQUAL( abs( &hFFFFFFFF   ),          1  ) '' abs(-1) = 1
	#endif
		CU_ASSERT_EQUAL( abs( &hFFFFFFFFl  ),          1  )  '' 32bit: it is -1 already, 64bit: sign-extended to -1
		CU_ASSERT_EQUAL( abs(         -1l  ),          1  )
		CU_ASSERT_EQUAL( abs(          0l  ),          0  )
		CU_ASSERT_EQUAL( abs(          1l  ),          1  )
		CU_ASSERT_EQUAL( abs( &h7FFFFFFFl  ), &h7FFFFFFF  )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( abs( &hFFFFFFFFul ), &hFFFFFFFFu ) '' promoted to 64bit (UOP operand), but not sign-extended
	#else
		CU_ASSERT_EQUAL( abs( &hFFFFFFFFul ),          1  ) '' abs(-1) = 1
	#endif
		CU_ASSERT_EQUAL( abs( &h7FFFFFFFul ), &h7FFFFFFF  )

		CU_ASSERT_EQUAL( abs( &h8000000000000000ll  ), &h8000000000000000ll )  '' same: abs(-9223372036854775808) is too big for 64bit, so result = operand, same as gcc
		CU_ASSERT_EQUAL( abs( &h8000000000000000ull ), &h8000000000000000ll )  '' ditto
		CU_ASSERT_EQUAL( abs( &hFFFFFFFFFFFFFFFFll  ),                  1ll )
		CU_ASSERT_EQUAL( abs( &hFFFFFFFFFFFFFFFFull ),                  1ll )  '' there's no unsigned abs()
		CU_ASSERT_EQUAL( abs(         &h80000000ll  ),         &h80000000ll )
		CU_ASSERT_EQUAL( abs(         &h80000000ull ),         &h80000000ll )
		CU_ASSERT_EQUAL( abs(         &hFFFFFFFFll  ),         &hFFFFFFFFll )
		CU_ASSERT_EQUAL( abs(         &hFFFFFFFFull ),         &hFFFFFFFFll )
		CU_ASSERT_EQUAL( abs(                 -1ll  ),                  1ll )
		CU_ASSERT_EQUAL( abs(                  0ll  ),                  0ll )
		CU_ASSERT_EQUAL( abs(                  0ull ),                  0ll )
		CU_ASSERT_EQUAL( abs(                  1ll  ),                  1ll )
		CU_ASSERT_EQUAL( abs(                  1ull ),                  1ll )
		CU_ASSERT_EQUAL( abs(         &h7FFFFFFFll  ),         &h7FFFFFFFll )
		CU_ASSERT_EQUAL( abs(         &h7FFFFFFFull ),         &h7FFFFFFFll )
		CU_ASSERT_EQUAL( abs( &h7FFFFFFFFFFFFFFFll  ), &h7FFFFFFFFFFFFFFFll )
		CU_ASSERT_EQUAL( abs( &h7FFFFFFFFFFFFFFFull ), &h7FFFFFFFFFFFFFFFll )

		CU_ASSERT_EQUAL( sgn( &h80000000l  ), -1 )  '' negative even on 64bit (sign extension)
		CU_ASSERT_EQUAL( sgn( &hFFFFFFFFl  ), -1 )  '' ditto
		CU_ASSERT_EQUAL( sgn(         -1l  ), -1 )
		CU_ASSERT_EQUAL( sgn(          0l  ),  0 )
		CU_ASSERT_EQUAL( sgn(          1l  ),  1 )
		CU_ASSERT_EQUAL( sgn( &h7FFFFFFFl  ),  1 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( sgn( &h80000000ul ),  1 )  '' promoted to 64bit, but not sign-extended
		CU_ASSERT_EQUAL( sgn( &hFFFFFFFFul ),  1 )  '' ditto
	#else
		CU_ASSERT_EQUAL( sgn( &h80000000ul ), -1 )
		CU_ASSERT_EQUAL( sgn( &hFFFFFFFFul ), -1 )
	#endif
		CU_ASSERT_EQUAL( sgn(          0ul ),  0 )
		CU_ASSERT_EQUAL( sgn(          1ul ),  1 )
		CU_ASSERT_EQUAL( sgn( &h7FFFFFFFul ),  1 )

		CU_ASSERT_EQUAL( sgn( &h8000000000000000ll  ), -1 )
		CU_ASSERT_EQUAL( sgn( &hFFFFFFFFFFFFFFFFll  ), -1 )
		CU_ASSERT_EQUAL( sgn(         &h80000000ll  ),  1 )
		CU_ASSERT_EQUAL( sgn(         &hFFFFFFFFll  ),  1 )
		CU_ASSERT_EQUAL( sgn(                 -1ll  ), -1 )
		CU_ASSERT_EQUAL( sgn(                  0ll  ),  0 )
		CU_ASSERT_EQUAL( sgn(                  1ll  ),  1 )
		CU_ASSERT_EQUAL( sgn(         &h7FFFFFFFll  ),  1 )
		CU_ASSERT_EQUAL( sgn( &h7FFFFFFFFFFFFFFFll  ),  1 )
		CU_ASSERT_EQUAL( sgn( &h8000000000000000ull ), -1 )
		CU_ASSERT_EQUAL( sgn( &hFFFFFFFFFFFFFFFFull ), -1 )
		CU_ASSERT_EQUAL( sgn(         &h80000000ull ),  1 )
		CU_ASSERT_EQUAL( sgn(         &hFFFFFFFFull ),  1 )
		CU_ASSERT_EQUAL( sgn(                  0ull ),  0 )
		CU_ASSERT_EQUAL( sgn(                  1ull ),  1 )
		CU_ASSERT_EQUAL( sgn(         &h7FFFFFFFull ),  1 )
		CU_ASSERT_EQUAL( sgn( &h7FFFFFFFFFFFFFFFull ),  1 )
	END_TEST

	TEST( bopS32 )
		dim as long l1, l2

		#macro l_check2( bop, val1, val2 )
			l1 = val1
			l2 = val2
			CU_ASSERT_EQUAL( ((val1) bop (val2)), (l1 bop l2) )
		#endmacro

		#macro l_check1( bop, val1 )
			l_check2( bop, val1, &h80000000l )
			'' &h80000000 \ -1 cannot be represented in 32bit, and triggers SIGFPE
			'' during the runtime calculation on x86. fbc's compile-time calculation
			'' should work though and is tested separately below.
			#if ((#bop <> "\") and (#bop <> "mod")) or (#val1 <> "&h80000000l")
			l_check2( bop, val1, &hFFFFFFFFl )
			#endif
			#if ((#bop <> "\") and (#bop <> "mod"))
			l_check2( bop, val1, 0l )
			#endif
			l_check2( bop, val1, 1l )
			l_check2( bop, val1, &h7FFFFFFFl )
		#endmacro

		#macro l_check( bop )
			l_check1( bop, &h80000000l )
			l_check1( bop, &hFFFFFFFFl )
			l_check1( bop, 0l )
			l_check1( bop, 1l )
			l_check1( bop, &h7FFFFFFFl )
		#endmacro

		l_check( + )
		l_check( - )
		l_check( * )
		l_check( \ )
		l_check( mod )
		l_check( and )
		l_check( or )
		l_check( xor )
		l_check( eqv )
		l_check( imp )
		l_check( <> )
		l_check( =  )
		l_check( >  )
		l_check( <  )
		l_check( <= )
		l_check( >= )
		l_check( andalso )
		l_check( orelse  )
		l_check2( +,  4,   5 )
		l_check2( +, -3,  17 )
		l_check2( -,  6,   3 )
		l_check2( -, 20, -41 )
		l_check2( *,  2,   3 )
		l_check2( *, -7,  12 )
		l_check2( \, 10, 5 )
		l_check2( \, 10, 3 )
		l_check2( \,  2, 3 )
		l_check2( \,  1, 3 )

		#ifdef __FB_64BIT__
			CU_ASSERT_EQUAL( (-2147483648u \   -1), 2147483648u )
		#else
			CU_ASSERT_EQUAL( (-2147483648u \   -1), 0 )  '' = 2147483648, overflows to 0 on 32bit
		#endif
		CU_ASSERT_EQUAL( (-2147483648u mod -1), 0 )  '' remainder = 0

		#macro l_shift1( bop, val1 )
			l_check2( bop, val1, 0 )
			l_check2( bop, val1, 1 )
			l_check2( bop, val1, 16 )
			l_check2( bop, val1, 31 )
			l_check2( bop, val1, 32 )
		#endmacro

		#macro l_shift( bop )
			l_shift1( bop, &h80000000l )
			l_shift1( bop, &hFFFFFFFFl )
			l_shift1( bop, 0l )
			l_shift1( bop, 1l )
			l_shift1( bop, &h7FFFFFFFl )
		#endmacro

		l_shift( shl )
		l_shift( shr )
	END_TEST

	TEST( bopU32 )
		dim as ulong ul1, ul2

		#macro ul_check2( bop, val1, val2 )
			ul1 = val1
			ul2 = val2
			CU_ASSERT_EQUAL( ((val1) bop (val2)), (ul1 bop ul2) )
		#endmacro

		#macro ul_check1( bop, val1 )
			ul_check2( bop, val1, &h80000000ul )
			ul_check2( bop, val1, &hFFFFFFFFul )
			#if ((#bop <> "\") and (#bop <> "mod"))
			ul_check2( bop, val1, 0ul )
			#endif
			ul_check2( bop, val1, 1ul )
			ul_check2( bop, val1, &h7FFFFFFFul )
		#endmacro

		#macro ul_check( bop )
			ul_check1( bop, &h80000000ul )
			ul_check1( bop, &hFFFFFFFFul )
			ul_check1( bop, 0ul )
			ul_check1( bop, 1ul )
			ul_check1( bop, &h7FFFFFFFul )
		#endmacro

		ul_check( + )
		ul_check( - )
		ul_check( * )
		ul_check( \ )
		ul_check( mod )
		ul_check( and )
		ul_check( or )
		ul_check( xor )
		ul_check( eqv )
		ul_check( imp )
		ul_check( <> )
		ul_check( =  )
		ul_check( >  )
		ul_check( <  )
		ul_check( <= )
		ul_check( >= )
		ul_check( andalso )
		ul_check( orelse  )
		ul_check2( +,  4, 5 )
		ul_check2( -,  6, 3 )
		ul_check2( *,  2, 3 )
		ul_check2( \, 10, 5 )
		ul_check2( \, 10, 3 )
		ul_check2( \,  2, 3 )
		ul_check2( \,  1, 3 )

		#macro ul_shift1( bop, val1 )
			ul_check2( bop, val1, 0 )
			ul_check2( bop, val1, 1 )
			ul_check2( bop, val1, 16 )
			ul_check2( bop, val1, 31 )
			ul_check2( bop, val1, 32 )
		#endmacro

		#macro ul_shift( bop )
			ul_shift1( bop, &h80000000ul )
			ul_shift1( bop, &hFFFFFFFFul )
			ul_shift1( bop, 0ul )
			ul_shift1( bop, 1ul )
			ul_shift1( bop, &h7FFFFFFFul )
		#endmacro

		ul_shift( shl )
		ul_shift( shr )
	END_TEST

	TEST( bopS64 )
		dim as longint ll1, ll2

		#macro ll_check2( bop, val1, val2 )
			ll1 = val1
			ll2 = val2
			CU_ASSERT_EQUAL( ((val1) bop (val2)), (ll1 bop ll2) )
		#endmacro

		#macro ll_check1( bop, val1 )
			ll_check2( bop, val1, &h8000000000000000ll )
			'' &h8000000000000000 \ -1 cannot be represented in 64bit, and triggers SIGFPE
			'' during the runtime calculation on x86_64. fbc's compile-time calculation
			'' should work though and is tested separately below.
			#if ((#bop <> "\") and (#bop <> "mod")) or (#val1 <> "&h8000000000000000ll")
			ll_check2( bop, val1, &hFFFFFFFFFFFFFFFFll )
			#endif
			ll_check2( bop, val1,         &h80000000ll )
			ll_check2( bop, val1,         &hFFFFFFFFll )
			#if ((#bop <> "\") and (#bop <> "mod"))
			ll_check2( bop, val1,                  0ll )
			#endif
			ll_check2( bop, val1,                  1ll )
			ll_check2( bop, val1,         &h7FFFFFFFll )
			ll_check2( bop, val1, &h7FFFFFFFFFFFFFFFll )
		#endmacro

		#macro ll_check( bop )
			ll_check1( bop, &h8000000000000000ll )
			ll_check1( bop, &hFFFFFFFFFFFFFFFFll )
			ll_check1( bop,         &h80000000ll )
			ll_check1( bop,         &hFFFFFFFFll )
			ll_check1( bop,                  0ll )
			ll_check1( bop,                  1ll )
			ll_check1( bop,         &h7FFFFFFFll )
			ll_check1( bop, &h7FFFFFFFFFFFFFFFll )
		#endmacro

		ll_check( + )
		ll_check( - )
		ll_check( * )
		ll_check( \ )
		ll_check( mod )
		ll_check( and )
		ll_check( or )
		ll_check( xor )
		ll_check( eqv )
		ll_check( imp )
		ll_check( <> )
		ll_check( =  )
		ll_check( >  )
		ll_check( <  )
		ll_check( <= )
		ll_check( >= )
		ll_check( andalso )
		ll_check( orelse  )

		CU_ASSERT_EQUAL( (-9223372036854775808ull \   -1ull), 0 )  '' = 9223372036854775808, overflows to 0
		CU_ASSERT_EQUAL( (-9223372036854775808ull mod -1ull), 0 )  '' remainder = 0

		#macro ll_shift1( bop, val1 )
			ll_check2( bop, val1, 0 )
			ll_check2( bop, val1, 1 )
			ll_check2( bop, val1, 16 )
			ll_check2( bop, val1, 31 )
			ll_check2( bop, val1, 32 )
		#endmacro

		#macro ll_shift( bop )
			ll_shift1( bop, &h8000000000000000ll )
			ll_shift1( bop, &hFFFFFFFFFFFFFFFFll )
			ll_shift1( bop,         &h80000000ll )
			ll_shift1( bop,         &hFFFFFFFFll )
			ll_shift1( bop,                  0ll )
			ll_shift1( bop,                  1ll )
			ll_shift1( bop,         &h7FFFFFFFll )
			ll_shift1( bop, &h7FFFFFFFFFFFFFFFll )
		#endmacro

		ll_shift( shl )
		ll_shift( shr )
	END_TEST

	TEST( bopU64 )
		dim as ulongint ull1, ull2

		#macro ull_check2( bop, val1, val2 )
			ull1 = val1
			ull2 = val2
			CU_ASSERT_EQUAL( ((val1) bop (val2)), (ull1 bop ull2) )
		#endmacro

		#macro ull_check1( bop, val1 )
			ull_check2( bop, val1, &h8000000000000000ull )
			ull_check2( bop, val1, &hFFFFFFFFFFFFFFFFull )
			ull_check2( bop, val1,         &h80000000ull )
			ull_check2( bop, val1,         &hFFFFFFFFull )
			#if ((#bop <> "\") and (#bop <> "mod"))
			ull_check2( bop, val1,                  0ull )
			#endif
			ull_check2( bop, val1,                  1ull )
			ull_check2( bop, val1,         &h7FFFFFFFull )
			ull_check2( bop, val1, &h7FFFFFFFFFFFFFFFull )
		#endmacro

		#macro ull_check( bop )
			ull_check1( bop, &h8000000000000000ull )
			ull_check1( bop, &hFFFFFFFFFFFFFFFFull )
			ull_check1( bop,         &h80000000ull )
			ull_check1( bop,         &hFFFFFFFFull )
			ull_check1( bop,                  0ull )
			ull_check1( bop,                  1ull )
			ull_check1( bop,         &h7FFFFFFFull )
			ull_check1( bop, &h7FFFFFFFFFFFFFFFull )
		#endmacro

		ull_check( + )
		ull_check( - )
		ull_check( * )
		ull_check( \ )
		ull_check( mod )
		ull_check( and )
		ull_check( or )
		ull_check( xor )
		ull_check( eqv )
		ull_check( imp )
		ull_check( <> )
		ull_check( =  )
		ull_check( >  )
		ull_check( <  )
		ull_check( <= )
		ull_check( >= )
		ull_check( andalso )
		ull_check( orelse  )

		#macro ull_shift1( bop, val1 )
			ull_check2( bop, val1, 0 )
			ull_check2( bop, val1, 1 )
			ull_check2( bop, val1, 16 )
			ull_check2( bop, val1, 31 )
			ull_check2( bop, val1, 32 )
		#endmacro

		#macro ull_shift( bop )
			ull_shift1( bop, &h8000000000000000ull )
			ull_shift1( bop, &hFFFFFFFFFFFFFFFFull )
			ull_shift1( bop,         &h80000000ull )
			ull_shift1( bop,         &hFFFFFFFFull )
			ull_shift1( bop,                  0ull )
			ull_shift1( bop,                  1ull )
			ull_shift1( bop,         &h7FFFFFFFull )
			ull_shift1( bop, &h7FFFFFFFFFFFFFFFull )
		#endmacro

		ull_shift( shl )
		ull_shift( shr )
	END_TEST

END_SUITE
