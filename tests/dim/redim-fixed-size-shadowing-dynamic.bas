' TEST_MODE : COMPILE_ONLY_FAIL

dim x() as integer
scope
	dim x(1 to 1) as integer
	redim x(2 to 2)
end scope
