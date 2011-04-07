''
'' simple bit fields test
''

type mytype
	flag_0 : 1 as integer
    flag_1 : 1 as integer
    flag_2 : 1 as integer
end type

	dim t as mytype

    t.flag_0 = 1
    t.flag_1 = 0
    t.flag_2 = 1

    print "all flags on? ";
    if ( t.flag_0 and t.flag_1 and t.flag_2 ) then
		print "true"
    else
    	print "false"
	end if

    print "flags 0 and 2 on? ";
    if ( t.flag_0 and t.flag_2 ) then
		print "true"
    else
    	print "false"
	end if


	sleep
