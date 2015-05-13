' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	fixedsizearrayfield(0 to 1) as integer
end type

dim x as UDT
redim (x.fixedsizearrayfield)(0 to 0) as integer
