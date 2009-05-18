# include "fbcu.bi"

#define REMOVE_TEMP_FILE
'#define PRINT_IF_UNEQUAL

#define QT(s) ("""" & (s) & """")

#define PRINT_USING( fmt, num, cmp ) _
	print #(1), using ( QT(fmt) & ", " & QT("&") ); num; cmp

#define PRINT_USING_( fmt, num, cmp ) _
	print #(1), using ( QT(fmt) & ", " & QT("&") & ", "); num; cmp; : _
	print #(1), ,

#define HASHES(n) string(n, "#")
#define CARETS(n) string(n, "^")
#define DOT "."


#macro OPEN_FILE( fn )
	const TESTFILE = ("./string/" & fn)

	open TESTFILE for output as #1
#endmacro

#macro CLOSE_TEST_FILE()
	close #1

	dim as string sResult, sExpected
	open TESTFILE for input as #1
		do until eof(1)
			input #1, sResult, sExpected
#ifdef PRINT_IF_UNEQUAL
			if( sResult <> sExpected ) then
				print QT(sResult) & " <> " & QT(sExpected)
			end if
#endif
			CU_ASSERT_EQUAL( sResult, sExpected )
		loop
	close #1

#ifdef REMOVE_TEMP_FILE
	kill TESTFILE
#endif

#endmacro


namespace fbc_tests.string_.printusing

private sub test_ll( _
		byref fmt as string, _
		byval num as longint, _
		byref cmp as string)

	if num = cint(num) then
		PRINT_USING_( fmt & "%", cint(num), cmp & "%" )
	end if
	if num = cuint(num) then
		PRINT_USING_( fmt & "u", cuint(num), cmp & "u" )
	end if
	if cunsg(abs(num)) <= 1 shl 23 then
		PRINT_USING_( fmt & "_!", csng(num), cmp & "!" )
	end if
	if cunsg(abs(num)) <= 1ull shl 52 then
		PRINT_USING_( fmt & "_#", cdbl(num), cmp & "#" )
	end if
	if num >= 0 then
		PRINT_USING_( fmt & "ull", culngint(num), cmp & "ull" )
	end if

	PRINT_USING( fmt & "ll", num, cmp & "ll" )

end sub

private sub test_ull( _
		byref fmt as string, _
		byval num as ulongint, _
		byref cmp as string)

	if num < 1ull shl 31 then
		PRINT_USING_( fmt & "%", cint(num), cmp & "%" )
	end if
	if num < 1ull shl 32 then
		PRINT_USING_( fmt & "u", cuint(num), cmp & "u" )
	end if
	if num <= 1ull shl 23 then
		PRINT_USING_( fmt & "_!", cdbl(num), cmp & "!" )
	end if
	if num <= 1ull shl 52 then
		PRINT_USING_( fmt & "_#", cdbl(num), cmp & "#" )
	end if
	if num < 1ull shl 63 then
		PRINT_USING_( fmt & "ll", clngint(num), cmp & "ll" )
	end if

	PRINT_USING( fmt & "ull", num, cmp & "ull" )

end sub

private sub test_dbl( _
		byref fmt as string, _
		byval num as double, _
		byref cmp as string)

	PRINT_USING( fmt & "_#", num, cmp & "#" )

end sub

private sub test_dbl2( _
		byref fmt as string, _
		byval num as double, byval num2 as double, _
		byref cmp as string)

	PRINT_USING( fmt & "_#", num;num2, cmp & "#" )

end sub

private sub test_sng( _
		byref fmt as string, _
		byval num as single, _
		byref cmp as string)

	PRINT_USING( fmt & "_!", num, cmp & "!" )
	PRINT_USING( fmt & "_#", cdbl(num), cmp & "#" )

end sub

private sub test_str( _
		byref fmt as string, _
		byval s as string, _
		byref cmp as string)

	PRINT_USING( fmt & "_$", s, cmp & "$" )

end sub

private function pow_ull( byval m as ulongint, byval n as integer ) as ulongint

	dim as ulongint ret = 1ull

	for i as integer = 1 to n
		ret *= m
	next i

	return ret

end function

sub numtest cdecl ()

	dim num as double, num_ll as longint, num_ull as ulongint
	dim as string fmt, cmp
	dim as integer i, e

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


	'' test 2^-19 .. 2^63 (all fit within 20.20 digits without scaling)

	fmt = HASHES(20) & "." & HASHES(20)
	for i = -19 to 63

		if i >= 0 then
			cmp = (1ull shl i) & "."
		else
			cmp = "0." & right( string(30, "0") & pow_ull(5, -i), -i)
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
	test_dbl( fmt, 2 ^ 54,      "   18014398509481980.00000000000000000000" )


	fmt = HASHES(2) & "." & HASHES(18) & CARETS(4)

	'' test 2^-23 (double precision should cut off last '5' digit and round up from ...25 to ...30)
	test_dbl( fmt, 2 ^ -23, " 1.192092895507813000E-07" )

	'' test 2^-22 .. 2^0 in floating-point (should all fit within double precision digits)
	for i = -22 to 0
		num = 2 ^ i

		' construct negative power of 2 for cmp
		cmp = " " & pow_ull(5, -i)
		cmp = left(cmp, 2) & "." & mid(cmp, 3)
		e = len(fmt) - len(cmp) - 4
		cmp &= string(e, "0")
		cmp &= "E" & *iif(i - e + 18 < 0, @"-", @"+") & right("0" & abs(i-e+18), 2)

		test_dbl( fmt, num, cmp )
	next i

	'' check that values are scaled/stored without loss of precision
	'' (Doubles can't store odd numbers above 2^53=~.9e16)
	fmt = HASHES(17) & DOT & CARETS(3)
	test_dbl( fmt, 1e16 - 6, " 9999999999999994.E+0" )
	test_dbl( fmt, 1e15 -.5, " 9999999999999995.E-1" )
	test_dbl( fmt, 1e16 - 4, " 9999999999999996.E+0" )

	CLOSE_TEST_FILE()

end sub

sub fmttest cdecl ()

	OPEN_FILE( "print_using_fmttest.txt" )

	print #1, using "_##_"; 9;
	print #1, ",",   "#9_"

	print #1, using "#_"; 3; 1; 4;
	print #1, ",",  "3_1_4_"


	PRINT_USING( "&#&#.#&#^^^&&", _
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
	test_dbl2( "#.#,##", 1.2, 34, "1.2,34" )

	test_sng( ".##$", 0.01, ".01$" )
	test_sng( ".$$", 1, ".$1" )
	test_sng( ".#$", 0.1, ".1$" )
	test_sng( ".##", 0.01, ".01" )
	test_sng( ".##.", 0.01, ".01." )
	test_dbl2( ".##.#", 0.01, 0.2, ".01.2" )

	test_dbl2( "##$$", 1, 2, " 1$2" )
	test_dbl2( ".##$$", 0.01, 2, ".01$2" )

	test_dbl2( ".##$$", 0.01, 2, ".01$2" )


	test_dbl( "#", -.4, "-" )
	test_dbl( "##", -.4, "-0" )
	test_dbl( "+#", -.4, "-0" )
	test_dbl( "+#+", -.4, "-0+" )
	test_dbl( "+#-", -.4, "-0-" )
	test_dbl( "+#-", 0.4, "+0-" )

	test_dbl( "-###", 42, "- 42" )
	test_dbl( "+###", -42, " -42" )
	test_dbl( "+**#", +42, "*+42" )
	test_dbl( "+**$#", -99, "*-$99" )

	test_dbl( "+**$##.##^^^^", -1234.56e+78, "-$1234.56E+78" )
	test_dbl( "**$##.##^^^^+", -1234.56e+78, "$1234.56E+78-" )
	test_dbl( "**$##.##^^^^-",  1234.56e+78, "$1234.56E+78 " )
	test_dbl( "**$##.##+^^^^", -1234.56, "$1234.56-^^^^" )

	test_dbl(       "#-", 1,       "1 " )
	test_dbl(      "#^-", 1,      "1^-" )
	test_dbl(     "#^^-", 1,     "1^^-" )
	test_dbl(    "#^^^-", 1,    "1E+0 " )
	test_dbl(   "#^^^^-", 1,   "1E+00 " )
	test_dbl(  "#^^^^^-", 1,  "1E+000 " )
	test_dbl( "#^^^^^^-", 1, "1E+000^-" )

	CLOSE_TEST_FILE()

end sub

sub infnantest cdecl ()

	OPEN_FILE( "print_using_infnantest.txt" )

	dim as single one = 1.0, zero = 0.0

	#define MY_INF (one / zero)
	#define MY_NAN abs(zero / zero)

	test_sng( "+###",  MY_INF, "+INF" )
	test_sng( "+###", -MY_INF, "-INF" )

	test_sng( "+###",  MY_NAN, "+NAN" )
	test_sng( "+###", -MY_NAN, "-NAN" )

	CLOSE_TEST_FILE()

end sub

sub strtest cdecl ()

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

		if n < 1.e+16 then

			test_ll(  "&",  n, str(n) )
			test_dbl( "&",  n, str(n) )

			test_ll(  "&",      -n,  "-" & n )
			test_dbl( "&", -cdbl(n), "-" & n )

		else

			test_ull( "&", n, str(n) )
			test_dbl( "&", n, "1.E+" & i )


			if n < 1ull shl 63 then
				test_ll( "&", -n, "-" & n )
			end if
			test_dbl( "&", -cdbl(n), "-1.E+" & i )

		end if
		
		n *= 10

	next i

	test_dbl( "&", 1.0,     "1" )
	test_dbl( "&", 0.1,     "0.1" )
	test_dbl( "&", 0.01,    "0.01" )
	test_dbl( "&", 0.001,   "0.001" )
	test_dbl( "&", 0.0001,  "1.E-4" )
	test_dbl( "&", 0.00001, "1.E-5" )

	test_dbl( "&", 0.001234,   "0.001234" )
	test_dbl( "&", 0.0001234,  "1.234E-4" )

	test_dbl( "&", 1.E+15, "1" & string(15, "0") )
	test_dbl( "&", 1.E+16, "1.E+16" )

	test_dbl( "&", 1.234E+15, "1234" & string(15-3, "0") )
	test_dbl( "&", 1.234E+16, "1.234E+16" )

	test_dbl( "&", 1.E+99, "1.E+99" )
	test_dbl( "&", 1.E+100, "1.E+100" )

	CLOSE_TEST_FILE()

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.printusing")
	fbcu.add_test("number test", @numtest)
	fbcu.add_test("format parsing test", @fmttest)
	fbcu.add_test("inf/nan printing test", @infnantest)
	fbcu.add_test("string format test", @strtest)

end sub

end namespace
