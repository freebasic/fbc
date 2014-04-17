' TEST_MODE : COMPILE_ONLY_OK

sub f( array() as integer )
	redim array(0 to 0)
	print array(0, 0)
end sub
