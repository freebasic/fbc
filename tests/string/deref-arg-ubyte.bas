' TEST_MODE : COMPILE_ONLY_FAIL

sub f( byref s as string )
end sub

dim as ubyte ptr p
f( *p )
