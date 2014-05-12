' TEST_MODE : COMPILE_ONLY_FAIL

sub f overload( byval p as sub( byval as integer ptr       ) ) : end sub
sub f overload( byval p as sub( byval as integer const ptr ) ) : end sub
