' TEST_MODE : COMPILE_ONLY_FAIL

'' from sf.net #642

scope

	dim as const integer a = 256

	clear a, 0, sizeof(integer)

end scope
