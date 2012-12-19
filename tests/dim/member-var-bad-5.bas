' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer

	static i as integer
end type

'' UDT.i is an INTEGER, but VAR would derive SHORT from the expression,
'' so that's a mismatch...
var UDT.i = cshort( 0 )
