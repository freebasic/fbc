' TEST_MODE : COMPILE_ONLY_OK

type preserve
	i as integer
end type

redim array(0 to 1) as integer
redim preserve array(0 to 2)
 
