' TEST_MODE : COMPILE_ONLY_FAIL

sub f overload alias "f1"( byval p as sub( byval as const integer ptr       ) ) : end sub
sub f overload alias "f2"( byval p as sub( byval as const integer const ptr ) ) : end sub
