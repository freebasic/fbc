' TEST_MODE : COMPILE_ONLY_FAIL

sub f( byref s as string )
end sub

dim s as string * 32
s = "0123456789"
f( s[5] )
