' TEST_MODE : COMPILE_AND_RUN_OK

'' This should just show the "parameter initializer mismatch" warning, but not
'' cause any errors.

type UDT
	i as integer
	declare sub s(byval i0 as integer = 0)
end type

sub UDT.s(byval i0 as integer = 1)
	i = i0
	this.i = i0
end sub
