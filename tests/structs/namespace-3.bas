' TEST_MODE : COMPILE_ONLY_OK

'' -gen gcc regression tests:
'' UDT and function names shouldn't cause conflicts in the C output code.

union UDT1
	a as integer
end union

sub UDT1( )
end sub

dim x1 as UDT1
UDT1( )
