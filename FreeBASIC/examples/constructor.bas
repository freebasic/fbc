dim shared v as string

print "Application start"

function do_init constructor
    print "Before main"
	v = "from_ctor"
end function

function do_exit destructor
    print "Bye !"
end function

if( v <> "from_ctor" ) then
    ASSERT( false )
end if
