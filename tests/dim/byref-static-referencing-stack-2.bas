' TEST_MODE : COMPILE_ONLY_FAIL

sub f()
	dim i as integer
	static byref ri as integer = i
end sub
