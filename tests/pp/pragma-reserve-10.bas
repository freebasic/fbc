' TEST_MODE : COMPILE_ONLY_FAIL

'' shared can't be used in any procedure

sub proc()
	#pragma reserve (shared) symbol
end sub
