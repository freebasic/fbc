' TEST_MODE : COMPILE_ONLY_FAIL

sub f overload( ) : end sub
sub f overload( p1 as integer = 0 ) : end sub
f( )
