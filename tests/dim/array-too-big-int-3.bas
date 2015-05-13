' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in UDT field muldecl parser
const LIMIT = &h7FFFFFFF
type Container
	as integer test(0 to LIMIT \ 4)
end type
