' TEST_MODE : COMPILE_ONLY_FAIL

sub f( byref l as any ptr )
end sub

dim r as any const ptr = 0
f( r )
