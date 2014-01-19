' TEST_MODE : COMPILE_ONLY_FAIL

dim p as const any ptr = imagecreate( 32, 32 )
line p, (0, 0) - (31, 31), rgb(0,0,0)
