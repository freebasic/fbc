#include once "fbcunit.bi"

#ifndef ENABLE_CHECK_BUGS
#define ENABLE_CHECK_BUGS 0
#endif

#if ENABLE_CHECK_BUGS <> 0
	#ifdef __FB_X86__
		#define CHECK_INF 1
		#define CHECK_IND 1
	#endif
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

	#macro tst_branch_bop_f( expr, CR_XX )
		'' print #expr
		if( expr ) then
			CU_ASSERT( (expected and CR_XX) <> 0 )
		else
			CU_ASSERT( (expected and CR_XX) = 0 )
		end if
	#endmacro

	#macro tst_IIF____bop_f( expr, CR_XX )
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

	#macro tst_expr2i_bop_f( expr, CR_XX )
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

	#macro tst_expr2b_bop_f( expr, CR_XX )
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

		tst_branch_bop_f( a =  b, CR_EQ )
		tst_branch_bop_f( a <> b, CR_NE )
		tst_branch_bop_f( a >  b, CR_GT )
		tst_branch_bop_f( a <  b, CR_LT )
		tst_branch_bop_f( a >= b, CR_GE )
		tst_branch_bop_f( a <= b, CR_LE )

	end sub

	sub chk_IIF____bop_f _
		( _
			byval a as single, byval b as single, _
			byval expected as COMPARE_RESULTS _
		)

		dim t as integer = 1
		dim f as integer = 2

		tst_IIF____bop_f( a =  b, CR_EQ )
		tst_IIF____bop_f( a <> b, CR_NE )
		tst_IIF____bop_f( a >  b, CR_GT )
		tst_IIF____bop_f( a <  b, CR_LT )
		tst_IIF____bop_f( a >= b, CR_GE )
		tst_IIF____bop_f( a <= b, CR_LE )

	end sub

	sub chk_exprXX_bop_f( byval a as single, byval b as single, byval expected as COMPARE_RESULTS )

		tst_expr2b_bop_f( a =  b, CR_EQ )
		tst_expr2b_bop_f( a <> b, CR_NE )
		tst_expr2b_bop_f( a >  b, CR_GT )
		tst_expr2b_bop_f( a <  b, CR_LT )
		tst_expr2b_bop_f( a >= b, CR_GE )
		tst_expr2b_bop_f( a <= b, CR_LE )

		tst_expr2i_bop_f( a =  b, CR_EQ )
		tst_expr2i_bop_f( a <> b, CR_NE )
		tst_expr2i_bop_f( a >  b, CR_GT )
		tst_expr2i_bop_f( a <  b, CR_LT )
		tst_expr2i_bop_f( a >= b, CR_GE )
		tst_expr2i_bop_f( a <= b, CR_LE )

	end sub

	sub chk_bop_f( byval a as single, byval b as single, cr as COMPARE_RESULTS )
		'' print "a:"; a, "b:"; b

		chk_branch_bop_f( a, b, cr )
		chk_IIF____bop_f( a, b, cr )
		chk_exprXX_bop_f( a, b, cr )
	end sub

	TEST( bop_single )

		dim as single a, b

		'' a = b
		a = 0
		b = 0
		chk_bop_f( a, b, CR_EQ or CR_GE or CR_LE )

		'' a = b
		a = 1
		b = 1
		chk_bop_f( a, b, CR_EQ or CR_GE or CR_LE )

		'' a < b
		a = 0
		b = 1
		chk_bop_f( a, b, CR_NE or CR_LT or CR_LE )

		'' a > b
		a = 1
		b = 0
		chk_bop_f( a, b, CR_NE or CR_GT or CR_GE )
	END_TEST

#if CHECK_INF <> 0

	TEST( bop_inf )
		dim as single a, b, inf_pos, inf_neg
		inf_pos = 1/0
		inf_neg = -1/0

		'' a < b
		a = 0
		b = inf_pos
		chk_bop_f( a, b, CR_NE or CR_LT or CR_LE )

		'' a > b
		a = inf_pos
		b = 0
		chk_bop_f( a, b, CR_NE or CR_GT or CR_GE )

		'' a > b
		a = 0
		b = inf_neg
		chk_bop_f( a, b, CR_NE or CR_GT or CR_GE )

		'' a < b
		a = inf_neg
		b = 0
		chk_bop_f( a, b, CR_NE or CR_LT or CR_LE )

		'' a = b
		a = inf_pos
		b = inf_pos
		chk_bop_f( a, b, CR_EQ or CR_GE or CR_LE )

		'' a = b
		a = inf_neg
		b = inf_neg
		chk_bop_f( a, b, CR_EQ or CR_GE or CR_LE )

		'' a > b
		a = inf_pos
		b = inf_neg
		chk_bop_f( a, b, CR_NE or CR_GT or CR_GE )

		'' a < b
		a = inf_neg
		b = inf_pos
		chk_bop_f( a, b, CR_NE or CR_LT or CR_LE )

	END_TEST

#endif

#if CHECK_IND <> 0
#if __FB_FPMODE__ <> "fast"

	TEST( bop_ind )

		dim as single a, b, ind = 1/0
		ind *= 0

		a = 0
		b = ind
		chk_bop_f( a, b, CR_NE )

		a = ind
		b = 0
		chk_bop_f( a, b, CR_NE )

		a = ind
		b = ind
		chk_bop_f( a, b, CR_NE )

	END_TEST
#endif
#endif

	#macro tst_branch_uop_f( expr, expected )
		'' print #expr
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
		'' print "a:"; a

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
		'' print "a:"; a

		tst_branch_uop_f( a, expected )
		tst_IIF____uop_f( a, expected )
		tst_expr2i_uop_f( a, expected )
		tst_expr2b_uop_f( a, expected )

		tst_branch_uop_f( cbool(a), expected )
		tst_IIF____uop_f( cbool(a), expected )
		tst_expr2i_uop_f( cbool(a), expected )
		tst_expr2b_uop_f( cbool(a), expected )

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
