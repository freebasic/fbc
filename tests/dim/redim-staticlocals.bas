' TEST_MODE : COMPILE_ONLY_OK

'' C backend regression test
sub f( ) static
	redim array(1 to 2) as integer
end sub
