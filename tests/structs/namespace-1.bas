' TEST_MODE : COMPILE_ONLY_OK

'' -gen gcc regression tests:
'' UDT and function names shouldn't cause conflicts in the C output code.

type UDT1
	i as integer
end type

sub UDT1( )
end sub

dim x1 as UDT1
UDT1( )
