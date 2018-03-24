# include once "fbcunit.bi"
# include once "vbcompat.bi"

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as long )

tests_datepart:
	DATA "Jan 1, 2006 12:13:14", "yyyy",  2006
	DATA "Jan 1, 2006 12:13:14", "q",     1
	DATA "Jan 1, 2006 12:13:14", "m",     1
	DATA "Jan 1, 2006 12:13:14", "y",     1
	DATA "Jan 1, 2006 12:13:14", "d",     1
	DATA "Jan 1, 2006 12:13:14", "w",     7
	DATA "Jan 1, 2006 12:13:14", "ww",    52
	DATA "Jan 1, 2006 12:13:14", "h",     12
	DATA "Jan 1, 2006 12:13:14", "n",     13
	DATA "Jan 1, 2006 12:13:14", "s",     14
	DATA "May 4, 2006 12:13:14", "q",     2
	DATA "May 4, 2006 12:13:14", "m",     5
	DATA "May 4, 2006 12:13:14", "y",     124
	DATA "May 4, 2006 12:13:14", "d",     4
	DATA "May 4, 2006 12:13:14", "w",     4
	DATA "May 4, 2006 12:13:14", "ww",    18
	DATA "."

tests_dateadd:
	DATA "Jan  1, 2006 12:13:14", "yyyy", 1,  2007
	DATA "Jan  1, 2006 12:13:14", "q",    1,  2
	DATA "Jan  1, 2006 12:13:14", "m",    1,  2
	DATA "Jan  1, 2006 12:13:14", "y",    1,  2
	DATA "Jan  1, 2006 12:13:14", "d",    1,  2
	DATA "Jan  1, 2006 12:13:14", "w",    1,  1
	DATA "Jan  1, 2006 12:13:14", "ww",   2,  2
	DATA "Jan  1, 2006 12:13:14", "h",    1,  13
	DATA "Jan  1, 2006 12:13:14", "n",    1,  14
	DATA "Jan  1, 2006 12:13:14", "s",    1,  15
	DATA "May  4, 2006 12:13:14", "q",    3,  1
	DATA "May  4, 2006 12:13:14", "m",    5,  10
	DATA "May  4, 2006 12:13:14", "y",    120,244
	DATA "May  4, 2006 12:13:14", "d",    4,  8
	DATA "May  4, 2006 12:13:14", "w",    1,  5
	DATA "May  4, 2006 12:13:14", "ww",   10, 28
	DATA "."

tests_dateadd2:
	DATA "Jan 31, 2006 12:13:14", "m",    1,  "d",    28
	DATA "."

tests_datediff:
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "yyyy",  0
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "q",     0
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "m",     0
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "y",     1
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "d",     1
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "w",     0
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "ww",    1
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "h",     24
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "n",     24*60
	DATA "Jan 1, 2006 12:13:14", "Jan 2, 2006 12:13:14", "s",     24*60*60
	DATA "Jan 1, 2006 12:13:14", "May 4, 2006 12:13:14", "q",     1
	DATA "Jan 1, 2006 12:13:14", "May 4, 2006 12:13:14", "m",     4
	DATA "Jan 1, 2006 12:13:14", "May 4, 2006 12:13:14", "y",     123
	DATA "Jan 1, 2006 12:13:14", "May 4, 2006 12:13:14", "d",     123
	DATA "Jan 1, 2006 12:13:14", "May 4, 2006 12:13:14", "w",     17
	DATA "Jan 1, 2006 12:13:14", "May 4, 2006 12:13:14", "ww",    18
	DATA "Jan 1, 2006 12:13:14", "May 7, 2006 12:13:14", "w",     18
	DATA "Jan 1, 2006 12:13:14", "May 7, 2006 12:13:14", "ww",    18
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "yyyy",  0
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "q",     0
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "m",     0
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "y",     -1
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "d",     -1
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "w",     0
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "ww",    -1
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "h",     -24
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "n",     -24*60
	DATA "Jan 2, 2006 12:13:14", "Jan 1, 2006 12:13:14", "s",     -24*60*60
	DATA "May 4, 2006 12:13:14", "Jan 1, 2006 12:13:14", "q",     -1
	DATA "May 4, 2006 12:13:14", "Jan 1, 2006 12:13:14", "m",     -4
	DATA "May 4, 2006 12:13:14", "Jan 1, 2006 12:13:14", "y",     -123
	DATA "May 4, 2006 12:13:14", "Jan 1, 2006 12:13:14", "d",     -123
	DATA "May 4, 2006 12:13:14", "Jan 1, 2006 12:13:14", "w",     -17
	DATA "May 4, 2006 12:13:14", "Jan 1, 2006 12:13:14", "ww",    -18
	DATA "May 7, 2006 12:13:14", "Jan 1, 2006 12:13:14", "w",     -18
	DATA "May 7, 2006 12:13:14", "Jan 1, 2006 12:13:14", "ww",    -18
	DATA "."

SUITE( fbc_tests.datetime.calc )

	TEST( datepart_ )
		fb_I18nSet 0

		dim as string sDate, sInterval
		dim as integer wanted, result
		dim as double serial

		restore tests_datepart
		read sDate
		while sDate<>"."
		   read sInterval, wanted
		   serial = datevalue(sDate) + timevalue(sDate)
		   result = datepart( sInterval, serial, fbMonday, fbFirstFourDays )
		   CU_ASSERT( result = wanted )

		   read sDate
		wend

	END_TEST

	TEST( dateadd_ )
		fb_I18nSet 0

		dim as string sDate, sInterval, sIntervalTest
		dim as integer addvalue, wanted, result
		dim as double serial, serial_result

		restore tests_dateadd
		read sDate
		while sDate<>"."
		   read sInterval, addvalue, wanted
		   serial = datevalue(sDate) + timevalue(sDate)
		   serial_result = dateadd( sInterval, addvalue, serial )
		   result = datepart( sInterval, serial_result, fbMonday, fbFirstFourDays )
		   CU_ASSERT( result = wanted )

		   read sDate
		wend

		restore tests_dateadd2
		read sDate
		while sDate<>"."
		   read sInterval, addvalue, sIntervalTest, wanted
		   serial = datevalue(sDate) + timevalue(sDate)
		   serial_result = dateadd( sInterval, addvalue, serial )
		   result = datepart( sIntervalTest, serial_result, fbMonday, fbFirstFourDays )
		   CU_ASSERT( result = wanted )

		   read sDate
		wend

	END_TEST

	TEST( datediff_ )
		fb_I18nSet 0

		dim as string sDate1, sDate2, sInterval
		dim as integer wanted, result
		dim as double serial1, serial2

		restore tests_datediff
		read sDate1
		while sDate1<>"."
		   read sDate2, sInterval, wanted
		   serial1 = datevalue(sDate1) + timevalue(sDate1)
		   serial2 = datevalue(sDate2) + timevalue(sDate2)
		   result = datediff( sInterval, serial1, serial2, fbMonday, fbFirstFourDays )
		   CU_ASSERT( result = wanted )

		   read sDate1
		wend

	END_TEST

END_SUITE
