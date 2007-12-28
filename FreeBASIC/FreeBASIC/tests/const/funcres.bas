' TEST_MODE : COMPILE_ONLY_FAIL

function la( ) as const integer ptr
	static as integer res
	return @res
end function
*la( ) = 6

