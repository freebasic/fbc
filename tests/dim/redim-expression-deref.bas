' TEST_MODE : COMPILE_ONLY_FAIL

dim i as integer
dim pi as integer ptr = @i

redim (*pi)(0 to 0) as integer
