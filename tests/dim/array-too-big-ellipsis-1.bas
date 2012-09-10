' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in array initializer parser
'' <array(0 to LIMIT-1, 0 to 0) as byte> would still be ok, only LIMIT bytes,
'' but if the <0 to ...> becomes <0 to 1> or more then it's too much...
const LIMIT = &h7FFFFFFF
dim shared as byte test(0 to LIMIT-1, 0 to ...) = _
{ _
	{ 0, 0 } _
}
