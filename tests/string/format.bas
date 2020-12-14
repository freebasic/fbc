#include "fbcunit.bi"
# include "vbcompat.bi"

'' tests marked with "BUG" might be bugged on some platforms
#if ENABLE_CHECK_BUGS
	#define B1 1
	#define B2 1
#else
	'' inhibit some checks on win 64bit (typically mingw64)
	#if defined(__FB_WIN32__) and defined(__FB_64BIT__)
		#define B1 0
	#else
		#define B1 1
	#endif
	'' inhibit some checks on mingw-org, however, we can't
	'' tell the difference between mingw32 and mingw-org
	#if defined(__FB_WIN32__)
		#define B2 0
	#else
		#define B2 1
	#endif
#endif

enum test_flags
	TEST_AS_IS  = &H1
	TEST_NEG    = &H2
	TEST_SUFFIX = &H4
	TEST_NEGSUF = &H8
end enum

#macro FORMAT_TEST(value, mask, result, wanted)
	(result) = format( (value), (mask) )
	CU_ASSERT_EQUAL( (result), (wanted) )
#endmacro

tests_num:
	data &H3, 0.1236,    "",                 ".1236"
	'' The following example now works because FORMAT now restricts the precision to 11 when no format specifier was given.
	data &H3, 4578.1236, "",                 "4578.1236"
	data &H3, 4578.125,  "",                 "4578.125"
	data &H3, 1234.0,    "",                 "1234"

	data &HF, 0.1236,    "##0.00%",          "12.36%"
	data &H5, 123,       !"\"asd\\\"",        !"asd\\"
	data &H1, -123,      !"\"asd\\\"",        !"asd\\"
	data &H5, 0,         "###",              "0"
	data &HF, 123,       "###",              "123"
	data &HF, 123,       "###00000",         "00123"
	data &HF, 123,       "00000###",         "00000123"
	data &HF, 123.5,     "0",                "123"
	data &HF, 123.51,    "0",                "124"
	data &HF, 123.6,     "0",                "124"
	data &HF, 1.23,      "###.###",          "1.23"
	data &HF, 0.123,     "###.###",          ".123"
	data &HF, 0.1234,    "###.###",          ".123"
	data &HF, 0.1235,    "###.###",          ".123"
	data &HF, 0.12351,   "###.###",          ".124"
	data &HF, 0.1236,    "###.###",          ".124"
	data &HF, 123,       "###.###",          "123."
	data &HF, 123,       "#",                "123"
	data &HF, 123,       "#.##e-000",        "1.23e002"
	data &HF, 123,       "#.##e+000",        "1.23e+002"
	data &HF, 0.123,     "#.##e-000",        "1.23e-001"
	data &HF, 0.1234,    "#.##e-000",        "1.23e-001"
	data &HF, 0.1235,    "#.##e-000",        "1.23e-001"
	data &HF, 0.12351,   "#.##e-000",        "1.24e-001"
	data &HF, 0.1236,    "#.##e-000",        "1.24e-001"
	data &HF, 1.25e-10,  "#.##e-0",          "1.25e-10"
	data &HF, 0.999999,  "#.00e+000",        "1.00e+000"

	'' exponential with no fraction digits - decreasing exponents
	data &HF, 1.0e+21,   "#.e+#",            "1.e+21"
	data &HF, 1.0e+20,   "#.e+#",            "1.e+20"
	data &HF, 1.0e+19,   "#.e+#",            "1.e+19"
	data &HF, 1.0e+18,   "#.e+#",            "1.e+18"
	data &HF, 1.0e+17,   "#.e+#",            "1.e+17"
	data &HF, 1.0e+16,   "#.e+#",            "1.e+16"
	'' ...
	data &HF, 1.0e+4,    "#.e+#",            "1.e+4"
	data &HF, 1.0e+3,    "#.e+#",            "1.e+3"
	data &HF, 1.0e+2,    "#.e+#",            "1.e+2"

	data &HF, 3.0e+1,    "#.0e+#",           "3.0e+1"
	data &HF, 3.0e+1,    "#.e+#",            "3.e+1"
	data &HF, 3.0e+1,    "#e+#",             "3e+1"

	data &HF, 3.0e+1,    "##.0e+#",          "30.0e+0"
	data &HF, 3.0e+1,    "##.e+#",           "30.e+0"
	data &HF, 3.0e+1,    "##e+#",            "30e+0"

	data &HF, 1.0e+1,    "#.e+#",            "1.e+1"
	data &HF, 1.0e+0,    "#.e+#",            "1.e+0"
	data &HF, 1.0e-1,    "#.e+#",            "1.e-1"
	data &HF, 1.0e-2,    "#.e+#",            "1.e-2"

	'' exponential with fraction digit - decreasing exponents
	data &HF, 1.0e+4,    "###.0e+#",         "100.0e+2"
	data &HF, 1.0e+3,    "###.0e+#",         "100.0e+1"
	data &HF, 1.0e+2,    "###.0e+#",         "100.0e+0"
	data &HF, 1.0e+1,    "###.0e+#",         "100.0e-1"
	data &HF, 1.0e+0,    "###.0e+#",         "100.0e-2"
	data &HF, 1.0e-1,    "###.0e+#",         "100.0e-3"
	data &HF, 1.0e-2,    "###.0e+#",         "100.0e-4"

	'' exponential - 0 compared against 0.1
	data &HF, 0.1,       "##.00e+#",         "10.00e-2"
	data &H5, 0.0,       "##.00e+#",          "0.00e+0"

	data &H5, 0.0,       "#.0e+#",           "0.0e+0"
	data &HF, 0.1,       "#.0e+#",           "1.0e-1"
	data &H5, 0.0,       "##.0e+#",           "0.0e+0"
	data &HF, 0.1,       "##.0e+#",          "10.0e-2"
	data &H5, 0.0,       "###.0e+#",           "0.0e+0"
	data &HF, 0.1,       "###.0e+#",         "100.0e-3"


	data (B1 * &HF), 9.9e+20,   "#",                      "990000000000000000000"
	data (B2 * &HF), 4.9e-324,  "#.#e+#",                 "4.9e-324"
	data (B1 * &HF), 9.9e-100,  "###################e+#", "9900000000000000000e-118"

	'' Commas
	data &HF, 1234,      "###,0.00",         "1,234.00"
	data &HF, 1234567,   "#,#,#,0.00",       "1,234,567.00"
	data &H5, 1234,      "###,,0.00",        "0.00"
	data &HF, 1234567,   "###,,0.00",        "1.23"
	data &HF, 1234567,   "###0,,.00",        "1.23"
	data &HF, 1234,      "###0,.00",         "1.23"
	data &HF, 1234,      "#########,0.00",   "1,234.00"
	data &HF, 123456,    "#######,##0.00",   "123,456.00"
	data &HF, 12345678,  "#######,##0.00",   "12,345,678.00"
	data &HF, 123,       "#########,0.00",   "123.00"
	data &HF, 100000,    "#,##0.00",         "100,000.00"

	data &H0, "."

tests_dt:
    data "Jun 1, 2005",       "yyyy-mm-dd",       "2005-06-01"
    data "Jun 1, 2005",       "yyyy-MM-dd",       "2005-06-01"
    data "Jun 1, 2005",       "yy-MM-dd",         "05-06-01"
    data "Jun 1, 2005",       "yy-M-dd",          "05-6-01"
    data "Jun 1, 2005",       "yy-M-d",           "05-6-1"
    data "Dec 1, 2005",       "yy-M-d",           "05-12-1"
    data "Dec 10, 2005",      "yy-M-d",           "05-12-10"

    data "01:02:03",          "h:m:s",            "1:2:3"
    data "01:02:03",          "h:n:s",            "1:2:3"
    data "01:02:03",          "hh:mm:ss",         "01:02:03"
    data "01:02:03",          "hh:nn:ss",         "01:02:03"
    data "13:14:15",          "h:m:s",            "13:14:15"
    data "13:14:15",          "h:n:s",            "13:14:15"
    data "13:14:15",          "hh:mm:ss",         "13:14:15"
    data "13:14:15",          "hh:nn:ss",         "13:14:15"

    data "13:14:15",          "nn:ss",            "14:15"
    data "13:14:15",          "hh:mm:ss",         "13:14:15"
    data "13:14:15",          "hh:mm:ss AM/PM",   "01:14:15 PM"
    data "13:14:15",          "hh:mm:ss AM/pM",   "01:14:15 pM"
    data "13:14:15",          "hh:mm:ss A/p",     "01:14:15 p"
    data "01:14:15",          "hh:mm:ss A/p",     "01:14:15 A"
    data "00:14:15",          "hh:mm:ss A/p",     "12:14:15 A"
    data "12:14:15",          "hh:mm:ss A/p",     "12:14:15 p"
    data "Aug. 9, 2005",      "d dd ddd dddd ddddd",   "9 09 Tue Tuesday 08/09/2005"
    data "."

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as long )

SUITE( fbc_tests.string_.format_ )

	TEST( numberFormatTest )
		dim as string sValue, sMask, sWanted, sResult
		dim as double dblValue
		dim as integer bTest

		restore tests_num
		read bTest, sValue

		while sValue<>"."
			dblValue = val(sValue)
			read sMask, sWanted

			if( bTest and TEST_AS_IS ) then
				FORMAT_TEST( dblValue, sMask, sResult, sWanted )
			end if

			if( bTest and TEST_NEG ) then
				FORMAT_TEST( -dblValue, sMask, sResult, "-" & sWanted )
			end if

			if( bTest and TEST_SUFFIX ) then
				FORMAT_TEST( dblValue, sMask & "-", sResult, sWanted )
			end if

			if( bTest and TEST_NEGSUF ) then
				FORMAT_TEST( -dblValue, sMask & "-", sResult, sWanted & "-" )
			end if

			read bTest, sValue
		wend

	END_TEST

	TEST( dateFormatTest )
		dim as string sValue, sMask, sWanted, sResult
		dim as double dblValue

		restore tests_dt
		read sValue
		while sValue<>"."
			dblValue = datevalue(sValue) + timevalue(sValue)
			read sMask, sWanted

			FORMAT_TEST( dblValue, sMask, sResult, sWanted )

			read sValue
		wend

		CU_ASSERT( len( format(now(), "yyyy.mm.dd") ) > 0 )
	END_TEST

	SUITE_INIT
		' Turn off I18N and L10N
		fb_I18nSet 0
		'' return success
		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
		' Turn on I18N and L10N
		fb_I18nSet 1
		'' return success
		return 0
	END_SUITE_CLEANUP


END_SUITE
