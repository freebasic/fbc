' TEST_MODE : COMPILE_ONLY_OK

dim as integer a = 1, b = 0
print a \ b '' runtime error (can be trapped with -exx)
