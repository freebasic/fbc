# include "fbcu.bi"
# include "vbcompat.bi"

tests_num:
	data 0.1236,    "",                 ".1236"
' The following example now works because FORMAT now restricts the precision
' to 11 when no format specifier was given.
	data 4578.1236, "",                 "4578.1236"
	data 4578.125,  "",                 "4578.125"
	data 1234.0,    "",                 "1234"

	data 0.1236,    "##0.00%",          "12.36%"
    data 123,       !"\"asd\\\"",        !"asd\\"
	data 0,         "###",              "0"
	data 123,       "###",              "123"
	data 123,       "###00000",         "00123"
	data 123,       "00000###",         "00000123"
	data 123.5,     "0",                "123"
	data 123.51,    "0",                "124"
	data 123.6,     "0",                "124"
	data 1.23,      "###.###",          "1.23"
	data 0.123,     "###.###",          ".123"
	data 0.1234,    "###.###",          ".123"
	data 0.1235,    "###.###",          ".123"
	data 0.12351,   "###.###",          ".124"
	data 0.1236,    "###.###",          ".124"
	data 123,       "###.###",          "123."
	data 123,       "#",                "123"
	data 123,       "#.##e-000",        "1.23e002"
	data 123,       "#.##e+000",        "1.23e+002"
	data 0.123,     "#.##e-000",        "1.23e-001"
	data 0.1234,    "#.##e-000",        "1.23e-001"
	data 0.1235,    "#.##e-000",        "1.23e-001"
	data 0.12351,   "#.##e-000",        "1.24e-001"
	data 0.1236,    "#.##e-000",        "1.24e-001"
	data 0.000000000125,                "#.##e-0",          "1.25e-10"
	data 0.999999,  "#.00e+000",        "1.00e+000"

	data -0.1236,   "##0.00%",          "-12.36%"
    data -123,      !"\"asd\\\"",        !"asd\\"
	data -0,        "###",              "0"
	data -123,      "###",              "-123"
	data -123,      "###00000",         "-00123"
	data -123,      "00000###",         "-00000123"
	data -123.5,    "0",                "-123"
	data -123.51,   "0",                "-124"
	data -123.6,    "0",                "-124"
	data -1.23,     "###.###",          "-1.23"
	data -0.123,    "###.###",          "-.123"
	data -0.1234,   "###.###",          "-.123"
	data -0.1235,   "###.###",          "-.123"
	data -0.12351,  "###.###",          "-.124"
	data -0.1236,   "###.###",          "-.124"
	data -123,      "###.###",          "-123."
	data -123,      "#",                "-123"
	data -123,      "#.##e-000",        "-1.23e002"
	data -123,      "#.##e+000",        "-1.23e+002"
	data -0.123,    "#.##e-000",        "-1.23e-001"
	data -0.1234,   "#.##e-000",        "-1.23e-001"
	data -0.1235,   "#.##e-000",        "-1.23e-001"
	data -0.12351,  "#.##e-000",        "-1.24e-001"
	data -0.1236,   "#.##e-000",        "-1.24e-001"
	data -0.000000000125,               "#.##e-0",          "-1.25e-10"
	data -0.999999, "#.00e+000",        "-1.00e+000"

	data -0.1236,   "##0.00%-",         "12.36%-"
    data -123,      !"\"asd\\\"",        !"asd\\"
	data -0,        "###-",             "0"
	data -123,      "###-",             "123-"
	data -123,      "###00000-",        "00123-"
	data -123,      "00000###-",        "00000123-"
	data -123.5,    "0-",               "123-"
	data -123.51,   "0-",               "124-"
	data -123.6,    "0-",               "124-"
	data -1.23,     "###.###-",         "1.23-"
	data -0.123,    "###.###-",         ".123-"
	data -0.1234,   "###.###-",         ".123-"
	data -0.1235,   "###.###-",         ".123-"
	data -0.12351,  "###.###-",         ".124-"
	data -0.1236,   "###.###-",         ".124-"
	data -123,      "###.###-",         "123.-"
	data -123,      "#-",               "123-"
	data -123,      "#.##e-000-",       "1.23e002-"
	data -123,      "#.##e+000-",       "1.23e+002-"
	data -0.123,    "#.##e-000-",       "1.23e-001-"
	data -0.1234,   "#.##e-000-",       "1.23e-001-"
	data -0.1235,   "#.##e-000-",       "1.23e-001-"
	data -0.12351,  "#.##e-000-",       "1.24e-001-"
	data -0.1236,   "#.##e-000-",       "1.24e-001-"
	data -0.000000000125,               "#.##e-0-",          "1.25e-10-"
	data -0.999999, "#.00e+000-",       "1.00e+000-"

	data 0.1236,    "##0.00%-",         "12.36%"
    data 123,       !"\"asd\\\"",        !"asd\\"
	data 0,         "###-",             "0"
	data 123,       "###-",             "123"
	data 123,       "###00000-",        "00123"
	data 123,       "00000###-",        "00000123"
	data 123.5,     "0-",               "123"
	data 123.51,    "0-",               "124"
	data 123.6,     "0-",               "124"
	data 1.23,      "###.###-",         "1.23"
	data 0.123,     "###.###-",         ".123"
	data 0.1234,    "###.###-",         ".123"
	data 0.1235,    "###.###-",         ".123"
	data 0.12351,   "###.###-",         ".124"
	data 0.1236,    "###.###-",         ".124"
	data 123,       "###.###-",         "123."
	data 123,       "#-",               "123"
	data 123,       "#.##e-000-",       "1.23e002"
	data 123,       "#.##e+000-",       "1.23e+002"
	data 0.123,     "#.##e-000-",       "1.23e-001"
	data 0.1234,    "#.##e-000-",       "1.23e-001"
	data 0.1235,    "#.##e-000-",       "1.23e-001"
	data 0.12351,   "#.##e-000-",       "1.24e-001"
	data 0.1236,    "#.##e-000-",       "1.24e-001"
	data 0.000000000125,                "#.##e-0-",          "1.25e-10"
	data 0.999999,  "#.00e+000-",       "1.00e+000"

	data 1234,      "###,0.00",         "1,234.00"
	data 1234567,   "#,#,#,0.00",       "1,234,567.00"
	data 1234,      "###,,0.00",        "0.00"
	data 1234567,   "###,,0.00",        "1.23"
	data 1234567,   "###0,,.00",        "1.23"
	data 1234,      "###0,.00",         "1.23"
	data 1234,      "#########,0.00",   "1,234.00"
	data 123456,    "#######,##0.00",   "123,456.00"
	data 12345678, 	"#######,##0.00",   "12,345,678.00"
	data 123,       "#########,0.00",   "123.00"

    data "."

tests_dt:
    data "Jun 1, 2005",       "yyyy-mm-dd",       "2005-06-01"
    data "Jun 1, 2005",       "yyyy-MM-dd",       "2005-06-01"
    data "Jun 1, 2005",       "yy-MM-dd",         "05-06-01"
    data "Jun 1, 2005",       "yy-M-dd",          "05-6-01"
    data "Jun 1, 2005",       "yy-M-d",           "05-6-1"
    data "Dec 1, 2005",       "yy-M-d",           "05-12-1"
    data "Dec 10, 2005",      "yy-M-d",           "05-12-10"
    data "13:14:15",          "hh:nn:ss",         "13:14:15"
    data "13:14:15",          "nn:ss",            "14:15"
    data "13:14:15",          "hh:mm:ss",         "13:14:15"
    data "13:14:15",          "hh:mm:ss AM/PM",   "01:14:15 PM"
    data "13:14:15",          "hh:mm:ss AM/pM",   "01:14:15 pM"
    data "13:14:15",          "hh:mm:ss A/p",     "01:14:15 p"
    data "01:14:15",          "hh:mm:ss A/p",     "01:14:15 A"
    data "00:14:15",          "hh:mm:ss A/p",     "12:14:15 A"
    data "12:14:15",          "hh:mm:ss A/p",     "12:14:15 p"
    data "Aug. 9, 2005",      "ddd dddd ddddd",   "Tue Tuesday 08/09/2005"
    data "."

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as long )

namespace fbc_tests.string_.format_

sub numberFormatTest cdecl ()
	dim as string sValue, sMask, sWanted, sResult
	dim as double dblValue

	restore tests_num
	read sValue
	while sValue<>"."
	    dblValue = val(sValue)
	    read sMask, sWanted
'        print sWanted,
	    sResult = Format(dblValue, sMask)
'        print sResult
        CU_ASSERT_EQUAL( sWanted, sResult )
        read sValue
	wend

end sub

sub dateFormatTest cdecl ()
	dim as string sValue, sMask, sWanted, sResult
	dim as double dblValue

	restore tests_dt
	read sValue
	while sValue<>"."
	    dblValue = datevalue(sValue) + timevalue(sValue)
	    read sMask, sWanted
'        print sWanted,
	    sResult = Format(dblValue, sMask)
'        print sResult
        CU_ASSERT_EQUAL( sWanted, sResult )
        read sValue
	wend

	CU_ASSERT( len( format(now(), "yyyy.mm.dd") ) > 0 )
end sub

function init cdecl () as long
	' Turn off I18N and L10N
	fb_I18nSet 0
	return 0
end function

function cleanup cdecl () as long
	' Turn on I18N and L10N
	fb_I18nSet 1
	return 0
end function

sub ctor () constructor
	fbcu.add_suite("fbc_tests.string_.format_", @init, @cleanup)
	fbcu.add_test("number format test", @numberFormatTest)
	fbcu.add_test("date format test", @dateFormatTest)
end sub

end namespace
