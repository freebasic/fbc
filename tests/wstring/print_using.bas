#include "fbcunit.bi"

#ifndef ENABLE_CHECK_BUGS
#define ENABLE_CHECK_BUGS 0
#endif

#define PRINT_IF_UNEQUAL

#define BUFFER_SIZE 50

#define QT(s) wstr("""" & wstr(s) & """")

'' last output on a line wrapper
#define PRINT_USING_N( fmt, num, cmp ) _
	print #(1), using ( QT(fmt) & ", " & QT("&") ); num; wstr(cmp)

'' continuing output on a line wrapper
#define PRINT_USING_1( fmt, num, cmp ) _
	print #(1), using ( QT(fmt) & ", " & QT("&") & ", "); num; wstr(cmp); : _
	print #(1), ,

#define HASHES(n) wstring(n, asc("#"))
#define CARETS(n) wstring(n, asc("^"))
#define DOT "."


#macro OPEN_FILE( fn )
	const TESTFILE = ("./wstring/" & fn)

	open TESTFILE for output encoding "utf-16" as #1
#endmacro

#macro CLOSE_AND_TEST_FILE()
	close #1

	dim as wstring * BUFFER_SIZE sResult, sExpected
	dim as integer errcount = 0
	open TESTFILE for input encoding "utf-16" as #1
		do until eof(1)
			input #1, sResult, sExpected
			if( sResult <> sExpected ) then
#ifdef PRINT_IF_UNEQUAL
				print QT(sResult) & " <> " & QT(sExpected)
				errcount += 1
#endif
			end if
			CU_ASSERT_EQUAL( sResult, sExpected )
		loop
	close #1

	if errcount = 0 then
		kill TESTFILE
	end if
#endmacro


SUITE( fbc_tests.wstring_.print_using )

	private sub test_ll( _
			byref fmt as wstring, _
			byval num as longint, _
			byref cmp as wstring, _
			byval do_fp as integer = 1)

		if num = clng(num) then
			PRINT_USING_1( fmt & "%", clng(num), cmp & "%" )
		end if
		if num = culng(num) then
			PRINT_USING_1( fmt & "u", culng(num), cmp & "u" )
		end if
		if cunsg(abs(num)) <= 1 shl 23 then
			PRINT_USING_1( fmt & "_!", csng(num), cmp & "!" )
		end if
		if do_fp andalso cunsg(abs(num)) <= 1ull shl 52 then
			PRINT_USING_1( fmt & "_#", cdbl(num), cmp & "#" )
		end if
		if num >= 0 then
			PRINT_USING_1( fmt & "ull", culngint(num), cmp & "ull" )
		end if

		if num = cint(cbool(num)) and (instr(fmt, "&") = 0) then
			PRINT_USING_1( fmt & "b", num, cmp & "b" )
		end if

		PRINT_USING_N( fmt & "ll", num, cmp & "ll" )

	end sub

	private sub test_ull( _
			byref fmt as wstring, _
			byval num as ulongint, _
			byref cmp as wstring, _
			byval do_fp as integer = 1)

		if num < 1ull shl 31 then
			PRINT_USING_1( fmt & "%", clng(num), cmp & "%" )
		end if
		if num < 1ull shl 32 then
			PRINT_USING_1( fmt & "u", culng(num), cmp & "u" )
		end if
		if num <= 1ull shl 23 then
			PRINT_USING_1( fmt & "_!", cdbl(num), cmp & "!" )
		end if
		if do_fp andalso num <= 1ull shl 52 then
			PRINT_USING_1( fmt & "_#", cdbl(num), cmp & "#" )
		end if
		if num < 1ull shl 63 then
			PRINT_USING_1( fmt & "ll", clngint(num), cmp & "ll" )
		end if

		PRINT_USING_N( fmt & "ull", num, cmp & "ull" )

	end sub

	private sub test_dbl( _
			byref fmt as wstring, _
			byval num as double, _
			byref cmp as wstring)

		PRINT_USING_N( fmt & "_#", num, cmp & "#" )

	end sub

	private sub test_sng2( _
			byref fmt as wstring, _
			byval num as single, byval num2 as single, _
			byref cmp as wstring)

		PRINT_USING_N( fmt & "_!", csng(num);csng(num2), cmp & "!" )

	end sub

	private sub test_sng( _
			byref fmt as wstring, _
			byval num as double, _
			byref cmp as wstring, _
			byval do_dbl as integer = 1)

		'' note: num is a Double to prevent
		'' decimal vals getting corrupted in Double test

		PRINT_USING_N( fmt & "_!", csng(num), cmp & "!" )
		if( do_dbl ) then
			PRINT_USING_N( fmt & "_#", cdbl(num), cmp & "#" )
		end if

	end sub

	private sub test_str( _
			byref fmt as wstring, _
			byref s as wstring, _
			byref cmp as wstring)

		PRINT_USING_N( fmt & "_$", s, cmp & "$" )

	end sub

	private sub test_bool( _
			byref fmt as wstring, _
			byref num as boolean, _
			byref cmp as wstring)

		if instr(fmt, "&") then
			'' test true/false
			PRINT_USING_N( fmt & "b", iif(num, "true", "false"), cmp & "b" )
		else
			test_ll( fmt, clngint(num), cmp )
		end if

	end sub

	private function pow_ull( byval m as ulongint, byval n as integer ) as ulongint

		dim as ulongint ret = 1ull

		for i as integer = 1 to n
			ret *= m
		next i

		return ret

	end function

	'' statement parsing test
	TEST( stmttest )
		OPEN_FILE( "print_using_stmttest.txt" )

		print #1, "abc, abc"
		print #1, using "&"; "def, def"

		print #1, "ghi"; ", "; using "&"; "ghi"

		print #1, """a"; spc(5); "b"", "; using """&&"""; "a"; spc(5); "b"

		print #1, """a"; tab(10); "b"""
		print #1, using """&&"""; "a"; tab(10); "b"

	#if 0
		print #1,           """"; "a", "b"; """"
		print #1, using """&&"""; "a", "b"

		print #1,               """a", , "b"""
		print #1, using """&&"""; "a", , "b"
	#endif

		CLOSE_AND_TEST_FILE()
	END_TEST

	'' number test
	TEST( numtest )

		dim num as double, num_ll as longint, num_ull as ulongint
		dim as wstring * BUFFER_SIZE fmt, cmp
		dim as integer i, e
		dim as single s

		OPEN_FILE( "print_using_numtest.txt" )

		'' test 1, 12, 123, ... 1234567890124567890 (20 digs)

		test_ull( "#", 0, "0" )

		fmt = "": cmp = "": num_ull = 0
		for i = 1 to 20
			num_ull = num_ull * 10 + i mod 10

			fmt &= "#"
			cmp &= i mod 10

			test_ull( fmt, num_ull, cmp )
		next i

		'' Test that Singles can get double precision (except with "&")
		'' (Note that a Single can easily store 2^-10 without loss of precision)
		test_sng2( "#.##########, &", 2^-10, 2^-10, "0.0009765625, 9.765625E-4" )

		'' test 2^-19 .. 2^63 (all fit within 20.20 digits without scaling)

		fmt = HASHES(20) & "." & HASHES(20)
		for i = -19 to 63

			if i >= 0 then
				cmp = (1ull shl i) & "."
			else
				cmp = "0." & right( wstring(30, asc("0")) & pow_ull(5, -i), -i)
			end if
			while instr(cmp, ".") < instr(fmt, "."): cmp = " " & cmp: wend
			while len(cmp) < len(fmt):               cmp = cmp & "0": wend

			if i >= 0 then
				num_ull = 1ull shl i
				test_ull( fmt, num_ull, cmp )
				if num_ull <= 1ull shl 63 then
					test_ll( fmt & "-", -csign(num_ull), cmp & "-" )
				end if
			else
				num = 2 ^ i
				test_dbl( fmt, num, cmp )
			end if
		next i

		'' test 1ull shl 54, 2^54 (double precision should cut off last digit on 2^54)
		test_ull( fmt, 1ull shl 54, "   18014398509481984.00000000000000000000" )
		test_sng( fmt, 2 ^ 54,      "   18014398509481980.00000000000000000000" )


		fmt = HASHES(2) & "." & HASHES(18) & CARETS(4)

		'' test 2^-23 (double precision should cut off last '5' digit and round up from ...25 to ...30)
		'' (Use a Single value here because Linux
		'' doesn't seem to emit decimal 2^-23 accurately for Doubles)
		s = 2^-23
		test_sng( fmt, s, " 1.192092895507813000E-07" )

		'' test 2^-22 .. 2^0 in floating-point (should all fit within double precision digits)
		for i = -22 to 0
			num = 2 ^ i

			' construct negative power of 2 for cmp
			cmp = " " & pow_ull(5, -i)
			cmp = left(cmp, 2) & "." & mid(cmp, 3)
			e = len(fmt) - len(cmp) - 4
			cmp &= wstring(e, asc("0"))
			cmp &= "E" & *iif(i - e + 18 < 0, @"-", @"+") & right("0" & abs(i-e+18), 2)

			test_sng( fmt, num, cmp )
		next i

		'' check that values are scaled/stored without loss of precision
		'' (Doubles can't store odd numbers above 2^53=~.9e16)
		fmt = HASHES(17) & DOT & CARETS(3)
		test_dbl( fmt, 1e16 - 6, " 9999999999999994.E+0" )
		test_dbl( fmt, 1e15 -.5, " 9999999999999995.E-1" )
		test_dbl( fmt, 1e16 - 4, " 9999999999999996.E+0" )

		CLOSE_AND_TEST_FILE()

	END_TEST

	'' format parsing test
	TEST( fmttest )

		OPEN_FILE( "print_using_fmttest.txt" )

		print #1, using "_##_"; 9;
		print #1, ",",   "#9_"

		print #1, using "#_"; 3; 1; 4;
		print #1, ",",  "3_1_4_"


		PRINT_USING_N( "&#&#.#&#^^^&&", _
					 1; 2; 3; 4.0; 5; 6E+0; 7; 8, _
					 "1234.056E+078" )

		test_ll( "$ #" , 1, "$ 1" )
		test_ll( "* #" , 1, "* 1" )
		test_ll( "*##" , 1, "* 1" )
		test_ll( "*$ #", 1, "*$ 1" )

		test_ll( "$$" , 1, "$1" )
		test_ll( "**" , 1, "*1" )
		test_ll( "**####" , 123, "***123" )
		test_ll( "**$", 1, "*$1" )

		test_ll(  "**$####" , 456, "***$456" )
		test_ll( "+**$####" , 456, "***+$456" )

		test_ll( "$$$" , 1, "$1$" )
		test_ll( "***" , 1, "*1*" )
		test_ll( "***$", 1, "*1*$" )
		test_ll( "**$$", 1, "*$1$" )

		test_ll( ",#####" , 1234, ", 1234" )
		test_ll( "#,####" , 1234, " 1,234" )
		test_ll( "#####," , 1234, " 1,234" )
		test_ll( "#####.,", 1234, " 1234.," )
		test_ll( "#,###.^^^^", 1234, " 1234.E+00" )
		test_sng2( "#.#,##", 1.2, 34, "1.2,34" )

		test_sng( ".##$", 0.01, ".01$" )
		test_sng( ".$$", 1, ".$1" )
		test_sng( ".#$", 0.1, ".1$" )
		test_sng( ".##", 0.01, ".01" )
		test_sng( ".##.", 0.01, ".01." )
		test_sng2( ".##.#", 0.01, 0.2, ".01.2" )

		test_sng2( "##$$", 1, 2, " 1$2" )
		test_sng2( ".##$$", 0.01, 2, ".01$2" )

		test_sng2( ".##$$", 0.01, 2, ".01$2" )


		test_sng( "#", -.4, "-" )
		test_sng( "##", -.4, "-0" )
		test_sng( "+#", -.4, "-0" )
		test_sng( "+#+", -.4, "-0+" )
		test_sng( "+#-", -.4, "-0-" )
		test_sng( "+#-", 0.4, "+0-" )

		test_sng( "-###", 42, "- 42" )
		test_sng( "+###", -42, " -42" )
		test_sng( "+**#", +42, "*+42" )
		test_sng( "+**$#", -99, "*-$99" )

		test_sng( "+**$##.##^^^^", -1234.56e+12, "-$1234.56E+12" )
		test_sng( "**$##.##^^^^+", -1234.56e+12, "$1234.56E+12-" )
		test_sng( "**$##.##^^^^-",  1234.56e+12, "$1234.56E+12 " )
		test_sng( "**$##.##+^^^^", -1234.56, "$1234.56-^^^^" )

		test_sng(       "#-", 1,       "1 " )
		test_sng(      "#^-", 1,      "1^-" )
		test_sng(     "#^^-", 1,     "1^^-" )
		test_sng(    "#^^^-", 1,    "1E+0 " )
		test_sng(   "#^^^^-", 1,   "1E+00 " )
		test_sng(  "#^^^^^-", 1,  "1E+000 " )
		test_sng( "#^^^^^^-", 1, "1E+000^-" )

		CLOSE_AND_TEST_FILE()

	END_TEST

	'' inf/nan/ind printing test
	TEST( infnanindtest )

		OPEN_FILE( "print_using_infnantest.txt" )

		dim as single one = 1.0, zero = 0.0
		dim as single inf = one / zero
		dim as single ind = inf - inf
		dim as single nan = cvs(mki(&h7f800001))

		dim as wstring * BUFFER_SIZE fmt = "+#.####"

		test_sng( fmt,  inf, "+1.#INF" )
		test_sng( fmt, -inf, "-1.#INF" )

		test_sng( fmt,  nan, "+1.#NAN" )
		test_sng( fmt, -nan, "-1.#NAN" )

		'' arm targets only return NAN instead of IND? and different signs??
		#if not defined( __FB_ARM__ ) or ( ENABLE_CHECK_BUGS <> 0 )

		test_sng( fmt, ind, "-1.#IND" )

		test_sng( "&",  inf,  "1.#INF" )
		test_sng( "&", -inf, "-1.#INF" )

		test_sng( "&", ind,        "-1.#IND" )
		test_sng( "#.####", ind,  "%-1.#IND" )
		test_sng( "##.####", ind,  "-1.#IND" )

		test_sng( "##.###",  ind, "%-1.$00" )
		test_sng( "##.##",  ind,  "%-1.$0" )
		test_sng( "##.#",  ind,   "%-1.$" )
		test_sng( "##.",  ind,    "%-1." )
		test_sng( "##",  ind,     "%-1" )

		#endif

		CLOSE_AND_TEST_FILE()

	END_TEST

	'' wstring format test
	TEST( strtest )

		OPEN_FILE( "print_using_strtest.txt" )

		dim i as integer, n as ulongint

		test_str( "&", "Test", "Test" )
		test_str( "!",     "Test", "T" )
		test_str( "\\",    "Test", "Te" )
		test_str( "\ \",   "Test", "Tes" )
		test_str( "\  \",  "Test", "Test" )
		test_str( "\   \", "Test", "Test " )

		test_str( "!",   "", " " )
		test_str( "\\",  "", "  " )
		test_str( "\ \", "", "   " )

		test_ll( "&", 0, "0" )

		n = 1
		for i = 0 to 19

			if n < 1.e+7 then

				test_ll(  "&",  n, str(n) )
				test_sng( "&",  n, str(n) )

				test_ll(  "&",      -n,  "-" & n )

			elseif n < 1.e+16 then

				test_ll(  "&",  n, str(n) )
				test_dbl( "&",  n, str(n) )

				test_ll(  "&",      -n,  "-" & n )
				test_dbl( "&", -cdbl(n), "-" & n )

				test_dbl( "&", -cdbl(n), "-" & n )

			else

				test_ull( "&", n, str(n) )
				test_sng( "&", n, "1.E+" & i )


				if n < 1ull shl 63 then
					test_ll( "&", -n, "-" & n )
				end if
				test_sng( "&", -cdbl(n), "-1.E+" & i )

			end if

			n *= 10

		next i

		test_sng( "&", 1.0,     "1" )
		test_sng( "&", 0.1,     "0.1" )
		test_sng( "&", 0.01,    "0.01" )
		test_sng( "&", 0.001,   "0.001" )
		test_sng( "&", 0.0001,  "1.E-4" )
		test_sng( "&", 0.00001, "1.E-5" )

		test_sng( "&", 0.001234,   "0.001234" )
		test_sng( "&", 0.0001234,  "1.234E-4" )

		test_sng( "&", 1.E+6, "1000000", 0 )
		test_sng( "&", 1.E+7, "1.E+7", 0 )
		test_dbl( "&", 1.E+15, "1" & wstring(15, asc("0")) )
		test_dbl( "&", 1.E+16, "1.E+16" )

		test_sng( "&", 1.234E+6, "1234000", 0 )
		test_sng( "&", 1.234E+7, "1.234E+7", 0 )
		test_dbl( "&", 1.234E+15, "1234" & wstring(15-3, asc("0")) )
		test_dbl( "&", 1.234E+16, "1.234E+16" )

		test_sng( "&", 1.E-9, "1.E-9", 0 )
		test_sng( "&", 1.E-10, "1.E-10", 0 )
		test_sng( "&", 1.E+9, "1.E+9", 0 )
		test_sng( "&", 1.E+10, "1.E+10", 0 )

		test_dbl( "&", 1.E-99, "1.E-99" )
		test_dbl( "&", 1.E-100, "1.E-100" )
		test_dbl( "&", 1.E+99, "1.E+99" )
		test_dbl( "&", 1.E+100, "1.E+100" )

		CLOSE_AND_TEST_FILE()

	END_TEST

	'' boolean test
	TEST( booltest )

		OPEN_FILE( "print_using_booltest.txt" )

		test_bool("&", false, "false")
		test_bool("&", true,  "true")

		test_bool("+#", false, "+0")
		test_bool("+#", true,  "-1")

		test_bool("#", false, "0")
		test_bool("#", true,  "%-1")

		CLOSE_AND_TEST_FILE()

	END_TEST

END_SUITE
