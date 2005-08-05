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

test_dateserial
