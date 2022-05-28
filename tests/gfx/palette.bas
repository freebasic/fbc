#include "fbcunit.bi"
#include once "fbgfx.bi"

SUITE( fbc_tests.gfx.palette_ )

	const SCREEN_W = 16
	const SCREEN_H = 16

	'' Tests:
	''   PALETTE GET index, qb_value
	''   PALETTE GET index, r, g, b
	''   PALETTE GET USING array
	''   PALETTE GET USING array(index)
	''   PALETTE GET USING @array(index)
	''   PALETTE GET USING pointer
	''   PALETTE GET USING UDT
	''   PALETTE GET USING byref-variable

	'' The palette values we are comparing with come from gfxlib.   If the fbgfx default
	'' palette ever changes, these values must be updated to match.

	dim shared def_qb_pal1(0 to ...) as long = _
		{ _
			&h00000000, &h002A0000, &h00002A00, &h002A2A00, _
			&h0000002A, &h002A002A, &h0000152A, &h002A2A2A, _
			&h00151515, &h003F1515, &h00153F15, &h003F3F15, _
			&h0015153F, &h003F153F, &h00153F3F, &h003F3F3F _
		}

	type RGBVALUE
		r as integer
		g as integer
		b as integer
	end type

	dim shared def_rgb_pal1(0 to ...) as RGBVALUE = _
		{ _
			(&h00, &h00, &h00), (&h00, &h00, &hAA), (&h00, &hAA, &h00), (&h00, &hAA, &hAA), _
			(&hAA, &h00, &h00), (&hAA, &h00, &hAA), (&hAA, &h55, &h00), (&hAA, &hAA, &hAA), _
			(&h55, &h55, &h55), (&h55, &h55, &hFF), (&h55, &hFF, &h55), (&h55, &hFF, &hFF), _
			(&hFF, &h55, &h55), (&hFF, &h55, &hFF), (&hFF, &hFF, &h55), (&hFF, &hFF, &hFF) _
		}

	sub hInitNullGfx()
		'' 8-bit screen mode
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 8, , fb.GFX_NULL ) = 0 )
	end sub

	#macro assert_pal( expr )
		for i as integer = 0 to 15
			CU_ASSERT_EQUAL( expr, def_qb_pal1(i) )
		next
	#endmacro

	#macro do_test( T, expr1 )
		scope
			dim p(0 To 255) As T
			palette get using expr1
			assert_pal( p(i) )
		end scope
	#endmacro

	#macro do_test_at_N( N, T, expr1 )
		scope
			dim p(N To N+255) As T
			palette get using expr1
			assert_pal( p(i+N) )
		end scope
	#endmacro

	TEST( paletteGetArrayByName )
		hInitNullGfx()
		do_test( long, p )
		do_test( ulong, p )
		do_test( integer, p )
		do_test( uinteger, p )
		do_test( longint, p )
		do_test( ulongint, p )

		do_test_at_N( 5, long, p )
		do_test_at_N( 5, ulong, p )
		do_test_at_N( 5, integer, p )
		do_test_at_N( 5, uinteger, p )
		do_test_at_N( 5, longint, p )
		do_test_at_N( 5, ulongint, p )
	END_TEST

	TEST( paletteGetArrayByIndex )
		hInitNullGfx()
		do_test( integer, p(0) )
		do_test( uinteger, p(0) )
		do_test( long, p(0) )
		do_test( ulong, p(0) )
		do_test( longint, p(0) )
		do_test( ulongint, p(0) )

		do_test_at_N( 5, integer, p(5) )
		do_test_at_N( 5, uinteger, p(5) )
		do_test_at_N( 5, long, p(5) )
		do_test_at_N( 5, ulong, p(5) )
		do_test_at_N( 5, longint, p(5) )
		do_test_at_N( 5, ulongint, p(5) )
	END_TEST

	TEST( paletteGetPtrToArrayIndex )
		hInitNullGfx()
		do_test( integer, @p(0) )
		do_test( uinteger, @p(0) )
		do_test( long, @p(0) )
		do_test( ulong, @p(0) )
		do_test( longint, @p(0) )
		do_test( ulongint, @p(0) )
		do_test( integer, cast(any ptr, @p(0) ) )

		do_test_at_N( 5, integer, @p(5) )
		do_test_at_N( 5, uinteger, @p(5) )
		do_test_at_N( 5, long, @p(5) )
		do_test_at_N( 5, ulong, @p(5) )
		do_test_at_N( 5, longint, @p(5) )
		do_test_at_N( 5, ulongint, @p(5) )
		do_test_at_N( 5, integer, cast(any ptr, @p(5) ) )
	END_TEST

	#macro do_test_ptr( T, expr1 )
		scope
			dim p(0 To 255) As T
			dim x as T ptr = @p(0)
			palette get using expr1
			assert_pal( p(i) )
		end scope
	#endmacro

	TEST( paletteGetPtrToArray )
		hInitNullGfx()

		do_test_ptr( long, x )
		do_test_ptr( ulong, x )
		do_test_ptr( integer, x )
		do_test_ptr( uinteger, x )
		do_test_ptr( longint, x )
		do_test_ptr( ulongint, x )

		do_test_ptr( long, @x[0] )
		do_test_ptr( ulong, @x[0] )
		do_test_ptr( integer, @x[0] )
		do_test_ptr( uinteger, @x[0] )
		do_test_ptr( longint, @x[0] )
		do_test_ptr( ulongint, @x[0] )

	END_TEST

	#macro defn_PAL_UDT( T )

		type PAL_##T
			pal as T ptr
			declare constructor
			declare destructor
			declare operator cast() as T ptr
			declare operator []( index as integer ) as T
		end type

		constructor PAL_##T
			pal = new T[256]
		end constructor

		destructor PAL_##t
			delete[] pal
		end destructor

		operator PAL_##T.cast() as T ptr
			operator = pal
		end operator

		operator PAL_##T.[]( index as integer ) as T
			operator = pal[index]
		end operator

	#endmacro

	defn_PAL_UDT( long )
	defn_PAL_UDT( ulong )
	defn_PAL_UDT( integer )
	defn_PAL_UDT( uinteger )
	defn_PAL_UDT( longint )
	defn_PAL_UDT( ulongint )

	#macro test_UDTptrCast( T )
		scope
			dim p as PAL_##T
			palette get using p
			for i as integer = 0 to 15
				CU_ASSERT( p[i] = def_qb_pal1(i) )
			next
		end scope
	#endmacro

	TEST( paletteGetUDTPtr )
		hInitNullGfx()
		test_UDTptrCast( long )
		test_UDTptrCast( ulong )
		test_UDTptrCast( integer )
		test_UDTptrCast( uinteger )
		test_UDTptrCast( longint )
		test_UDTptrCast( ulongint )
	END_TEST

	#macro test_qb_pal_value( T )
		for i as integer = 0 to 15
			dim value as T
			palette get i, value
			CU_ASSERT( value = def_qb_pal1(i) )
		next
	#endmacro

	TEST( paletteGetQbValue )
		hInitNullGfx()
		test_qb_pal_value( long )
		test_qb_pal_value( ulong )
		test_qb_pal_value( integer )
		test_qb_pal_value( uinteger )
		test_qb_pal_value( longint )
		test_qb_pal_value( ulongint )
	END_TEST

	#macro test_rgb_pal_value( T )
		for i as integer = 0 to 15
			dim as integer r, g, b
			palette get i, r, g, b
			CU_ASSERT( r = def_rgb_pal1(i).r )
			CU_ASSERT( g = def_rgb_pal1(i).g )
			CU_ASSERT( b = def_rgb_pal1(i).b )
		next
	#endmacro

	TEST( paletteGetRgbValue )
		hInitNullGfx()
		test_rgb_pal_value( long )
		test_rgb_pal_value( ulong )
		test_rgb_pal_value( integer )
		test_rgb_pal_value( uinteger )
		test_rgb_pal_value( longint )
		test_rgb_pal_value( ulongint )
	END_TEST

	#macro do_test_byref( T, expr1 )
		scope
			dim p(0 To 255) As T
			dim byref x as T = p(0)
			palette get using expr1
			assert_pal( p(i) )
		end scope
	#endmacro

	TEST( paletteGetByrefPointer )
		hInitNullGfx()

		do_test_byref( long, @x )
		do_test_byref( ulong, @x )
		do_test_byref( integer, @x )
		do_test_byref( uinteger, @x )
		do_test_byref( longint, @x )
		do_test_byref( ulongint, @x )

	END_TEST

END_SUITE
