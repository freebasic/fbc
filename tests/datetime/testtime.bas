# include once "fbcunit.bi"
# include once "vbcompat.bi"

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as long )

const EPSILON_DBL = 2.2204460492503131e-016

#define DBL_CUT(v,digits) _
    (cdbl(cint((v) * 10.0^(digits))) / 10.0^(digits))

#define DBL_COMPARE(v1,v2) _
    (abs( DBL_CUT(v1,10) - DBL_CUT(v2,10) ) < EPSILON_DBL)

tests_timeserial:
	data   0,   0,   0, 0
	data   1,   0,   0, (1.0*1.0/24.0)
	data   3,   0,   0, (1.0*3.0/24.0)
	data  12,   0,   0, 0.5
	data  24,   0,   0, 1.0
	data   0,   1,   0, (1.0*1.0/(24.0*60.0))
	data   0,  15,   0, (1.0*15.0/(24.0*60.0))
	data   0,  60,   0, (1.0*1.0/24.0)
	data   0,   0,   1, (1.0*1.0/(24.0*60.0*60.0))
	data   0,   0,  15, (1.0*15.0/(24.0*60.0*60.0))
	data   0,   0,  60, (1.0*1.0/(24.0*60.0))
	data  -1,   0,   0, -(1.0*1.0/24.0)
	data  -3,   0,   0, -(1.0*3.0/24.0)
	data -12,   0,   0, -0.5
	data -24,   0,   0, -1.0
	data   0,  -1,   0, -(1.0*1.0/(24.0*60.0))
	data   0, -15,   0, -(1.0*15.0/(24.0*60.0))
	data   0, -60,   0, -(1.0*1.0/24.0)
	data   0,   0,  -1, -(1.0*1.0/(24.0*60.0*60.0))
	data   0,   0, -15, -(1.0*15.0/(24.0*60.0*60.0))
	data   0,   0, -60, -(1.0*1.0/(24.0*60.0))
	data 925686, 12, 55, 38570.2589699074
	data "."

tests_timevalue:
	data "01:00",             1,  1,  0,  0
	data "03:00",             1,  3,  0,  0
	data "12:00",             1, 12,  0,  0
	data "01:00a",            1,  1,  0,  0
	data "01:00am",           1,  1,  0,  0
	data "01:00 am",          1,  1,  0,  0
	data "01:00 AM",          1,  1,  0,  0
	data "01:00 Am",          1,  1,  0,  0
	data "01:00 pm",          1, 13,  0,  0
	data "12:00 am",          1,  0,  0,  0
	data "12:00 pm",          1, 12,  0,  0
	data "00:01",             1,  0,  1,  0
	data "00:15",             1,  0, 15,  0
	data "00:00:01",          1,  0,  0,  1
	data "00:00:15",          1,  0,  0, 15
	data "Aug 5, 2005, 00:01",1,  0,  1,  0
	data "Aug 5, 2005 00:01", 1,  0,  1,  0
	data "5 Aug. 2005, 00:01",1,  0,  1,  0
	data "5 Aug. 2005 00:01", 1,  0,  1,  0
	data "00:01, Aug 5, 2005",1,  0,  1,  0
	data "00:01 Aug 5, 2005", 1,  0,  1,  0
	data "00:01, 5 Aug. 2005",1,  0,  1,  0
	data "00:01 5 Aug. 2005", 1,  0,  1,  0
	data "00",                0
	data "24:00",             0
	data "00:60",             0
	data "00:00:60",          0
	data "."

SUITE( fbc_tests.datetime.testtime )

	TEST( timeserial_ )
		fb_I18nSet 0
		dim as double serial_time, test_value
		dim as integer chk_hour, chk_minute, chk_second
		dim sHour as string

		restore tests_timeserial
		read sHour
		while sHour<>"."
		   chk_hour = val(sHour)
		   read chk_minute, chk_second, serial_time
		   test_value = timeserial( chk_hour, chk_minute, chk_second )
		   CU_ASSERT( DBL_COMPARE(test_value,serial_time) )
		   while( chk_second>=60 )
	   		chk_second -= 60
			  chk_minute += 1
		   wend
		   while( chk_second<=-60 )
	   		chk_second += 60
			  chk_minute -= 1
		   wend
		   while( chk_minute>=60 )
	   		chk_minute -= 60
			  chk_hour += 1
		   wend
		   while( chk_minute<=-60 )
	   		chk_minute += 60
			  chk_hour -= 1
		   wend
		   chk_hour mod= 24

		   '' special handling for VB quirk (when fix(serial_time)=0)
		   if( chk_hour < 0 and chk_minute >= 0 and chk_second >= 0 ) then
			  chk_hour = -chk_hour
		   elseif( chk_hour = 0 and chk_minute < 0 and chk_second >= 0 ) then
			  chk_minute = -chk_minute
		   elseif( chk_hour = 0 and chk_minute = 0 and chk_second < 0 ) then
			  chk_second = -chk_second
		   end if

		   CU_ASSERT( chk_hour = hour(serial_time) )
		   CU_ASSERT( chk_minute = minute(serial_time) )
		   CU_ASSERT( chk_second = second(serial_time) )

			read sHour
		wend

	END_TEST

	TEST( timevalue_ )

		fb_I18nSet 0
		dim as double  serial_time, calc_serial_time
		dim as integer chk_hour, chk_minute, chk_second
		dim as integer want_ok
		dim sTime as string

		restore tests_timevalue
		read sTime
		while sTime<>"."
		   read want_ok
		   serial_time = timevalue(sTime)

		   if want_ok=1 then
			  read chk_hour, chk_minute, chk_second
			  ' Store result in a temporary variable to avoid rounding errors
			  calc_serial_time = timeserial( chk_hour, chk_minute, chk_second )
			  CU_ASSERT( serial_time = calc_serial_time )
		   end if

			read sTime
		wend

	END_TEST

END_SUITE
