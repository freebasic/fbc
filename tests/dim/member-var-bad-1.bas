' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer

	'' Cannot be initializer here, since it's really an EXTERN
	static i as integer = 1
end type
