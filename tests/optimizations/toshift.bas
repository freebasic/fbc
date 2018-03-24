#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.toshift )

	dim shared as byte b
	dim shared as ubyte ub
	dim shared as short s
	dim shared as ushort us
	dim shared as long l
	dim shared as ulong ul
	dim shared as longint ll
	dim shared as ulongint ull
	dim shared as integer i
	dim shared as uinteger ui

	dim shared as integer div2 = 2
	dim shared as integer div4 = 4

	TEST( positive )
		b   = 7
		ub  = 7
		s   = 7
		us  = 7
		l   = 7
		ul  = 7
		ll  = 7
		ull = 7
		i   = 7
		ui  = 7

		CU_ASSERT_EQUAL( b   \ 2,  3 )
		CU_ASSERT_EQUAL( ub  \ 2,  3 )
		CU_ASSERT_EQUAL( s   \ 2,  3 )
		CU_ASSERT_EQUAL( us  \ 2,  3 )
		CU_ASSERT_EQUAL( l   \ 2,  3 )
		CU_ASSERT_EQUAL( ul  \ 2,  3 )
		CU_ASSERT_EQUAL( ll  \ 2,  3 )
		CU_ASSERT_EQUAL( ull \ 2,  3 )
		CU_ASSERT_EQUAL( i   \ 2,  3 )
		CU_ASSERT_EQUAL( ui  \ 2,  3 )

		CU_ASSERT_EQUAL( b   \ div2,  3 )
		CU_ASSERT_EQUAL( ub  \ div2,  3 )
		CU_ASSERT_EQUAL( s   \ div2,  3 )
		CU_ASSERT_EQUAL( us  \ div2,  3 )
		CU_ASSERT_EQUAL( l   \ div2,  3 )
		CU_ASSERT_EQUAL( ul  \ div2,  3 )
		CU_ASSERT_EQUAL( ll  \ div2,  3 )
		CU_ASSERT_EQUAL( ull \ div2,  3 )
		CU_ASSERT_EQUAL( i   \ div2,  3 )
		CU_ASSERT_EQUAL( ui  \ div2,  3 )

		CU_ASSERT_EQUAL( b   \ 4,  1 )
		CU_ASSERT_EQUAL( ub  \ 4,  1 )
		CU_ASSERT_EQUAL( s   \ 4,  1 )
		CU_ASSERT_EQUAL( us  \ 4,  1 )
		CU_ASSERT_EQUAL( l   \ 4,  1 )
		CU_ASSERT_EQUAL( ul  \ 4,  1 )
		CU_ASSERT_EQUAL( ll  \ 4,  1 )
		CU_ASSERT_EQUAL( ull \ 4,  1 )
		CU_ASSERT_EQUAL( i   \ 4,  1 )
		CU_ASSERT_EQUAL( ui  \ 4,  1 )

		CU_ASSERT_EQUAL( b   \ div4,  1 )
		CU_ASSERT_EQUAL( ub  \ div4,  1 )
		CU_ASSERT_EQUAL( s   \ div4,  1 )
		CU_ASSERT_EQUAL( us  \ div4,  1 )
		CU_ASSERT_EQUAL( l   \ div4,  1 )
		CU_ASSERT_EQUAL( ul  \ div4,  1 )
		CU_ASSERT_EQUAL( ll  \ div4,  1 )
		CU_ASSERT_EQUAL( ull \ div4,  1 )
		CU_ASSERT_EQUAL( i   \ div4,  1 )
		CU_ASSERT_EQUAL( ui  \ div4,  1 )
	END_TEST

	TEST( negative )
		b   = -7
		ub  = -7
		s   = -7
		us  = -7
		l   = -7
		ul  = -7
		ll  = -7
		ull = -7
		i   = -7
		ui  = -7

		CU_ASSERT_EQUAL( b   \ 2,  -3 )
		CU_ASSERT_EQUAL( ub  \ 2,  &h7C )
		CU_ASSERT_EQUAL( s   \ 2,  -3 )
		CU_ASSERT_EQUAL( us  \ 2,  &h7FFC )
		CU_ASSERT_EQUAL( l   \ 2,  -3 )
		CU_ASSERT_EQUAL( ul  \ 2,  &h7FFFFFFC )
		CU_ASSERT_EQUAL( ll  \ 2,  -3 )
		CU_ASSERT_EQUAL( ull \ 2,  &h7FFFFFFFFFFFFFFCull )
		CU_ASSERT_EQUAL( i   \ 2,  -3 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( ui  \ 2,  &h7FFFFFFFFFFFFFFCull )
	#else
		CU_ASSERT_EQUAL( ui  \ 2,  &h7FFFFFFC )
	#endif

		CU_ASSERT_EQUAL( b   \ div2,  -3 )
		CU_ASSERT_EQUAL( ub  \ div2,  &h7C )
		CU_ASSERT_EQUAL( s   \ div2,  -3 )
		CU_ASSERT_EQUAL( us  \ div2,  &h7FFC )
		CU_ASSERT_EQUAL( l   \ div2,  -3 )
		CU_ASSERT_EQUAL( ul  \ div2,  &h7FFFFFFC )
		CU_ASSERT_EQUAL( ll  \ div2,  -3 )
		CU_ASSERT_EQUAL( ull \ div2,  &h7FFFFFFFFFFFFFFCull )
		CU_ASSERT_EQUAL( i   \ div2,  -3 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( ui  \ div2,  &h7FFFFFFFFFFFFFFCull )
	#else
		CU_ASSERT_EQUAL( ui  \ div2,  &h7FFFFFFC )
	#endif

		CU_ASSERT_EQUAL( b   \ 4,  -1 )
		CU_ASSERT_EQUAL( ub  \ 4,  &h3E )
		CU_ASSERT_EQUAL( s   \ 4,  -1 )
		CU_ASSERT_EQUAL( us  \ 4,  &h3FFE )
		CU_ASSERT_EQUAL( l   \ 4,  -1 )
		CU_ASSERT_EQUAL( ul  \ 4,  &h3FFFFFFE )
		CU_ASSERT_EQUAL( ll  \ 4,  -1 )
		CU_ASSERT_EQUAL( ull \ 4,  &h3FFFFFFFFFFFFFFEull )
		CU_ASSERT_EQUAL( i   \ 4,  -1 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( ui  \ 4,  &h3FFFFFFFFFFFFFFEull )
	#else
		CU_ASSERT_EQUAL( ui  \ 4,  &h3FFFFFFE )
	#endif

		CU_ASSERT_EQUAL( b   \ div4,  -1 )
		CU_ASSERT_EQUAL( ub  \ div4,  &h3E )
		CU_ASSERT_EQUAL( s   \ div4,  -1 )
		CU_ASSERT_EQUAL( us  \ div4,  &h3FFE )
		CU_ASSERT_EQUAL( l   \ div4,  -1 )
		CU_ASSERT_EQUAL( ul  \ div4,  &h3FFFFFFE )
		CU_ASSERT_EQUAL( ll  \ div4,  -1 )
		CU_ASSERT_EQUAL( ull \ div4,  &h3FFFFFFFFFFFFFFEull )
		CU_ASSERT_EQUAL( i   \ div4,  -1 )
	#ifdef __FB_64BIT__
		CU_ASSERT_EQUAL( ui  \ div4,  &h3FFFFFFFFFFFFFFEull )
	#else
		CU_ASSERT_EQUAL( ui  \ div4,  &h3FFFFFFE )
	#endif
	END_TEST

END_SUITE
