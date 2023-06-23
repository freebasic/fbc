#include once "fbcunit.bi"


#ifndef ENABLE_CHECK_BUGS
#define ENABLE_CHECK_BUGS 0
#endif



#if defined( __FB_X86__ ) orelse (ENABLE_CHECK_BUGS <> 0)
	#define CHECK_INF 1
	#define CHECK_IND 1
#endif

#ifndef CHECK_INF
#define CHECK_INF 0
#endif

#ifndef CHECK_IND
#define CHECK_IND 0
#endif

#macro chkIfStmt( expr, istrue )
	scope
		'' if (expr) then ...
		if( expr ) then
			CU_ASSERT( istrue = TRUE )
		else
			CU_ASSERT( istrue = FALSE )
		end if

		'' result = (expr)
		dim integer_result as integer
		integer_result = expr
		CU_ASSERT( cint(integer_result) = cint(istrue) )

		'' result = iif( expr, ... )
		dim iif_result as integer
		iif_result = iif( expr, TRUE, FALSE )
		CU_ASSERT( cint(iif_result) = cint(istrue) )

		'' result = cbool( expr )
		dim boolean_result as boolean
		boolean_result = cbool( expr )
		CU_ASSERT( cbool(boolean_result) = cbool(istrue) )
	end scope
#endmacro

SUITE( fbc_tests.expressions.compare_float_nan )

	'' a = b
	TEST( var_zero_zero )
		dim as single a = 0
		dim as single b = 0

		chkIfStmt( a =  b, TRUE )
		chkIfStmt( a <> b, FALSE )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, TRUE  )
		chkIfStmt( (a <> b) <> 0, FALSE )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), FALSE )
		chkIfStmt( not (a <> b), TRUE  )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, FALSE )
		chkIfStmt( (a <> b) =  0, TRUE  )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a < b
	TEST( var_zero_one )
		dim as single a = 0
		dim as single b = 1

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, TRUE  )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, TRUE  )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), FALSE )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, FALSE )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a > b
	TEST( var_one_zero )
		dim as single a = 1
		dim as single b = 0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, TRUE  )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE  )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, TRUE  )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), FALSE )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, FALSE )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST

	'' a = b
	TEST( var_one_one )
		dim as single a = 1
		dim as single b = 1

		chkIfStmt( a =  b, TRUE )
		chkIfStmt( a <> b, FALSE )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, TRUE  )
		chkIfStmt( (a <> b) <> 0, FALSE )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), FALSE )
		chkIfStmt( not (a <> b), TRUE  )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, FALSE )
		chkIfStmt( (a <> b) =  0, TRUE  )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

#if CHECK_INF <> 0

	'' a = b
	TEST( var_posinf_posinf )
		dim as single a = 1/0
		dim as single b = 1/0

		chkIfStmt( a =  b, TRUE )
		chkIfStmt( a <> b, FALSE )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, TRUE  )
		chkIfStmt( (a <> b) <> 0, FALSE )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), FALSE )
		chkIfStmt( not (a <> b), TRUE  )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, FALSE )
		chkIfStmt( (a <> b) =  0, TRUE  )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a = b
	TEST( var_neginf_neginf )
		dim as single a = -1/0
		dim as single b = -1/0

		chkIfStmt( a =  b, TRUE )
		chkIfStmt( a <> b, FALSE )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, TRUE  )
		chkIfStmt( (a <> b) <> 0, FALSE )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), FALSE )
		chkIfStmt( not (a <> b), TRUE  )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, FALSE )
		chkIfStmt( (a <> b) =  0, TRUE  )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a < b
	TEST( var_neginf_one )
		dim as single a = -1/0
		dim as single b = 1

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, TRUE  )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, TRUE  )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), FALSE )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, FALSE )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a < b
	TEST( var_neginf_posinf )
		dim as single a = -1/0
		dim as single b = 1/0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, TRUE  )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, TRUE  )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), FALSE )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, FALSE )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a < b
	TEST( var_zero_posinf )
		dim as single a = 0
		dim as single b = 1/0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, TRUE  )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, TRUE  )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), FALSE )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, FALSE )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a < b
	TEST( var_one_posinf )
		dim as single a = 1
		dim as single b = 1/0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, TRUE  )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, TRUE  )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), FALSE )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, FALSE )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a < b
	TEST( var_neginf_zero )
		dim as single a = -1/0
		dim as single b = 0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, TRUE  )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, TRUE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, TRUE  )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, TRUE  )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), FALSE )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), FALSE )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, FALSE )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, FALSE )
	END_TEST

	'' a > b
	TEST( var_posinf_zero )
		dim as single a = 1/0
		dim as single b = 0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, TRUE  )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE  )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, TRUE  )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), FALSE )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, FALSE )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST

	'' a > b
	TEST( var_posinf_one )
		dim as single a = 1/0
		dim as single b = 1

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, TRUE  )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE  )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, TRUE  )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), FALSE )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, FALSE )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST

	'' a > b
	TEST( var_zero_neginf )
		dim as single a = 0
		dim as single b = -1/0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, TRUE  )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE  )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, TRUE  )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), FALSE )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, FALSE )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST

	'' a > b
	TEST( var_one_neginf )
		dim as single a = 1
		dim as single b = -1/0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, TRUE  )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE  )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, TRUE  )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), FALSE )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, FALSE )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST

	'' a > b
	TEST( var_posinf_neginf )
		dim as single a = 1/0
		dim as single b = -1/0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, TRUE  )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, TRUE  )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, TRUE  )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, TRUE  )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), FALSE )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), FALSE )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, FALSE )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, FALSE )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST
#endif

#if __FB_FPMODE__ <> "fast"
#if CHECK_IND <> 0

	'' nan op nan
	TEST( var_nan_nan )
		dim as single a = 1/0
		dim as single b = 1/0
		a *= 0
		b *= 0

		chkIfStmt( a =  b, FALSE )
		chkIfStmt( a <> b, TRUE  )
		chkIfStmt( a >  b, FALSE )
		chkIfStmt( a <  b, FALSE )
		chkIfStmt( a >= b, FALSE )
		chkIfStmt( a <= b, FALSE )

		chkIfStmt( (a =  b) <> 0, FALSE )
		chkIfStmt( (a <> b) <> 0, TRUE  )
		chkIfStmt( (a >  b) <> 0, FALSE )
		chkIfStmt( (a <  b) <> 0, FALSE )
		chkIfStmt( (a >= b) <> 0, FALSE )
		chkIfStmt( (a <= b) <> 0, FALSE )

		chkIfStmt( not (a =  b), TRUE  )
		chkIfStmt( not (a <> b), FALSE )
		chkIfStmt( not (a >  b), TRUE  )
		chkIfStmt( not (a <  b), TRUE  )
		chkIfStmt( not (a >= b), TRUE  )
		chkIfStmt( not (a <= b), TRUE  )

		chkIfStmt( (a =  b) =  0, TRUE  )
		chkIfStmt( (a <> b) =  0, FALSE )
		chkIfStmt( (a >  b) =  0, TRUE  )
		chkIfStmt( (a <  b) =  0, TRUE  )
		chkIfStmt( (a >= b) =  0, TRUE  )
		chkIfStmt( (a <= b) =  0, TRUE  )
	END_TEST

#endif
#endif

END_SUITE
