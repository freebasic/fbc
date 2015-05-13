' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in UDT field singledecl parser
const LIMIT = &h7FFFFFFF
type Container
	test(0 to LIMIT \ sizeof( zstring * 16 )) as zstring * 16
end type
