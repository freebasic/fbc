# include "fbcunit.bi"

SUITE( fbc_tests.file_.large_int )

	const DEC_COUNT = 18
	const HEX_COUNT = 16
	const OCT_COUNT = 22
	const BIN_COUNT = 64
	const MISC_COUNT = 7 + 4 + 4 + 4*4 + 4

	const COUNT = DEC_COUNT * 4 + 4 + _
				  HEX_COUNT * 4 + (OCT_COUNT + BIN_COUNT) * 2 + _
				  MISC_COUNT

	dim shared as longint check(0 to COUNT-1)
	dim shared as integer check_misc(0 to MISC_COUNT-1) => { _
		3, 3, 63, 63, 63, 255, 255, _
		15, 15, 15, 15,         _
		123, 12, 34, 345,       _
		10, 200, 3000, 40000,   _
		10, 200, 3000, 40000,   _
		465, 722, 995, 1252,    _
		1, 2, 3, 4,             _
		1, 7, 15, 15 }

	'' !!! FIXME !!! - this needs to be an option to regenerate
#if 0
	sub generate_csv () constructor
		
		dim n as longint
		
		open "./file/large_int.csv" for output as #1
			
			''decimal
			n = 1
			for i as integer = 1 to DEC_COUNT
				write #1, n, -n, n * 10 - 1, 1 - n * 10
				n *= 10
			next i
			write #1, n, -n

			print #1,  "9223372036854775807" '' 1ull shl 63 - 1
			print #1, "-9223372036854775808" '' -1ll shl 63
			
			''hex
			n = 1
			for i as integer = 1 to HEX_COUNT
				print #1, "&h" & hex(n) & ", &h" & hex(n shl 3 - 1)
				print #1, "&h" & hex(n shl 3) & ", &h" & hex(n shl 4 - 1)
				n shl= 4
			next i
			
			''oct
			n = 1
			for i as integer = 1 to OCT_COUNT
				print #1, "&o" & oct(n) & ", &o" & oct(n shl 3 - 1)
				n shl= 3
			next i
			
			''bin
			n = 1
			for i as integer = 1 to BIN_COUNT
				print #1, "&b" & bin(n) & ", &b" & bin(n shl 1 - 1)
				n shl= 1
			next i
			
			''misc
			print #1, "&b11, &B11, &o77, &O77, &77, &hff, &HFF"  '' 3, 3, 63, 63, 63, 255, 255
			print #1, "&hf, &hF, &Hf, &HF"                  '' 15, 15, 15, 15
			
			print #1, "1.23d+2, 1.2D+1, 3.4e+1, 3.45E+2"    '' 123, 12, 34, 345
			
			print #1, "   1d1,    2D2,    3e3,    4E4"      '' 10, 200, 3000, 40000
			print #1, "  1.d1,   2.D2,   3.e3,   4.E4"      '' 10, 200, 3000, 40000
			print #1, " &h1d1,  &h2D2,  &h3e3,  &h4E4"      '' 465, 722, 995, 1252
			print #1, "&h1.d1, &h2.D2, &h3.e3, &h4.E4"      '' 1,  2,   3,    4
			
			print #1, "&b12, &o78, &hfg, &HFG"              '' 1, 7, 15, 15
			
		close #1
		
	end sub
#endif

	sub generate_check ()
		
		dim i as integer, j as integer, p as integer
		dim n as longint
		
		p = 0
		
		n = 1: for i as integer = 1 to DEC_COUNT
			check(p) = n:           p += 1
			check(p) = -n:          p += 1
			check(p) = 10 * n - 1:  p += 1
			check(p) = 1 - 10 * n:  p += 1
			n *= 10
		next i
		check(p) = n:   p += 1
		check(p) = -n:  p += 1

		check(p) = 1ull shl 63 - 1:  p += 1
		check(p) = -1ll shl 63:      p += 1
		
		n = 1: for i as integer = 1 to HEX_COUNT
			check(p) = n:           p += 1
			check(p) = n shl 3 - 1: p += 1
			check(p) = n shl 3:     p += 1
			check(p) = n shl 4 - 1: p += 1
			n shl= 4
		next i
		
		n = 1: for i as integer = 1 to OCT_COUNT
			check(p) = n:           p += 1
			check(p) = n shl 3 - 1: p += 1
			n shl= 3
		next i
		
		n = 1: for i as integer = 1 to BIN_COUNT
			check(p) = n:           p += 1
			check(p) = n shl 1 - 1: p += 1
			n shl= 1
		next i
		
		for i as integer = 0 to MISC_COUNT-1
			check(p) = check_misc(i): p += 1
		next i
		
	end sub

	TEST( run_test )

#macro TYPE_TEST( t )
		open "./file/large_int.csv" for input as #1
			for i as integer = 0 to COUNT-1
				dim n as t
				input #1, n
 #if #t = "single"
				CU_ASSERT_DOUBLE_EQUAL( check(i), n, check(i) \ 10000000 )
 #elseif #t = "double"
				CU_ASSERT_DOUBLE_EQUAL( check(i), n, check(i) \ 1000000000000000ll )
 #else
				if( clngint( cast( t, check(i) ) ) = check(i) ) then
					CU_ASSERT_EQUAL( check(i), clngint(n) )
				end if
 #endif
			next i
		close #1
#endmacro

		generate_check()

		TYPE_TEST(     byte )
		TYPE_TEST(    ubyte )
		TYPE_TEST(    short )
		TYPE_TEST(   ushort )
		TYPE_TEST(  integer )
		TYPE_TEST( uinteger )
		TYPE_TEST(     long )
		TYPE_TEST(    ulong )
		TYPE_TEST(  longint )
		TYPE_TEST( ulongint )
		TYPE_TEST(   single )
		TYPE_TEST(   double )

	END_TEST

END_SUITE
