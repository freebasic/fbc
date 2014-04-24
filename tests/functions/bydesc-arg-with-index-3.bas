' TEST_MODE : COMPILE_ONLY_FAIL

sub f( array() as integer )
end sub

dim array() as integer
redim array(0 to 9, 0 to 9)
f( array(5, 2) )
