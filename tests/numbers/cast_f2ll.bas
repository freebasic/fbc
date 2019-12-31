#include "fbcunit.bi"

'' show the compared numbers, but only if fbcu.getHideCases() is false
#undef CU_ASSERT_EQUAL
#define CU_ASSERT_EQUAL(a, b) if ((a) <> (b)) and (fbcu.getHideCases() = false) then print (a), (b) end if: CU_ASSERT( (a) = (b) )

SUITE( fbc_tests.numbers.cast_f2ll )

	sub checkcast(byval x as double, byval ull as ulongint)

		'' 64 bit
		CU_ASSERT_EQUAL( culngint( x ), ull )

		if( ull > 1ull shl 63 ) then return
		CU_ASSERT_EQUAL( clngint( -x ), clngint( -ull ) )

		if( ull > (1ull shl 63) - 1 ) then return
		CU_ASSERT_EQUAL( clngint( x ), clngint( ull ) )

		'' 32 bit
		if( ull > 1ull shl 32 ) then return
		CU_ASSERT_EQUAL( cuint( x ), cuint( ull ) )

		if( ull > 1ull shl 31 ) then return
		CU_ASSERT_EQUAL( cint( -x ), cint( -ull ) )
		CU_ASSERT_EQUAL( clng( -x ), clng( -ull ) )

		if( ull > (1ull shl 31) - 1 ) then return
		CU_ASSERT_EQUAL( cint( x ), cint( ull ) )
		CU_ASSERT_EQUAL( clng( x ), clng( ull ) )

		if( ull > (1ull shl 31) - 1 ) then return
		CU_ASSERT_EQUAL( cint( x ), cint( ull ) )
		CU_ASSERT_EQUAL( clng( x ), clng( ull ) )

		'' 16 bit
		if( ull > 65535 ) then return
		CU_ASSERT_EQUAL( cushort( x ), cushort( ull ) )

		if( ull > 32768 ) then return
		CU_ASSERT_EQUAL( cshort( -x ), cshort( -ull ) )

		if( ull > 32767 ) then return
		CU_ASSERT_EQUAL( cshort( x ), cshort( ull ) )

		'' 8 bit
		if( ull > 255 ) then return
		CU_ASSERT_EQUAL( cubyte( x ), cubyte( ull ) )

		if( ull > 128 ) then return
		CU_ASSERT_EQUAL( cbyte( -x ), cbyte( -ull ) )

		if( ull > 127 ) then return
		CU_ASSERT_EQUAL( cbyte( x ), cbyte( ull ) )

	end sub

	sub testnum( byval n as ulongint )

		#define lsb(n) ((n) and -(n)) '' keep only least significant bit

		'' only run when n has <= 53 significant bits
		if( n and -(lsb(n) shl 53) ) then return

		dim x as double = cdbl(n)

		checkcast( x, n )

		if( n < 1ull shl 63 ) then

			'' make sure that cdbl(ll) concurs with cdbl(ull)
			CU_ASSERT_EQUAL( x, cdbl(clngint(n)) )


			if( n < 1ull shl 52 ) then
				checkcast( x + 0.5, n + (n and 1) )
				checkcast( x - 0.5, n - (n and 1) )
			end if

			if( n < 1ull shl 51 ) then
				checkcast( x + 0.25, n )
				checkcast( x - 0.25, n )
			end if

		end if

	end sub

	TEST( cast_ll )

		dim as longint n = 1ll
		dim as double x = 1.0

		dim as integer i, j, k, l

		'' test powers of 2
		for i = 0 to 63
			testnum( 1ull shl i )
		next i

		'' test various bit combinations
		for i = 0 to 63-52
			for j = iif(i=0, 0, 52) to 52
				for k = 0 to j-2

				#if 0 '' Too slow?  Results in millions of asserts
					for l = 0 to k-1
						'' try to cover various different bit patterns
						testnum( (j + k + l) shl i )
						testnum( (j + k - l) shl i )
						testnum( (j - k + l) shl i )
						testnum( (j - k - l) shl i )
					next l
				#else
					testnum( (j + k) shl i )
					testnum( (j - k) shl i )
				#endif

				next k
			next j
		next i

	END_TEST

	TEST( cast_hiconst_ull )
		#macro test_cast(dval, ullval)
		scope
			const as double d = dval
			const as ulongint ull = ullval
			CU_ASSERT_EQUAL( culngint( d ), ull )
			if( ull < 1ull shl 63 ) then
				CU_ASSERT_EQUAL( clngint( d ), clngint( ull ) )
			end if
		end scope
		#endmacro

		'' sanity checks
		test_cast( 1.5, 2 )
		test_cast( 2^32, &H100000000ull )

		'' numbers over 2^63 can't be converted properly with just clngint()
		test_cast( 2^63,               &H8000000000000000ull )
		test_cast( 2^63 * 1.5,         &HC000000000000000ull )
		test_cast( 2^63 + 2^(63 - 52), &H8000000000000800ull )
		test_cast( 2^64 - 2^(63 - 52), &HFFFFFFFFFFFFF800ull )

	END_TEST

END_SUITE
