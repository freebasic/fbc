option explicit

defint a-z

tests_dateserial:
    data  1,  1, 1900, 2
    data 30, 12, 1899, 0
    data  1,  1, 1899, -363
    data  0,  1, 1900, 1
    data  1,  0, 1900, -29
    data  0,  0, 1900, -30
    data  5,  8, 2005, 38569
    data "."

tests_datevalue:
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


sub test_dateserial
	dim as integer day, month, year, serial_date, test_value
    dim sDay as string

    print "Testing DATESERIAL ...";

    restore tests_dateserial
    read sDay
    while sDay<>"."
        day = val(sDay)
        read month
        read year
        read serial_date
        test_value = dateserial( year, month, day )
        ASSERT( test_value = serial_date )
        print ".";
    	read sDay
    wend
    print "OK"
end sub

sub test_datevalue
	dim as integer day, month, year, serial_date, want_ok, is_ok
    dim sDate as string

    print "Testing DATEVALUE ...";

    restore tests_datevalue
    read sDate
    while sDate<>"."
        read want_ok
        is_ok = 0
        on local error goto did_fail
        serial_date = datevalue(sDate)
        is_ok = 1
        if want_ok=1 then
            read day, month, year
	        ASSERT( serial_date = dateserial( year, month, day ) )
        end if
did_fail:
        on local error goto 0
        ASSERT( is_ok = want_ok )
        print ".";
    	read sDate
    wend
    print "OK"
end sub

test_dateserial
test_datevalue
