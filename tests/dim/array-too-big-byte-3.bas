' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in UDT field muldecl parser
const LIMIT = &h7FFFFFFF
type Container
	as byte test(0 to LIMIT)
end type
