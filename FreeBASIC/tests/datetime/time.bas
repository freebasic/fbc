option explicit

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

#if 0
tests_timevalue:
	data "Aug 5, 2005",       1, 5, 8, 2005
	data "August 5, 2005",    1, 5, 8, 2005
	data "5 Aug, 2005",       1, 5, 8, 2005
	data "5 August, 2005",    1, 5, 8, 2005
	data "5 Aug 2005",        1, 5, 8, 2005
	data "5 August 2005",     1, 5, 8, 2005
	data "August, 2005",      0
	data "5, 2005",           0
	data "5. August, 2005",   0
	data "5 August- 2005",    0
	data "5 August,, 2005",   0
	data "08-05/2005",        0
    data "."
#endif

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
        ASSERT( chk_hour = hour(serial_time) )
        ASSERT( chk_minute = minute(serial_time) )
        ASSERT( chk_second = second(serial_time) )
        print ".";
    	read sHour
    wend
    print "OK"
end sub

#if 0
sub test_timevalue
	dim as integer chk_day, chk_month, chk_year, serial_date, want_ok, is_ok
    dim sDate as string

    print "Testing DATEVALUE ...";

    restore tests_datevalue
    read sDate
    while sDate<>"."
        read want_ok
        is_ok = 0
        on local error goto did_fail
        serial_date = datevalue(sDate)
#ifdef FIXME
        is_ok = want_ok
#else
        is_ok = 1
#endif
        if want_ok=1 then
            read chk_day, chk_month, chk_year
	        ASSERT( serial_date = dateserial( chk_year, chk_month, chk_day ) )
        end if
did_fail:
        on local error goto 0
        ASSERT( is_ok = want_ok )
        print ".";
    	read sDate
    wend
    print "OK"
end sub
#endif

test_timeserial
#if 0
test_timevalue
#endif
