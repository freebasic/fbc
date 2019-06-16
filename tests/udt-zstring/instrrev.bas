#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.instrrev_ )

	'' INSTRREV( zstring, zstring )
	#macro check_0( result, text, pattern )
		scope
			dim st as zstring * 50 = text
			dim ut as ustring = st
			dim sp as zstring * 50 = pattern
			dim up as ustring = sp
			
			dim i as integer
			
			CU_ASSERT_EQUAL( result, instrrev( st, sp ) )
			CU_ASSERT_EQUAL( result, instrrev( st, up ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, sp ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, up ) )
		end scope
	#endmacro

		'' INSTRREV( index, zstring, zstring )
	#macro check_x( result, index, text, pattern )
		scope
			dim st as zstring * 50 = text
			dim ut as ustring = st
			dim sp as zstring * 50 = pattern
			dim up as ustring = sp
			
			dim i as integer
			
			CU_ASSERT_EQUAL( result, instrrev( st, sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( st, up, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, up, index ) )
		end scope
	#endmacro

		'' INSTRREV( zstring, zstring )
	#macro check_0_any( result, text, pattern )
		scope
			dim st as zstring * 50 = text
			dim ut as ustring = st
			dim sp as zstring * 50 = pattern
			dim up as ustring = sp
			
			dim i as integer
			
			CU_ASSERT_EQUAL( result, instrrev( st, any sp ) )
			CU_ASSERT_EQUAL( result, instrrev( st, any up ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any sp ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any up ) )
		end scope
	#endmacro

		'' INSTRREV( index, zstring, zstring )
	#macro check_x_any( result, index, text, pattern )
		scope
			dim st as zstring * 50 = text
			dim ut as ustring = st
			dim sp as zstring * 50 = pattern
			dim up as ustring = sp
			
			dim i as integer
			
			CU_ASSERT_EQUAL( result, instrrev( st, any sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( st, any up, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any up, index ) )
		end scope
	#endmacro

	TEST( instrrev_0 )
		check_0( 0, !"", !"" )
		check_0( 0, !"x", !"" )
		check_0( 0, !"", !"x" )
		check_0( 1, !"x", !"x" )
		check_0( 2, !"yx", !"x" )

		check_0( 1, !"13579", !"13" )
		check_0( 2, !"13579", !"35" )
		check_0( 3, !"13579", !"57" )
		check_0( 4, !"13579", !"79" )
	END_TEST

	TEST( instrrev_x )
		check_x( 0, -2, !"", !"" )
		check_x( 0, -1, !"", !"" )
		check_x( 0,  0, !"", !"" )
		check_x( 0,  1, !"", !"" )
		check_x( 0,  2, !"", !"" )

		check_x( 0, -2, !"x", !"" )
		check_x( 0, -1, !"x", !"" )
		check_x( 0,  0, !"x", !"" )
		check_x( 0,  1, !"x", !"" )
		check_x( 0,  2, !"x", !"" )

		check_x( 0, -2, !"", !"x" )
		check_x( 0, -1, !"", !"x" )
		check_x( 0,  0, !"", !"x" )
		check_x( 0,  1, !"", !"x" )
		check_x( 0,  2, !"", !"x" )

		check_x( 1, -2, !"x", !"x" )
		check_x( 1, -1, !"x", !"x" )
		check_x( 0,  0, !"x", !"x" )
		check_x( 1,  1, !"x", !"x" )
		check_x( 0,  2, !"x", !"x" )
		check_x( 0,  3, !"x", !"x" )

		check_x( 1, -2, !"xy", !"x" )
		check_x( 1, -1, !"xy", !"x" )
		check_x( 0,  0, !"xy", !"x" )
		check_x( 1,  1, !"xy", !"x" )
		check_x( 1,  2, !"xy", !"x" )
		check_x( 0,  3, !"xy", !"x" )

		check_x( 2, -2, !"yx", !"x" )
		check_x( 2, -1, !"yx", !"x" )
		check_x( 0,  0, !"yx", !"x" )
		check_x( 0,  1, !"yx", !"x" )
		check_x( 2,  2, !"yx", !"x" )
		check_x( 0,  3, !"yx", !"x" )

		check_x( 1, -1, !"13579", !"13" )
		check_x( 0,  0, !"13579", !"13" )
		check_x( 1,  1, !"13579", !"13" )
		check_x( 1,  2, !"13579", !"13" )

		check_x( 0,  1, !"13579", !"35" )
		check_x( 2,  2, !"13579", !"35" )
		check_x( 2,  3, !"13579", !"35" )

		check_x( 0,  2, !"13579", !"57" )
		check_x( 3,  3, !"13579", !"57" )
		check_x( 3,  4, !"13579", !"57" )

		check_x( 0,  3, !"13579", !"79" )
		check_x( 4,  4, !"13579", !"79" )
		check_x( 4,  5, !"13579", !"79" )
		check_x( 0,  6, !"13579", !"79" )
	END_TEST

	TEST( instrrev_0_any )
		check_0_any( 0, !"", !"" )
		check_0_any( 0, !"x", !"" )
		check_0_any( 0, !"", !"x" )
		check_0_any( 1, !"x", !"x" )
		check_0_any( 1, !"xy", !"x" )
		check_0_any( 2, !"yx", !"x" )

		check_0_any( 2, !"13579", !"13" )
		check_0_any( 3, !"13579", !"35" )
		check_0_any( 4, !"13579", !"57" )
		check_0_any( 5, !"13579", !"79" )

		check_0_any( 2, !"13579", !"31" )
		check_0_any( 3, !"13579", !"53" )
		check_0_any( 4, !"13579", !"75" )
		check_0_any( 5, !"13579", !"97" )
	END_TEST

	TEST( instrrev_x_any )
		check_x_any( 0, -2, !"", !"" )
		check_x_any( 0, -1, !"", !"" )
		check_x_any( 0,  0, !"", !"" )
		check_x_any( 0,  1, !"", !"" )
		check_x_any( 0,  2, !"", !"" )

		check_x_any( 0, -2, !"x", !"" )
		check_x_any( 0, -1, !"x", !"" )
		check_x_any( 0,  0, !"x", !"" )
		check_x_any( 0,  1, !"x", !"" )
		check_x_any( 0,  2, !"x", !"" )

		check_x_any( 0, -2, !"", !"x" )
		check_x_any( 0, -1, !"", !"x" )
		check_x_any( 0,  0, !"", !"x" )
		check_x_any( 0,  1, !"", !"x" )
		check_x_any( 0,  2, !"", !"x" )

		check_x_any( 1, -2, !"x", !"x" )
		check_x_any( 1, -1, !"x", !"x" )
		check_x_any( 0,  0, !"x", !"x" )
		check_x_any( 1,  1, !"x", !"x" )
		check_x_any( 0,  2, !"x", !"x" )

		check_x_any( 1, -2, !"xy", !"x" )
		check_x_any( 1, -1, !"xy", !"x" )
		check_x_any( 0,  0, !"xy", !"x" )
		check_x_any( 1,  1, !"xy", !"x" )
		check_x_any( 1,  2, !"xy", !"x" )
		check_x_any( 0,  3, !"xy", !"x" )

		check_x_any( 2, -2, !"yx", !"x" )
		check_x_any( 2, -1, !"yx", !"x" )
		check_x_any( 0,  0, !"yx", !"x" )
		check_x_any( 0,  1, !"yx", !"x" )
		check_x_any( 2,  2, !"yx", !"x" )
		check_x_any( 0,  3, !"yx", !"x" )

		check_x_any( 0,  0, !"13579", !"13" )
		check_x_any( 1,  1, !"13579", !"13" )
		check_x_any( 2,  2, !"13579", !"13" )
		check_x_any( 2,  3, !"13579", !"13" )

		check_x_any( 0,  0, !"13579", !"35" )
		check_x_any( 0,  1, !"13579", !"35" )
		check_x_any( 2,  2, !"13579", !"35" )
		check_x_any( 3,  3, !"13579", !"35" )
		check_x_any( 3,  4, !"13579", !"35" )

		check_x_any( 0,  1, !"13579", !"57" )
		check_x_any( 0,  2, !"13579", !"57" )
		check_x_any( 3,  3, !"13579", !"57" )
		check_x_any( 4,  4, !"13579", !"57" )
		check_x_any( 4,  5, !"13579", !"57" )

		check_x_any( 0,  2, !"13579", !"79" )
		check_x_any( 0,  3, !"13579", !"79" )
		check_x_any( 4,  4, !"13579", !"79" )
		check_x_any( 5,  5, !"13579", !"79" )
		check_x_any( 0,  6, !"13579", !"79" )
	END_TEST

END_SUITE
