#include "fbcunit.bi"
#include once "chk-wstring.bi"

#define BUFFERSIZE 50

'' fixed length strings are not cleared
'' and the garbage in the buffer will affect the tests
#macro INIT_FIXED_STRING( s, dtype, size, value )
	dim s as dtype * size
	clear s, 0, sizeof(s)
	s = value
#endmacro

SUITE( fbc_tests.wstring_.midstmt )

	#macro check_mid_start( dst, start, src, length1, length2 )
		scope
			INIT_FIXED_STRING( w1, wstring, BUFFERSIZE, left( dst, (length1) ) )
			INIT_FIXED_STRING( w2, wstring, BUFFERSIZE, left( src, (length2) ) )
			INIT_FIXED_STRING( e1, wstring, BUFFERSIZE, w1 )
			dim n1 as integer = BUFFERSIZE '' len(w1)
			dim n2 as integer = len(w2)
			dim idx1 as integer = start
			dim idx2 as integer = 1

			'' compute the expected string
			if( (n1 > 0) and (start >= 1) and (start <= n1) ) then
				while( idx1 >= 1 and idx1 <= n1 and idx2 >= 1 and idx2 <= n2 )
					e1[idx1-1] = w2[idx2-1]
					idx1 += 1
					idx2 += 1
				wend
				e1[n1-1] = 0
			end if

			mid( w1, start ) = w2

			CU_ASSERT_WSTRING_EQUAL( w1, e1 )
		end scope
	#endmacro

	#macro check_mid_start_n( dst, start, length, src, length1, length2 )
		scope
			INIT_FIXED_STRING( w1, wstring, BUFFERSIZE, left( dst, (length1) ) )
			INIT_FIXED_STRING( w2, wstring, BUFFERSIZE, left( src, (length2) ) )
			INIT_FIXED_STRING( e1, wstring, BUFFERSIZE, w1 )
			dim n1 as integer = BUFFERSIZE '' len(w1)
			dim n2 as integer = len(w2)
			dim idx1 as integer = start
			dim idx2 as integer = 1
			dim n as integer = 0

			'' compute the expected string
			if( (n1 > 0) and (start >= 1) and (start <= n1) ) then
				while( idx1 >= 1 and idx1 <= n1 and idx2 >= 1 and idx2 <= n2 and (n < length or length < 1) )
					e1[idx1-1] = w2[idx2-1]
					idx1 += 1
					idx2 += 1
					n += 1
				wend
				e1[n1-1] = 0
			end if

			mid( w1, start, length ) = w2

			CU_ASSERT_WSTRING_EQUAL( w1, e1 )
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
