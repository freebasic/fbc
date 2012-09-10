' TEST_MODE : COMPILE_ONLY_FAIL

'' check triggered in var decl parser
const LIMIT = &h7FFFFFFF
dim shared as integer test(0 to LIMIT \ 4)
