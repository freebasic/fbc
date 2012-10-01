' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in var decl parser
const LIMIT = &h7FFFFFFF
dim shared as zstring * 16 test(0 to LIMIT \ sizeof( zstring * 16 ))
