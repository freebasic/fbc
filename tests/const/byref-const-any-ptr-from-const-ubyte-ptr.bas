' TEST_MODE : COMPILE_ONLY_OK

sub f( byref l as const any ptr )
end sub

dim r as const ubyte ptr = 0
f( r )
