' TEST_MODE : COMPILE_ONLY_FAIL

'' asm can't be used in any procedure

sub proc()
	#pragma reserve (asm) symbol
end scope
