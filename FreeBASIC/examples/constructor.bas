dim shared v as string

print "Application start"

sub do_init constructor
    print "Before main"
	v = "from_ctor"
end sub

sub do_exit destructor
    print "Bye !"
end sub

if( v <> "from_ctor" ) then
    ASSERT( false )
end if
