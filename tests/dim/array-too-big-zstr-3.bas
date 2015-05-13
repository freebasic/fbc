' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in UDT field muldecl parser
const LIMIT = &h7FFFFFFF
type Container
	as zstring * 16 test(0 to LIMIT \ sizeof( zstring * 16 ))
end type
