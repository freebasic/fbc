' TEST_MODE : COMPILE_ONLY_FAIL

dim shared array() as integer

sub f1( )
	print array(0)
end sub

sub f2( )
	print array(0, 0)
end sub
