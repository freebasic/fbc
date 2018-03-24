# include "fbcunit.bi"

#macro testfor_types( from_, to_, stp_ )

	testfor_to( byte   , from_, to_, stp_ )
	testfor_to( short  , from_, to_, stp_ )
	testfor_to( integer, from_, to_, stp_ )
	testfor_to( long   , from_, to_, stp_ )
	testfor_to( longint, from_, to_, stp_ )

	testfor_to( ubyte   , from_, to_, stp_ )
	testfor_to( ushort  , from_, to_, stp_ )
	testfor_to( uinteger, from_, to_, stp_ )
	testfor_to( ulong   , from_, to_, stp_ )
	testfor_to( ulongint, from_, to_, stp_ )

	testfor_to( single, from_, to_, stp_ )
	testfor_to( double, from_, to_, stp_ )

#endmacro

#macro testfor_to( type_, from_, to_, stp_ )
	scope
		const t = to_
		testfor_stp(type_, from_, t, stp_)
	end scope
	scope
		var t = to_
		testfor_stp(type_, from_, t, stp_)
	end scope
#endmacro

#macro testfor_stp( type_, from_, to_, stp_ )
	scope
		const s = stp_
		testfor(type_, from_, to_, s)
	end scope
	scope
		var s = stp_
		testfor(type_, from_, to_, s)
	end scope
#endmacro

#macro testfor( type_, from_, to_, stp_ )
	scope
		dim as integer ctr1 = 0, ctr2 = 0

		ctr1 = 1 + int( ((to_) - (from_)) / (stp_) )
		for i as type_ = (from_) to (to_) step (stp_)
			ctr2 += 1
			if( ctr2 > ctr1 ) then exit for '' failsafe
		next i
		CU_ASSERT_EQUAL( ctr1, ctr2 )
	end scope
#endmacro

SUITE( fbc_tests.compound.for_step )

	TEST( for_positive_step )
		testfor_types( 10, 20, 1 )
		testfor_types( 10, 20, 1f )
		testfor_types( 10, 20, 1u )

		'' should detect that unsigned step>=0 and that (0+step) > 1
		'' (just as with any step > 1) and therefore loop exactly once
		testfor_to( ubyte   , 0, 1, 1u shl 7 )
		testfor_to( ushort  , 0, 1, 1u shl 15 )
		testfor_to( uinteger, 0, 1, 1u shl 31 )
		testfor_to( ulong   , 0, 1, 1u shl 31 )
		testfor_to( ulongint, 0, 1, 1ull shl 63 )

		testfor_to( byte   , -1   shl  6, 0, 1u   shl  7 )
		testfor_to( short  , -1   shl 14, 0, 1u   shl 15 )
		testfor_to( integer, -1   shl 30, 0, 1u   shl 31 )
		testfor_to( long   , -1   shl 30, 0, 1u   shl 31 )
		testfor_to( longint, -1ll shl 62, 0, 1ull shl 63 )

	END_TEST

	TEST( for_negative_step )

		testfor_types( 20, 10, -1 )
		testfor_types( 20, 10, -1f )

	END_TEST

END_SUITE
