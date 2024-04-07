#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED_MUTABLE

#define BUFFERSIZE 50

'' fixed length strings are not cleared
'' and the garbage in the buffer will affect the tests
#macro INIT_FIXED_STRING( s, dtype, size, value )
	dim s as dtype * size
	clear s, 0, sizeof(s)
	s = value
#endmacro

SUITE( fbc_tests.udt_wstring_.midstmt )

	'' we already test MID statment in ../wstring/midstmt.bas
	'' just compare that we get same results

	#macro check_mid_start( dst, start, src, length1, length2 )
		scope
			INIT_FIXED_STRING( w1, wstring, BUFFERSIZE, left( dst, (length1) ) )
			INIT_FIXED_STRING( w2, wstring, BUFFERSIZE, left( src, (length2) ) )
			mid( w1, start ) = w2

			dim u1 as ustring = w1
			mid( u1, start ) = w2

			dim r1 as wstring * BUFFERSIZE = u1
			CU_ASSERT_WSTRING_EQUAL( w1, r1 )
		end scope
	#endmacro

	#macro check_mid_start_n( dst, start, length, src, length1, length2 )
		scope
			INIT_FIXED_STRING( w1, wstring, BUFFERSIZE, left( dst, (length1) ) )
			INIT_FIXED_STRING( w2, wstring, BUFFERSIZE, left( src, (length2) ) )
			mid( w1, start, length ) = w2

			dim u1 as ustring = w1
			dim u2 as ustring = w2
			mid( u1, start, length ) = w2

			dim r1 as wstring * BUFFERSIZE = u1
			CU_ASSERT_WSTRING_EQUAL( w1, r1 )
		end scope
	#endmacro

	TEST( ascii )
		const MAX = 8

		#define def_dst "12345678"
		#define def_src "ABCDEFGH"

		dim dst as wstring * (MAX*2+1)
		dim src as wstring * (MAX*2+1)

		for i1 as integer = 0 to MAX
			for i2 as integer = 0 to MAX
				for istart as integer = -2 to MAX+2

					dst = def_src
					src = def_dst

					check_mid_start( dst, istart, src, i1, i2 )

					for length as integer = -2 to MAX+2

						dst = def_src
						src = def_dst

						check_mid_start_n( dst, istart, length, src, i1, i2 )
					next

				next
			next i2
		next i1

	END_TEST

	TEST( ucs2 )
		const MAX = 5

		#define def_dst !"\u3041\u3043\u3045\u3047\u3049"
		#define def_src !"\u3042\u3044\u3046\u3048\u3050"

		dim dst as wstring * (MAX*2+1)
		dim src as wstring * (MAX*2+1)

		for i1 as integer = 0 to MAX
			for i2 as integer = 0 to MAX
				for istart as integer = -1 to MAX+2

					dst = def_src
					src = def_dst

					check_mid_start( dst, istart, src, i1, i2 )

					for length as integer = -2 to MAX+2

						dst = def_src
						src = def_dst

						check_mid_start_n( dst, istart, length, src, i1, i2 )
					next

				next
			next i2
		next i1

	END_TEST

END_SUITE
