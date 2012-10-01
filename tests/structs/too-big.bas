' TEST_MODE : COMPILE_ONLY_FAIL

const LIMIT = &h7FFFFFFF
type UDT
	as byte array(0 to LIMIT-1) '' still ok
	as byte a  '' too much
end type
