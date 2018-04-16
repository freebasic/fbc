# include "fbcunit.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE (-1)

SUITE( fbc_tests.boolean_.boolean_bop )

	''
	TEST( bop_const )

		#macro dot( arg1, op, arg2 )
			a = arg1
			b = arg2
			c = arg1 op arg2

			'' test (var bop var) = const(const bop const)
			CU_ASSERT_EQUAL( a op b, c )

			'' test (const bop var) = const(const bop const)
			CU_ASSERT_EQUAL( arg1 op b, c )

			'' test (var bop const) = const(const bop const)
			CU_ASSERT_EQUAL( a op arg2, c )

			'' test (const bop const) = const(const bop const)
			CU_ASSERT_EQUAL( arg1 op arg2, c )

		#endmacro

		dim as boolean a, b
		dim as integer c

		''   (a op b) == (arg op arg)

		dot( FALSE, and, FALSE )
		dot( FALSE, and, TRUE )
		dot( TRUE, and, FALSE )
		dot( TRUE, and, TRUE )

		dot( FALSE, or, FALSE )
		dot( FALSE, or, TRUE )
		dot( TRUE, or, FALSE )
		dot( TRUE, or, TRUE )

		dot( FALSE, xor, FALSE )
		dot( FALSE, xor, TRUE )
		dot( TRUE, xor, FALSE )
		dot( TRUE, xor, TRUE )

		dot( FALSE, imp, FALSE )
		dot( FALSE, imp, TRUE )
		dot( TRUE, imp, FALSE )
		dot( TRUE, imp, TRUE )

		dot( FALSE, eqv, FALSE )
		dot( FALSE, eqv, TRUE )
		dot( TRUE, eqv, FALSE )
		dot( TRUE, eqv, TRUE )

		dot( FALSE, =, FALSE )
		dot( FALSE, =, TRUE )
		dot( TRUE, =, FALSE )
		dot( TRUE, =, TRUE )

		dot( FALSE, <>, FALSE )
		dot( FALSE, <>, TRUE )
		dot( TRUE, <>, FALSE )
		dot( TRUE, <>, TRUE )

		dot( FALSE, andalso, FALSE )
		dot( FALSE, andalso, TRUE )
		dot( TRUE, andalso, FALSE )
		dot( TRUE, andalso, TRUE )

		dot( FALSE, orelse, FALSE )
		dot( FALSE, orelse, TRUE )
		dot( TRUE, orelse, FALSE )
		dot( TRUE, orelse, TRUE )

	END_TEST
	
	TEST( bop_compare )

		#define lhs_CIF  cint(FALSE)
		#define lhs_CIT  cint(TRUE)
		#define lhs_CBF  cbool(FALSE)
		#define lhs_CBT  cbool(TRUE)

		#define rhs_CIF  cint(FALSE)
		#define rhs_CIT  cint(TRUE)
		#define rhs_CBF  cbool(FALSE)
		#define rhs_CBT  cbool(TRUE)

		dim lhs_VIF as integer = cint(FALSE)
		dim lhs_VIT as integer = cint(TRUE)
		dim lhs_VBF as boolean = cbool(FALSE)
		dim lhs_VBT as boolean = cbool(TRUE)

		dim rhs_VIF as integer = cint(FALSE)
		dim rhs_VIT as integer = cint(TRUE)
		dim rhs_VBF as boolean = cbool(FALSE)
		dim rhs_VBT as boolean = cbool(TRUE)

		dim r as integer

		r = (lhs_CIF = rhs_CIF): CU_ASSERT( r = TRUE  )
		r = (lhs_CIT = rhs_CIF): CU_ASSERT( r = FALSE )
		r = (lhs_CBF = rhs_CIF): CU_ASSERT( r = TRUE  )
		r = (lhs_CBT = rhs_CIF): CU_ASSERT( r = FALSE )
		r = (lhs_VIF = rhs_CIF): CU_ASSERT( r = TRUE  )
		r = (lhs_VIT = rhs_CIF): CU_ASSERT( r = FALSE )
		r = (lhs_VBF = rhs_CIF): CU_ASSERT( r = TRUE  )
		r = (lhs_VBT = rhs_CIF): CU_ASSERT( r = FALSE )

		r = (lhs_CIF = rhs_CIT): CU_ASSERT( r = FALSE )
		r = (lhs_CIT = rhs_CIT): CU_ASSERT( r = TRUE  )
		r = (lhs_CBF = rhs_CIT): CU_ASSERT( r = FALSE )
		r = (lhs_CBT = rhs_CIT): CU_ASSERT( r = TRUE  )
		r = (lhs_VIF = rhs_CIT): CU_ASSERT( r = FALSE )
		r = (lhs_VIT = rhs_CIT): CU_ASSERT( r = TRUE  )
		r = (lhs_VBF = rhs_CIT): CU_ASSERT( r = FALSE )
		r = (lhs_VBT = rhs_CIT): CU_ASSERT( r = TRUE  )

		r = (lhs_CIF = rhs_CBF): CU_ASSERT( r = TRUE  )
		r = (lhs_CIT = rhs_CBF): CU_ASSERT( r = FALSE )
		r = (lhs_CBF = rhs_CBF): CU_ASSERT( r = TRUE  )
		r = (lhs_CBT = rhs_CBF): CU_ASSERT( r = FALSE )
		r = (lhs_VIF = rhs_CBF): CU_ASSERT( r = TRUE  )
		r = (lhs_VIT = rhs_CBF): CU_ASSERT( r = FALSE )
		r = (lhs_VBF = rhs_CBF): CU_ASSERT( r = TRUE  )
		r = (lhs_VBT = rhs_CBF): CU_ASSERT( r = FALSE )

		r = (lhs_CIF = rhs_CBT): CU_ASSERT( r = FALSE )
		r = (lhs_CIT = rhs_CBT): CU_ASSERT( r = TRUE  )
		r = (lhs_CBF = rhs_CBT): CU_ASSERT( r = FALSE )
		r = (lhs_CBT = rhs_CBT): CU_ASSERT( r = TRUE  )
		r = (lhs_VIF = rhs_CBT): CU_ASSERT( r = FALSE )
		r = (lhs_VIT = rhs_CBT): CU_ASSERT( r = TRUE  )
		r = (lhs_VBF = rhs_CBT): CU_ASSERT( r = FALSE )
		r = (lhs_VBT = rhs_CBT): CU_ASSERT( r = TRUE  )

		r = (lhs_CIF = rhs_VIF): CU_ASSERT( r = TRUE  )
		r = (lhs_CIT = rhs_VIF): CU_ASSERT( r = FALSE )
		r = (lhs_CBF = rhs_VIF): CU_ASSERT( r = TRUE  )
		r = (lhs_CBT = rhs_VIF): CU_ASSERT( r = FALSE )
		r = (lhs_VIF = rhs_VIF): CU_ASSERT( r = TRUE  )
		r = (lhs_VIT = rhs_VIF): CU_ASSERT( r = FALSE )
		r = (lhs_VBF = rhs_VIF): CU_ASSERT( r = TRUE  )
		r = (lhs_VBT = rhs_VIF): CU_ASSERT( r = FALSE )

		r = (lhs_CIF = rhs_VIT): CU_ASSERT( r = FALSE )
		r = (lhs_CIT = rhs_VIT): CU_ASSERT( r = TRUE  )
		r = (lhs_CBF = rhs_VIT): CU_ASSERT( r = FALSE )
		r = (lhs_CBT = rhs_VIT): CU_ASSERT( r = TRUE  )
		r = (lhs_VIF = rhs_VIT): CU_ASSERT( r = FALSE )
		r = (lhs_VIT = rhs_VIT): CU_ASSERT( r = TRUE  )
		r = (lhs_VBF = rhs_VIT): CU_ASSERT( r = FALSE )
		r = (lhs_VBT = rhs_VIT): CU_ASSERT( r = TRUE  )

		r = (lhs_CIF = rhs_VBF): CU_ASSERT( r = TRUE  )
		r = (lhs_CIT = rhs_VBF): CU_ASSERT( r = FALSE )
		r = (lhs_CBF = rhs_VBF): CU_ASSERT( r = TRUE  )
		r = (lhs_CBT = rhs_VBF): CU_ASSERT( r = FALSE )
		r = (lhs_VIF = rhs_VBF): CU_ASSERT( r = TRUE  )
		r = (lhs_VIT = rhs_VBF): CU_ASSERT( r = FALSE )
		r = (lhs_VBF = rhs_VBF): CU_ASSERT( r = TRUE  )
		r = (lhs_VBT = rhs_VBF): CU_ASSERT( r = FALSE )

		r = (lhs_CIF = rhs_VBT): CU_ASSERT( r = FALSE )
		r = (lhs_CIT = rhs_VBT): CU_ASSERT( r = TRUE  )
		r = (lhs_CBF = rhs_VBT): CU_ASSERT( r = FALSE )
		r = (lhs_CBT = rhs_VBT): CU_ASSERT( r = TRUE  )
		r = (lhs_VIF = rhs_VBT): CU_ASSERT( r = FALSE )
		r = (lhs_VIT = rhs_VBT): CU_ASSERT( r = TRUE  )
		r = (lhs_VBF = rhs_VBT): CU_ASSERT( r = FALSE )
		r = (lhs_VBT = rhs_VBT): CU_ASSERT( r = TRUE  )

	END_TEST

	TEST( pureBooleanBops )
		#macro check( l, bop, r, expectedResult )
			scope
				dim as boolean b1, b2, b3

				#assert typeof( cbool( l ) bop cbool( r ) ) = typeof( boolean )
				#assert typeof( b1         bop b2         ) = typeof( boolean )
				#assert typeof( b1         bop cbool( r ) ) = typeof( boolean )
				#assert typeof( cbool( l ) bop b2         ) = typeof( boolean )

				CU_ASSERT( (cbool( l ) bop cbool( r )) = cbool( expectedResult ) )

				b1 = (l)
				b2 = (r)
				b3 = b1 bop b2
				CU_ASSERT( b3 = cbool( expectedResult ) )
			end scope
		#endmacro

		check(  0, and,  0,  0 )
		check(  0, and,  1,  0 )
		check(  0, and, -1,  0 )
		check(  1, and,  0,  0 )
		check(  1, and,  1, -1 )
		check(  1, and, -1, -1 )
		check( -1, and,  0,  0 )
		check( -1, and,  1, -1 )
		check( -1, and, -1, -1 )

		check(  0, or,  0,  0 )
		check(  0, or,  1, -1 )
		check(  0, or, -1, -1 )
		check(  1, or,  0, -1 )
		check(  1, or,  1, -1 )
		check(  1, or, -1, -1 )
		check( -1, or,  0, -1 )
		check( -1, or,  1, -1 )
		check( -1, or, -1, -1 )

		check(  0, xor,  0,  0 )
		check(  0, xor,  1, -1 )
		check(  0, xor, -1, -1 )
		check(  1, xor,  0, -1 )
		check(  1, xor,  1,  0 )
		check(  1, xor, -1,  0 )
		check( -1, xor,  0, -1 )
		check( -1, xor,  1,  0 )
		check( -1, xor, -1,  0 )

		check(  0, eqv,  0, -1 )
		check(  0, eqv,  1,  0 )
		check(  0, eqv, -1,  0 )
		check(  1, eqv,  0,  0 )
		check(  1, eqv,  1, -1 )
		check(  1, eqv, -1, -1 )
		check( -1, eqv,  0,  0 )
		check( -1, eqv,  1, -1 )
		check( -1, eqv, -1, -1 )

		check(  0, imp,  0, -1 )
		check(  0, imp,  1, -1 )
		check(  0, imp, -1, -1 )
		check(  1, imp,  0,  0 )
		check(  1, imp,  1, -1 )
		check(  1, imp, -1, -1 )
		check( -1, imp,  0,  0 )
		check( -1, imp,  1, -1 )
		check( -1, imp, -1, -1 )

		check(  0, =,  0, -1 )
		check(  0, =,  1,  0 )
		check(  0, =, -1,  0 )
		check(  1, =,  0,  0 )
		check(  1, =,  1, -1 )
		check(  1, =, -1, -1 )
		check( -1, =,  0,  0 )
		check( -1, =,  1, -1 )
		check( -1, =, -1, -1 )

		check(  0, <>,  0,  0 )
		check(  0, <>,  1, -1 )
		check(  0, <>, -1, -1 )
		check(  1, <>,  0, -1 )
		check(  1, <>,  1,  0 )
		check(  1, <>, -1,  0 )
		check( -1, <>,  0, -1 )
		check( -1, <>,  1,  0 )
		check( -1, <>, -1,  0 )

		check(  0, andalso,  0,  0 )
		check(  0, andalso,  1,  0 )
		check(  0, andalso, -1,  0 )
		check(  1, andalso,  0,  0 )
		check(  1, andalso,  1, -1 )
		check(  1, andalso, -1, -1 )
		check( -1, andalso,  0,  0 )
		check( -1, andalso,  1, -1 )
		check( -1, andalso, -1, -1 )

		check(  0, orelse,  0,  0 )
		check(  0, orelse,  1, -1 )
		check(  0, orelse, -1, -1 )
		check(  1, orelse,  0, -1 )
		check(  1, orelse,  1, -1 )
		check(  1, orelse, -1, -1 )
		check( -1, orelse,  0, -1 )
		check( -1, orelse,  1, -1 )
		check( -1, orelse, -1, -1 )
	END_TEST

END_SUITE
