#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED_MUTABLE

SUITE( fbc_tests.udt_wstring_.lrset )

	#macro check_lset( dst, src, length1, length2 )
		scope
			'' lset/rset
			dim w1 as wstring * 50 = left( dst, (length1) )
			dim w2 as wstring * 50 = left( src, (length2) )
			dim e1 as wstring * 50

			dim u1 as ustring = w1
			dim u2 as ustring = w2

			if( (length1) > (length2) ) then
				e1 = (w2) & wspace( (length1) - (length2) )
			else
				e1 = left( w2, (length1) )
			end if

			CU_ASSERT( len(e1) = (length1) )

			'' wstring are zero terminated and length
			'' is determined from the string data
			lset (w1) = (w2)
			CU_ASSERT_WSTRING_EQUAL( w1, e1 )

			lset (w1) = (u2)
			CU_ASSERT_WSTRING_EQUAL( w1, e1 )

			lset (u1) = (w2)
			dim r1 as wstring * 50 = u1
			CU_ASSERT_WSTRING_EQUAL( r1, e1 )

			lset (u1) = (u2)
			dim r2 as wstring * 50 = u1
			CU_ASSERT_WSTRING_EQUAL( r2, e1 )
		end scope
	#endmacro

	#macro check_rset( dst, src, length1, length2 )
		scope
			'' lset/rset
			dim w1 as wstring * 50 = left( dst, (length1) )
			dim w2 as wstring * 50 = left( src, (length2) )
			dim e1 as wstring * 50

			dim u1 as ustring = w1
			dim u2 as ustring = w2

			if( (length1) > (length2) ) then
				e1 = wspace( (length1) - (length2) ) & (w2)
			else
				e1 = left( w2, (length1) )
			end if

			CU_ASSERT( len(e1) = (length1) )

			'' wstring are zero terminated and length
			'' is determined from the string data
			rset (w1) = (w2)
			CU_ASSERT_WSTRING_EQUAL( w1, e1 )

			rset (w1) = (u2)
			CU_ASSERT_WSTRING_EQUAL( w1, e1 )

			rset (u1) = (w2)
			dim r1 as wstring * 50 = u1
			CU_ASSERT_WSTRING_EQUAL( r1, e1 )

			rset (u1) = (u2)
			dim r2 as wstring * 50 = u1
			CU_ASSERT_WSTRING_EQUAL( r2, e1 )
		end scope
	#endmacro

	TEST( ascii )

		const MAX = 8
		dim dst as wstring * (MAX+1)
		dim src as wstring * (MAX+1)

		dst = "12345678"
		src = "ABCDEFGH"

		for i1 as integer = 0 to MAX
			for i2 as integer = 0 to MAX

				check_lset( dst, src, i1, i2 )
				check_rset( dst, src, i1, i2 )

			next i2
		next i1

	END_TEST

	TEST( ucs2 )

		const MAX = 5
		dim dst as wstring * (MAX+1)
		dim src as wstring * (MAX+1)

		dst = !"\u3041\u3043\u3045\u3047\u3049"
		src = !"\u3042\u3044\u3046\u3048\u3050"

		for i1 as integer = 0 to MAX
			for i2 as integer = 0 to MAX

				check_lset( dst, src, i1, i2 )
				check_rset( dst, src, i1, i2 )

			next i2
		next i1

	END_TEST

END_SUITE
