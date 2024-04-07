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

SUITE( fbc_tests.expressions.float_to_bool )

	TEST( variable )

		dim as single a
		dim b as boolean
		dim i as integer

		b = cbool( false )
		CU_ASSERT( b = false )
		i = cbool( false )
		CU_ASSERT( b = 0 )

		a = 1
		b = cbool( true )
		CU_ASSERT( b = true )
		i = cbool( true )
		CU_ASSERT( i = -1 )

		a = 0
		b = cbool( a )
		CU_ASSERT( b = false )
		i = cbool( a )
		CU_ASSERT( b = 0 )

		a = 1
		b = cbool( a )
		CU_ASSERT( b = true )
		i = cbool( a )
		CU_ASSERT( i = -1 )

		a = -1
		b = cbool( a )
		CU_ASSERT( b = true )
		i = cbool( a )
		CU_ASSERT( i = -1 )

#if CHECK_INF <> 0

		a = 1/0
		b = cbool( a )
		CU_ASSERT( b = true )
		i = cbool( a )
		CU_ASSERT( i = -1 )

		a = -1/0
		b = cbool( a )
		CU_ASSERT( b = true )
		i = cbool( a )
		CU_ASSERT( i = -1 )

#endif

#if __FB_FPMODE__ <> "fast"
#if CHECK_IND <> 0

		a = 1/0
		a *= 0
		b = cbool( a )
		CU_ASSERT( b = true )
		i = cbool( a )
		CU_ASSERT( i = -1 )

#endif
#endif

	END_TEST

	TEST( expr )

		dim as single a, c
		dim b as boolean
		dim i as integer

		a = 0
		b = cbool( a-c )
		CU_ASSERT( b = false )
		i = cbool( a-c )
		CU_ASSERT( i = 0 )

		a = 1
		b = cbool( a-c )
		CU_ASSERT( b = true )
		i = cbool( a-c )
		CU_ASSERT( i = -1 )

		a = -1
		b = cbool( a-c )
		CU_ASSERT( b = true )
		i = cbool( a-c )
		CU_ASSERT( i = -1 )

#if CHECK_INF <> 0

		a = 1/0
		b = cbool( a-c )
		CU_ASSERT( b = true )
		i = cbool( a-c )
		CU_ASSERT( i = -1 )

		a = -1/0
		b = cbool( a-c )
		CU_ASSERT( b = true )
		i = cbool( a-c )
		CU_ASSERT( i = -1 )

#endif

#if __FB_FPMODE__ <> "fast"
#if CHECK_IND <> 0

		a = 1/0
		a *= 0
		b = cbool( a-c )
		CU_ASSERT( b = true )
		i = cbool( a-c )
		CU_ASSERT( i = -1 )

#endif
#endif

	END_TEST

	TEST( not_variable )

		dim as single a
		dim b as boolean
		dim i as integer

		b = cbool( not false )
		CU_ASSERT( b = true )
		i = cbool( not false )
		CU_ASSERT( i = -1 )

		b = cbool( not true )
		CU_ASSERT( b = false )
		i = cbool( not true )
		CU_ASSERT( i = 0 )

		b = not cbool( false )
		CU_ASSERT( b = true )
		i = not cbool( false )
		CU_ASSERT( i = -1 )

		b = not cbool( not false )
		CU_ASSERT( b = false )
		i = not cbool( not false )
		CU_ASSERT( i = 0 )

		a = 1
		b = cbool( not true )
		CU_ASSERT( b = false )
		i = cbool( not true )
		CU_ASSERT( i = 0 )

		a = 0
		b = not cbool( a )
		CU_ASSERT( b = true )
		i = not cbool( a )
		CU_ASSERT( b = -1 )

		a = 1
		b = not cbool( a )
		CU_ASSERT( b = false )
		i = not cbool( a )
		CU_ASSERT( i = 0 )

		a = -1
		b = not cbool( a )
		CU_ASSERT( b = false )
		i = not cbool( a )
		CU_ASSERT( i = 0 )

#if CHECK_INF <> 0

		a = 1/0
		b = not cbool( a )
		CU_ASSERT( b = false )
		i = not cbool( a )
		CU_ASSERT( i = 0 )

		a = -1/0
		b = not cbool( a )
		CU_ASSERT( b = false )
		i = not cbool( a )
		CU_ASSERT( i = 0 )

#endif

#if __FB_FPMODE__ <> "fast"
#if CHECK_IND <> 0

		a = 1/0
		a *= 0
		b = not cbool( a )
		CU_ASSERT( b = false )
		i = not cbool( a )
		CU_ASSERT( i = 0 )

#endif
#endif

	END_TEST

END_SUITE
