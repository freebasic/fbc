' TEST_MODE : COMPILE_ONLY_OK

sub f( byref l as const ubyte ptr )
end sub

dim r as const any ptr = 0
f( r )
