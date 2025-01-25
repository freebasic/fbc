#include "fbcunit.bi"

'' show the compared numbers, but only if fbcu.getHideCases() is false
#undef CU_ASSERT_EQUAL
#define CU_ASSERT_EQUAL(a, b) if ((a) <> (b)) and (fbcu.getHideCases() = false) then print (a), (b) end if: CU_ASSERT( (a) = (b) )

SUITE( fbc_tests.numbers.cast_f2l )

	sub checkcast(byval x as double, byval ul as ulong)

		'' 32 bit
		CU_ASSERT_EQUAL( cuint( x ), cuint( ul ) )

		if( ul > 1ul shl 31 ) then return
		CU_ASSERT_EQUAL( cint( -x ), cint( -ul ) )
		CU_ASSERT_EQUAL( clng( -x ), clng( -ul ) )

		if( ul > (1ul shl 31) - 1 ) then return
		CU_ASSERT_EQUAL( cint( x ), cint( ul ) )
		CU_ASSERT_EQUAL( clng( x ), clng( ul ) )

		if( ul > (1ul shl 31) - 1 ) then return
		CU_ASSERT_EQUAL( cint( x ), cint( ul ) )
		CU_ASSERT_EQUAL( clng( x ), clng( ul ) )

		'' 16 bit
		if( ul > 65535 ) then return
		CU_ASSERT_EQUAL( cushort( x ), cushort( ul ) )

		if( ul > 32768 ) then return
		CU_ASSERT_EQUAL( cshort( -x ), cshort( -ul ) )

		if( ul > 32767 ) then return
		CU_ASSERT_EQUAL( cshort( x ), cshort( ul ) )

		'' 8 bit
		if( ul > 255 ) then return
		CU_ASSERT_EQUAL( cubyte( x ), cubyte( ul ) )

		if( ul > 128 ) then return
		CU_ASSERT_EQUAL( cbyte( -x ), cbyte( -ul ) )

		if( ul > 127 ) then return
		CU_ASSERT_EQUAL( cbyte( x ), cbyte( ul ) )

	end sub

	sub testnum( byval n as ulong )

		#define lsb(n) ((n) and -(n)) '' keep only least significant bit

		'' only run when n has <= 53 significant bits
		if( n and -(lsb(n) shl 53) ) then return

		dim x as double = cdbl(n)

		checkcast( x, n )

		if( n < 1ul shl 31 ) then

			'' make sure that cdbl(l) concurs with cdbl(ul)
			CU_ASSERT_EQUAL( x, cdbl(clng(n)) )


			if( n < 1ul shl 52 ) then
				checkcast( x + 0.5, n + (n and 1) )
				checkcast( x - 0.5, n - (n and 1) )
			end if

			if( n < 1ul shl 51 ) then
				checkcast( x + 0.25, n )
				checkcast( x - 0.25, n )
			end if

		end if

	end sub

	TEST( cast_l )

		dim as long n = 1l
		dim as double x = 1.0

		dim as integer i, j, k, l

		'' test powers of 2
		for i = 0 to 31
			testnum( 1ul shl i )
		next i

		'' test various bit combinations
		for i = 0 to 31
			for j = 0 to 31
				testnum( (1 shl i) + (1 shl j) )
			next j
		next i

	END_TEST

END_SUITE
