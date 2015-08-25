' TEST_MODE : COMPILE_ONLY_FAIL

'' For bydesc param with known dimensions, we can and should check accesses
sub f( array(any) as integer )
	print array(1, 2)
end sub
