option explicit

#include "vbcompat.bi"

declare sub fb_I18nSet alias "fb_I18nSet"( byval on_off as integer )

defint a-z

tests_dateserial:
    data  1,  1, 1900, 1, 2, 2
    data 30, 12, 1899, 1, 7, 0
    data  1,  1, 1899, 1, 1, -363
    data  0,  1, 1900, 0, 1, 1
    data  1,  0, 1900, 0, 6, -29
    data  0,  0, 1900, 0, 5, -30
    data  5,  8, 2005, 1, 6, 38569
    data "."

tests_datevalue:
	data "Aug 5, 2005",       1, 5, 8, 2005
	data "August 5, 2005",    1, 5, 8, 2005
	data "5 Aug, 2005",       1, 5, 8, 2005
	data "5 August, 2005",    1, 5, 8, 2005
	data "5 Aug 2005",        1, 5, 8, 2005
	data "5 August 2005",     1, 5, 8, 2005
	data "Aug 5, 2005, 00:01",1, 5, 8, 2005
	data "Aug 5, 2005 00:01", 1, 5, 8, 2005
	data "5 Aug. 2005, 00:01",1, 5, 8, 2005
	data "5 Aug. 2005 00:01", 1, 5, 8, 2005
	data "00:01, Aug 5, 2005",1, 5, 8, 2005
	data "00:01 Aug 5, 2005", 1, 5, 8, 2005
	data "00:01, 5 Aug. 2005",1, 5, 8, 2005
	data "00:01 5 Aug. 2005", 1, 5, 8, 2005
	data "August, 2005",      0
	data "5, 2005",           0
	data "5. August, 2005",   0
	data "5 August- 2005",    0
	data "5 August,, 2005",   0
	data "08-05/2005",        0
    data "."


sub test_dateserial
    dim as integer serial_date, test_value, do_dmy_check
	dim as integer chk_day, chk_month, chk_year, chk_dow
    dim sDay as string

    print "Testing DATESERIAL ...";

    restore tests_dateserial
    read sDay
    while sDay<>"."
        chk_day = val(sDay)
        read chk_month, chk_year, do_dmy_check, chk_dow, serial_date
        test_value = dateserial( chk_year, chk_month, chk_day )
        ASSERT( test_value = serial_date )
        ASSERT( weekday( serial_date ) = chk_dow )
        if( do_dmy_check ) then
            ASSERT( chk_day = day(serial_date) )
            ASSERT( chk_month = month(serial_date) )
            ASSERT( chk_year = year(serial_date) )
        end if
        print ".";
    	read sDay
    wend
    print "OK"
end sub

sub test_datevalue
	dim as integer chk_day, chk_month, chk_year, serial_date, want_ok
    dim sDate as string

    print "Testing DATEVALUE ...";

    restore tests_datevalue
    read sDate
    while sDate<>"."
        read want_ok

        serial_date = datevalue(sDate)
        
        if want_ok=1 then
            read chk_day, chk_month, chk_year
	        ASSERT( serial_date = dateserial( chk_year, chk_month, chk_day ) )
        end if

        print ".";
    	read sDate
    wend
    print "OK"
end sub

' Turn off I18N and L10N
fb_I18nSet 0
test_dateserial
test_datevalue
