' TEST_MODE : COMPILE_ONLY_OK

'' For backwards compatibility etc., no dimension count checking for accesses to () bydesc params 
sub f( array() as integer )
	print array(1)
	print array(1, 2)
end sub
