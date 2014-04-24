' TEST_MODE : COMPILE_ONLY_FAIL

sub f( array() as integer )
end sub

dim array(0 to 1) as integer
f( array(0) )
