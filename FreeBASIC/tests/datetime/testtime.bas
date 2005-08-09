option explicit

#include "vbcompat.bi"

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as integer )

defint a-z

#define DBL_CUT(v,digits) _
    (cdbl(cint((v) * 10.0^(digits))) / 10.0^(digits))

#define DBL_COMPARE(v1,v2) _
    DBL_CUT(v1,10)=DBL_CUT(v2,10)

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

sub test_timeserial
    dim as double serial_time, test_value
	dim as integer chk_hour, chk_minute, chk_second
    dim sHour as string

    print "Testing TIMESERIAL ...";

    restore tests_timeserial
    read sHour
    while sHour<>"."
        chk_hour = val(sHour)
        read chk_minute, chk_second, serial_time
        test_value = timeserial( chk_hour, chk_minute, chk_second )
        ASSERT( DBL_COMPARE(test_value,serial_time) )
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

        ASSERT( chk_hour = hour(serial_time) )
        ASSERT( chk_minute = minute(serial_time) )
        ASSERT( chk_second = second(serial_time) )
        print ".";
    	read sHour
    wend
    print "OK"
end sub

sub test_timevalue
    dim as double  serial_time
	dim as integer chk_hour, chk_minute, chk_second
    dim as integer want_ok, is_ok
    dim sTime as string

    print "Testing TIMEVALUE ...";

    restore tests_timevalue
    read sTime
    while sTime<>"."
        read want_ok
        is_ok = 0
        on local error goto did_fail
        serial_time = timevalue(sTime)
#ifdef FIXME
        is_ok = want_ok
#else
        is_ok = 1
#endif
        if want_ok=1 then
            read chk_hour, chk_minute, chk_second
	        ASSERT( serial_time = timeserial( chk_hour, chk_minute, chk_second ) )
        end if
did_fail:
        on local error goto 0
        ASSERT( is_ok = want_ok )
        print ".";
    	read sTime
    wend
    print "OK"
end sub

' Turn off I18N and L10N
fb_I18nSet 0
test_timeserial
test_timevalue
