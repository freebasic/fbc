' TEST_MODE : COMPILE_ONLY_FAIL

sub f( byref s as string )
end sub

dim as byte ptr p
f( *p )
