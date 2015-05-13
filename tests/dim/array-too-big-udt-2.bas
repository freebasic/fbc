' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a, b, c, d
end type

'' check triggered in var decl parser
const LIMIT = &h7FFFFFFF
dim shared test(0 to LIMIT \ sizeof( UDT )) as UDT
