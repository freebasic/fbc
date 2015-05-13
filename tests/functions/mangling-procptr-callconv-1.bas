' TEST_MODE : COMPILE_ONLY_FAIL

sub f overload( byval p as sub stdcall( ) ) : end sub
sub f overload( byval p as sub cdecl  ( ) ) : end sub
