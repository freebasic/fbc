#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED_MUTABLE

SUITE( fbc_tests.udt_zstring_.lrset )

	#macro check_lset( dst, src, length1, length2 )
		scope
			'' lset/rset
			dim z1 as zstring * 50 = left( dst, (length1) )
			dim z2 as zstring * 50 = left( src, (length2) )
			dim e1 as zstring * 50

			dim u1 as ustring = z1
			dim u2 as ustring = z2

			if( (length1) > (length2) ) then
				e1 = (z2) & space( (length1) - (length2) )
			else
				e1 = left( z2, (length1) )
			end if

			CU_ASSERT( len(e1) = (length1) )

			'' zstring are zero terminated and length
			'' is determined from the string data
			lset (z1) = (z2)
			CU_ASSERT_ZSTRING_EQUAL( z1, e1 )

			lset (z1) = (u2)
			CU_ASSERT_ZSTRING_EQUAL( z1, e1 )

			lset (u1) = (z2)
			dim r1 as zstring * 50 = u1
			CU_ASSERT_ZSTRING_EQUAL( r1, e1 )

			lset (u1) = (u2)
			dim r2 as zstring * 50 = u1
			CU_ASSERT_ZSTRING_EQUAL( r2, e1 )
		end scope
	#endmacro

	#macro check_rset( dst, src, length1, length2 )
		scope
			'' lset/rset
			dim z1 as zstring * 50 = left( dst, (length1) )
			dim z2 as zstring * 50 = left( src, (length2) )
			dim e1 as zstring * 50

			dim u1 as ustring = z1
			dim u2 as ustring = z2

			if( (length1) > (length2) ) then
				e1 = wspace( (length1) - (length2) ) & (z2)
			else
				e1 = left( z2, (length1) )
			end if

			CU_ASSERT( len(e1) = (length1) )

			'' zstring are zero terminated and length
			'' is determined from the string data
			rset (z1) = (z2)
			CU_ASSERT_ZSTRING_EQUAL( z1, e1 )

			rset (z1) = (u2)
			CU_ASSERT_ZSTRING_EQUAL( z1, e1 )

			rset (u1) = (z2)
			dim r1 as zstring * 50 = u1
			CU_ASSERT_ZSTRING_EQUAL( r1, e1 )

			rset (u1) = (u2)
			dim r2 as zstring * 50 = u1
			CU_ASSERT_ZSTRING_EQUAL( r2, e1 )
		end scope
	#endmacro

	TEST( ascii )

		const MAX = 8
		dim dst as zstring * (MAX+1)
		dim src as zstring * (MAX+1)

		dst = "12345678"
		src = "ABCDEFGH"

		for i1 as integer = 0 to MAX
			for i2 as integer = 0 to MAX

				check_lset( dst, src, i1, i2 )
				check_rset( dst, src, i1, i2 )

			next i2
		next i1

	END_TEST

END_SUITE
