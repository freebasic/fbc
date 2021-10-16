' TEST_MODE : COMPILE_ONLY_FAIL

'' shared can't be used in any scope

scope
	#pragma reserve (shared) symbol
end scope
