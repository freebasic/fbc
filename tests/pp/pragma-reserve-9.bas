' TEST_MODE : COMPILE_ONLY_FAIL

'' asm can't be used in any scope

scope
	#pragma reserve (asm) symbol
end scope
