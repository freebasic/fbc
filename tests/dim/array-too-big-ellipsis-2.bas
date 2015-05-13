' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in array initializer parser
'' if the <0 to ...> becomes <0 to 1> or more then it's too much...
const LIMIT = &h7FFFFFFF
dim shared as zstring * 2 test(0 to (LIMIT \ 2)-1, 0 to ...) = _
{ _
	{ "", "" } _
}
