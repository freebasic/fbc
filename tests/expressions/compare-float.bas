#include once "fbcunit.bi"


#ifndef ENABLE_CHECK_BUGS
#define ENABLE_CHECK_BUGS 0
#endif

'' not sure if this logic works on all targets - but it was developed and tested on X86

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

enum COMPARE_RESULTS
	CR_EQ = 1
	CR_NE = 2
	CR_GT = 4
	CR_LT = 8
	CR_GE = 16
	CR_LE = 32
end enum

SUITE( fbc_tests.expressions.compare_float )

	#macro tst_branch_bop_f( expr, CR_XX, expected )
		if( expr ) then
			CU_ASSERT( (expected and CR_XX) <> 0 )
		else
			CU_ASSERT( (expected and CR_XX) = 0 )
		end if
	#endmacro

	#macro tst_IIF____bop_f( expr, CR_XX, expected )
		scope
			dim r as integer
			r = iif( expr, t, f )
			if( (expected and CR_XX) <> 0 ) then
				CU_ASSERT( r = t )
			end if
			if( (expected and CR_XX) = 0 ) then
				CU_ASSERT( r = f )
			end if
		end scope
	#endmacro

	#macro tst_expr2i_bop_f( expr, CR_XX, expected )
		scope
			dim r as integer
			r = (expr)
			if( (expected and CR_XX) <> 0 ) then
				CU_ASSERT( r = -1 )
			end if
			if( (expected and CR_XX) = 0 ) then
				CU_ASSERT( r = 0 )
			end if
		end scope
	#endmacro

	#macro tst_expr2b_bop_f( expr, CR_XX, expected )
		scope
			dim r as integer
			r = (expr)
			if( (expected and CR_XX) <> 0 ) then
				CU_ASSERT( r = -1 )
			end if
			if( (expected and CR_XX) = 0 ) then
				CU_ASSERT( r = 0 )
			end if
		end scope
	#endmacro

	sub chk_branch_bop_f( byval a as single, byval b as single, byval expected as COMPARE_RESULTS )

		'' variables
		tst_branch_bop_f( a =  b, CR_EQ, expected )
		tst_branch_bop_f( a <> b, CR_NE, expected )
		tst_branch_bop_f( a >  b, CR_GT, expected )
		tst_branch_bop_f( a <  b, CR_LT, expected )
		tst_branch_bop_f( a >= b, CR_GE, expected )
		tst_branch_bop_f( a <= b, CR_LE, expected )

		'' <> 0 should be optimized out, same results as above
		tst_branch_bop_f( (a =  b)<>0, CR_EQ, expected )
		tst_branch_bop_f( (a <> b)<>0, CR_NE, expected )
		tst_branch_bop_f( (a >  b)<>0, CR_GT, expected )
		tst_branch_bop_f( (a <  b)<>0, CR_LT, expected )
		tst_branch_bop_f( (a >= b)<>0, CR_GE, expected )
		tst_branch_bop_f( (a <= b)<>0, CR_LE, expected )


		'' registers (intermediate results)
		dim c as single = 0

		tst_branch_bop_f( (a - c) =  (b - c), CR_EQ, expected )
		tst_branch_bop_f( (a - c) <> (b - c), CR_NE, expected )
		tst_branch_bop_f( (a - c) >  (b - c), CR_GT, expected )
		tst_branch_bop_f( (a - c) <  (b - c), CR_LT, expected )
		tst_branch_bop_f( (a - c) >= (b - c), CR_GE, expected )
		tst_branch_bop_f( (a - c) <= (b - c), CR_LE, expected )

		'' <> 0 should be optimized out, same results as above
		tst_branch_bop_f( (a - c) =  (b - c)<>0, CR_EQ, expected )
		tst_branch_bop_f( (a - c) <> (b - c)<>0, CR_NE, expected )
		tst_branch_bop_f( (a - c) >  (b - c)<>0, CR_GT, expected )
		tst_branch_bop_f( (a - c) <  (b - c)<>0, CR_LT, expected )
		tst_branch_bop_f( (a - c) >= (b - c)<>0, CR_GE, expected )
		tst_branch_bop_f( (a - c) <= (b - c)<>0, CR_LE, expected )


	end sub

	sub chk_IIF____bop_f _
		( _
			byval a as single, byval b as single, _
			byval expected as COMPARE_RESULTS _
		)

		dim t as integer = 1
		dim f as integer = 2

		'' variables
		tst_IIF____bop_f( a =  b, CR_EQ, expected )
		tst_IIF____bop_f( a <> b, CR_NE, expected )
		tst_IIF____bop_f( a >  b, CR_GT, expected )
		tst_IIF____bop_f( a <  b, CR_LT, expected )
		tst_IIF____bop_f( a >= b, CR_GE, expected )
		tst_IIF____bop_f( a <= b, CR_LE, expected )

		'' variables, the  '<> 0' should be optimized out
		tst_IIF____bop_f( (a =  b)<>0, CR_EQ, expected )
		tst_IIF____bop_f( (a <> b)<>0, CR_NE, expected )
		tst_IIF____bop_f( (a >  b)<>0, CR_GT, expected )
		tst_IIF____bop_f( (a <  b)<>0, CR_LT, expected )
		tst_IIF____bop_f( (a >= b)<>0, CR_GE, expected )
		tst_IIF____bop_f( (a <= b)<>0, CR_LE, expected )

		'' registers (intermediate results)
		dim c as single = 0

		tst_IIF____bop_f( (a - c) =  (b - c), CR_EQ, expected )
		tst_IIF____bop_f( (a - c) <> (b - c), CR_NE, expected )
		tst_IIF____bop_f( (a - c) >  (b - c), CR_GT, expected )
		tst_IIF____bop_f( (a - c) <  (b - c), CR_LT, expected )
		tst_IIF____bop_f( (a - c) >= (b - c), CR_GE, expected )
		tst_IIF____bop_f( (a - c) <= (b - c), CR_LE, expected )

		'' '<> 0' should be optimized out
		tst_IIF____bop_f( ((a - c) =  (b - c))<>0, CR_EQ, expected )
		tst_IIF____bop_f( ((a - c) <> (b - c))<>0, CR_NE, expected )
		tst_IIF____bop_f( ((a - c) >  (b - c))<>0, CR_GT, expected )
		tst_IIF____bop_f( ((a - c) <  (b - c))<>0, CR_LT, expected )
		tst_IIF____bop_f( ((a - c) >= (b - c))<>0, CR_GE, expected )
		tst_IIF____bop_f( ((a - c) <= (b - c))<>0, CR_LE, expected )

	end sub

	sub chk_exprXX_bop_f( byval a as single, byval b as single, byval expected as COMPARE_RESULTS )

		'' variables to boolean
		tst_expr2b_bop_f( a =  b, CR_EQ, expected )
		tst_expr2b_bop_f( a <> b, CR_NE, expected )
		tst_expr2b_bop_f( a >  b, CR_GT, expected )
		tst_expr2b_bop_f( a <  b, CR_LT, expected )
		tst_expr2b_bop_f( a >= b, CR_GE, expected )
		tst_expr2b_bop_f( a <= b, CR_LE, expected )

		'' variables to integer
		tst_expr2i_bop_f( a =  b, CR_EQ, expected )
		tst_expr2i_bop_f( a <> b, CR_NE, expected )
		tst_expr2i_bop_f( a >  b, CR_GT, expected )
		tst_expr2i_bop_f( a <  b, CR_LT, expected )
		tst_expr2i_bop_f( a >= b, CR_GE, expected )
		tst_expr2i_bop_f( a <= b, CR_LE, expected )

		'' registers (intermediate results)
		dim c as single = 0

		'' registers to boolean
		tst_expr2b_bop_f( (a - c) =  (b - c), CR_EQ, expected )
		tst_expr2b_bop_f( (a - c) <> (b - c), CR_NE, expected )
		tst_expr2b_bop_f( (a - c) >  (b - c), CR_GT, expected )
		tst_expr2b_bop_f( (a - c) <  (b - c), CR_LT, expected )
		tst_expr2b_bop_f( (a - c) >= (b - c), CR_GE, expected )
		tst_expr2b_bop_f( (a - c) <= (b - c), CR_LE, expected )

		'' registers to integer
		tst_expr2i_bop_f( (a - c) =  (b - c), CR_EQ, expected )
		tst_expr2i_bop_f( (a - c) <> (b - c), CR_NE, expected )
		tst_expr2i_bop_f( (a - c) >  (b - c), CR_GT, expected )
		tst_expr2i_bop_f( (a - c) <  (b - c), CR_LT, expected )
		tst_expr2i_bop_f( (a - c) >= (b - c), CR_GE, expected )
		tst_expr2i_bop_f( (a - c) <= (b - c), CR_LE, expected )

	end sub

	sub chk_exprNZ_bop_f( byval a as single, byval b as single, byval expected as COMPARE_RESULTS )

		'' relational op not equal to zero
		'' '<> 0' should be optimized out

		'' variables <> 0 to boolean
		tst_expr2b_bop_f( (a =  b)<>0, CR_EQ, expected )
		tst_expr2b_bop_f( (a <> b)<>0, CR_NE, expected )
		tst_expr2b_bop_f( (a >  b)<>0, CR_GT, expected )
		tst_expr2b_bop_f( (a <  b)<>0, CR_LT, expected )
		tst_expr2b_bop_f( (a >= b)<>0, CR_GE, expected )
		tst_expr2b_bop_f( (a <= b)<>0, CR_LE, expected )

		'' variables <> 0 to integer
		tst_expr2i_bop_f( (a =  b)<>0, CR_EQ, expected )
		tst_expr2i_bop_f( (a <> b)<>0, CR_NE, expected )
		tst_expr2i_bop_f( (a >  b)<>0, CR_GT, expected )
		tst_expr2i_bop_f( (a <  b)<>0, CR_LT, expected )
		tst_expr2i_bop_f( (a >= b)<>0, CR_GE, expected )
		tst_expr2i_bop_f( (a <= b)<>0, CR_LE, expected )

		'' registers (intermediate results)
		dim c as single = 0

		'' registers <> 0 to boolean
		tst_expr2b_bop_f( ((a - c) =  (b - c))<>0, CR_EQ, expected )
		tst_expr2b_bop_f( ((a - c) <> (b - c))<>0, CR_NE, expected )
		tst_expr2b_bop_f( ((a - c) >  (b - c))<>0, CR_GT, expected )
		tst_expr2b_bop_f( ((a - c) <  (b - c))<>0, CR_LT, expected )
		tst_expr2b_bop_f( ((a - c) >= (b - c))<>0, CR_GE, expected )
		tst_expr2b_bop_f( ((a - c) <= (b - c))<>0, CR_LE, expected )

		'' registers <> 0 to integer
		tst_expr2i_bop_f( ((a - c) =  (b - c))<>0, CR_EQ, expected )
		tst_expr2i_bop_f( ((a - c) <> (b - c))<>0, CR_NE, expected )
		tst_expr2i_bop_f( ((a - c) >  (b - c))<>0, CR_GT, expected )
		tst_expr2i_bop_f( ((a - c) <  (b - c))<>0, CR_LT, expected )
		tst_expr2i_bop_f( ((a - c) >= (b - c))<>0, CR_GE, expected )
		tst_expr2i_bop_f( ((a - c) <= (b - c))<>0, CR_LE, expected )

	end sub

	sub chk_exprEZ_bop_f( byval a as single, byval b as single, byval expected as COMPARE_RESULTS )

		'' '= 0' should be optimized out with an inverse relational op
		'' For example
		'' (a=b)=0    =>    (a!=b)

		'' variables = 0 to boolean
		tst_expr2b_bop_f( (a =  b)=0, CR_EQ, expected )
		tst_expr2b_bop_f( (a <> b)=0, CR_NE, expected )
		tst_expr2b_bop_f( (a >  b)=0, CR_GT, expected )
		tst_expr2b_bop_f( (a <  b)=0, CR_LT, expected )
		tst_expr2b_bop_f( (a >= b)=0, CR_GE, expected )
		tst_expr2b_bop_f( (a <= b)=0, CR_LE, expected )

		'' variables = 0 to integer
		tst_expr2i_bop_f( (a =  b)=0, CR_EQ, expected )
		tst_expr2i_bop_f( (a <> b)=0, CR_NE, expected )
		tst_expr2i_bop_f( (a >  b)=0, CR_GT, expected )
		tst_expr2i_bop_f( (a <  b)=0, CR_LT, expected )
		tst_expr2i_bop_f( (a >= b)=0, CR_GE, expected )
		tst_expr2i_bop_f( (a <= b)=0, CR_LE, expected )

		'' registers (intermediate results)
		dim c as single = 0

		'' registers = 0 to boolean
		tst_expr2b_bop_f( ((a - c) =  (b - c))=0, CR_EQ, expected )
		tst_expr2b_bop_f( ((a - c) <> (b - c))=0, CR_NE, expected )
		tst_expr2b_bop_f( ((a - c) >  (b - c))=0, CR_GT, expected )
		tst_expr2b_bop_f( ((a - c) <  (b - c))=0, CR_LT, expected )
		tst_expr2b_bop_f( ((a - c) >= (b - c))=0, CR_GE, expected )
		tst_expr2b_bop_f( ((a - c) <= (b - c))=0, CR_LE, expected )

		'' registers = 0 to integer
		tst_expr2i_bop_f( ((a - c) =  (b - c))=0, CR_EQ, expected )
		tst_expr2i_bop_f( ((a - c) <> (b - c))=0, CR_NE, expected )
		tst_expr2i_bop_f( ((a - c) >  (b - c))=0, CR_GT, expected )
		tst_expr2i_bop_f( ((a - c) <  (b - c))=0, CR_LT, expected )
		tst_expr2i_bop_f( ((a - c) >= (b - c))=0, CR_GE, expected )
		tst_expr2i_bop_f( ((a - c) <= (b - c))=0, CR_LE, expected )

	end sub

	sub chk_bopXX_f( byval a as single, byval b as single, cr as COMPARE_RESULTS )
		chk_branch_bop_f( a, b, cr )
		chk_IIF____bop_f( a, b, cr )
		chk_exprXX_bop_f( a, b, cr )
		chk_exprNZ_bop_f( a, b, cr )
	end sub

	sub chk_bopEZ_f( byval a as single, byval b as single, cr as COMPARE_RESULTS )
		chk_exprEZ_bop_f( a, b, cr )
	end sub

	TEST( bop_single )

		dim as single a, b

		'' a = b
		a = 0
		b = 0
		chk_bopXX_f( a, b, CR_EQ or CR_GE or CR_LE )
		chk_bopEZ_f( a, b, CR_NE or CR_GT or CR_LT )

		'' a = b
		a = 1
		b = 1
		chk_bopXX_f( a, b, CR_EQ or CR_GE or CR_LE )
		chk_bopEZ_f( a, b, CR_NE or CR_GT or CR_LT )

		'' a < b
		a = 0
		b = 1
		chk_bopXX_f( a, b, CR_NE or CR_LT or CR_LE )
		chk_bopEZ_f( a, b, CR_EQ or CR_GE or CR_GT )

		'' a > b
		a = 1
		b = 0
		chk_bopXX_f( a, b, CR_NE or CR_GT or CR_GE )
		chk_bopEZ_f( a, b, CR_EQ or CR_LE or CR_LT )
	END_TEST

#if CHECK_INF <> 0

	TEST( bop_inf )
		dim as single a, b, inf_pos, inf_neg
		inf_pos = 1/0
		inf_neg = -1/0

		'' a < b
		a = 0
		b = inf_pos
		chk_bopXX_f( a, b, CR_NE or CR_LT or CR_LE )
		chk_bopEZ_f( a, b, CR_EQ or CR_GE or CR_GT )

		'' a > b
		a = inf_pos
		b = 0
		chk_bopXX_f( a, b, CR_NE or CR_GT or CR_GE )
		chk_bopEZ_f( a, b, CR_EQ or CR_LE or CR_LT )

		'' a > b
		a = 0
		b = inf_neg
		chk_bopXX_f( a, b, CR_NE or CR_GT or CR_GE )
		chk_bopEZ_f( a, b, CR_EQ or CR_LE or CR_LT )

		'' a < b
		a = inf_neg
		b = 0
		chk_bopXX_f( a, b, CR_NE or CR_LT or CR_LE )
		chk_bopEZ_f( a, b, CR_EQ or CR_GE or CR_GT )

		'' a = b
		a = inf_pos
		b = inf_pos
		chk_bopXX_f( a, b, CR_EQ or CR_GE or CR_LE )
		chk_bopEZ_f( a, b, CR_NE or CR_LT or CR_GT )

		'' a = b
		a = inf_neg
		b = inf_neg
		chk_bopXX_f( a, b, CR_EQ or CR_GE or CR_LE )
		chk_bopEZ_f( a, b, CR_NE or CR_LT or CR_GT )

		'' a > b
		a = inf_pos
		b = inf_neg
		chk_bopXX_f( a, b, CR_NE or CR_GT or CR_GE )
		chk_bopEZ_f( a, b, CR_EQ or CR_LE or CR_LT )

		'' a < b
		a = inf_neg
		b = inf_pos
		chk_bopXX_f( a, b, CR_NE or CR_LT or CR_LE )
		chk_bopEZ_f( a, b, CR_EQ or CR_GE or CR_GT )

	END_TEST

#endif

#if CHECK_IND <> 0
#if __FB_FPMODE__ <> "fast"

	TEST( bop_ind )

		dim as single a, b, ind = 1/0
		ind *= 0

		a = 0
		b = ind
		chk_bopXX_f( a, b, CR_NE )

		a = ind
		b = 0
		chk_bopXX_f( a, b, CR_NE )

		a = ind
		b = ind
		chk_bopXX_f( a, b, CR_NE )

	END_TEST
#endif
#endif

	#macro tst_branch_uop_f( expr, expected )
		if( expr ) then
			CU_ASSERT( cbool(expected) = cbool(TRUE) )
		else
			CU_ASSERT( cbool(expected) = cbool(FALSE) )
		end if
	#endmacro

	#macro tst_IIF____uop_f( expr, expected )
		scope
			dim as integer r, t=2,f=3
			r = iif( expr, t, f )
			if( r = t ) then
				CU_ASSERT( (expected) = TRUE )
			end if
			if( r = f ) then
				CU_ASSERT( (expected) = FALSE )
			end if
		end scope
	#endmacro

	#macro tst_expr2i_uop_f( expr, expected )
		scope
			dim as integer r
			r = (expr)
			if( r <> 0 ) then
				CU_ASSERT( (expected) = TRUE )
			else
				CU_ASSERT( (expected) = FALSE )
			end if
			dim as integer r2 = (expr)
			if( r2 <> 0 ) then
				CU_ASSERT( (expected) = TRUE )
			else
				CU_ASSERT( (expected) = FALSE )
			end if
		end scope
	#endmacro

	#macro tst_expr2b_uop_f( expr, expected )
		scope
			dim r as boolean
			r = (expr)
			if( r <> FALSE ) then
				CU_ASSERT( (expected) = TRUE )
			else
				CU_ASSERT( (expected) = FALSE )
			end if
			dim r2 as boolean = (expr)
			if( r2 <> FALSE ) then
				CU_ASSERT( (expected) = TRUE )
			else
				CU_ASSERT( (expected) = FALSE )
			end if
		end scope
	#endmacro

	sub chk_cmp_self_f( byval a as single, byval isnan as boolean )

		tst_branch_uop_f( a =  a, not isnan )
		tst_branch_uop_f( a <> a, isnan     )
		tst_branch_uop_f( a >  a, FALSE     )
		tst_branch_uop_f( a <  a, FALSE     )
		tst_branch_uop_f( a >= a, not isnan )
		tst_branch_uop_f( a <= a, not isnan )

		tst_IIF____uop_f( a =  a, not isnan )
		tst_IIF____uop_f( a <> a, isnan     )
		tst_IIF____uop_f( a >  a, FALSE     )
		tst_IIF____uop_f( a <  a, FALSE     )
		tst_IIF____uop_f( a >= a, not isnan )
		tst_IIF____uop_f( a <= a, not isnan )

		tst_expr2i_uop_f( a =  a, not isnan )
		tst_expr2i_uop_f( a <> a, isnan     )
		tst_expr2i_uop_f( a >  a, FALSE     )
		tst_expr2i_uop_f( a <  a, FALSE     )
		tst_expr2i_uop_f( a >= a, not isnan )
		tst_expr2i_uop_f( a <= a, not isnan )

		tst_expr2b_uop_f( a =  a, not isnan )
		tst_expr2b_uop_f( a <> a, isnan     )
		tst_expr2b_uop_f( a >  a, FALSE     )
		tst_expr2b_uop_f( a <  a, FALSE     )
		tst_expr2b_uop_f( a >= a, not isnan )
		tst_expr2b_uop_f( a <= a, not isnan )

	end sub

	sub chk_cmp_conv_f( byval a as single, byval expected as boolean, byval isnan as boolean )

		'' variable
		tst_branch_uop_f( a, expected )
		tst_IIF____uop_f( a, expected )
		tst_expr2i_uop_f( a, expected )
		tst_expr2b_uop_f( a, expected )

		tst_branch_uop_f( cbool(a), expected )
		tst_IIF____uop_f( cbool(a), expected )
		tst_expr2i_uop_f( cbool(a), expected )
		tst_expr2b_uop_f( cbool(a), expected )

		'' cbool(expression)
		dim as boolean b = false
		dim as single c = 0

		tst_branch_uop_f( (a - c), expected )
		tst_IIF____uop_f( (a - c), expected )
		tst_expr2i_uop_f( (a - c), expected )
		tst_expr2b_uop_f( (a - c), expected )

		tst_branch_uop_f( cbool(a - c), expected )
		tst_IIF____uop_f( cbool(a - c), expected )
		tst_expr2i_uop_f( cbool(a - c), expected )
		tst_expr2b_uop_f( cbool(a - c), expected )

		'' boolean expression
		tst_branch_uop_f( cbool(a) or b, expected )
		tst_IIF____uop_f( cbool(a) or b, expected )
		tst_expr2i_uop_f( cbool(a) or b, expected )
		tst_expr2b_uop_f( cbool(a) or b, expected )

	end sub

	TEST( uop_number )

		dim as single a

		a = 0
		chk_cmp_self_f( a, FALSE )
		chk_cmp_conv_f( a, FALSE, FALSE )

		a = 1
		chk_cmp_self_f( a, FALSE )
		chk_cmp_conv_f( a, TRUE , FALSE )

	END_TEST

#if CHECK_INF <> 0
	TEST( uop_inf )

		dim as single a, inf_pos, inf_neg

		inf_pos = 1/0
		inf_neg = -1/0

		a = inf_pos
		chk_cmp_self_f( a, FALSE )
		chk_cmp_conv_f( a, TRUE , FALSE )

		a = inf_neg
		chk_cmp_self_f( a, FALSE )
		chk_cmp_conv_f( a, TRUE , FALSE )

	END_TEST
#endif

#if CHECK_IND <> 0
#if __FB_FPMODE__ <> "fast"
	TEST( uop_ind )

		dim as single a, ind = 1/0
		ind *= 0

		a = ind
		chk_cmp_self_f( a, TRUE )
		chk_cmp_conv_f( a, TRUE, TRUE )

	END_TEST
#endif
#endif

END_SUITE
