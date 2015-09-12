' TEST_MODE : COMPILE_ONLY_OK

#macro checkTypeOf(l, bop, r, expectedType)
	#assert typeof((l) bop (r)) = typeof(expectedType)
	#assert typeof((r) bop (l)) = typeof(expectedType)
#endmacro

checkTypeOf(true, =,    cbyte(-1), integer)
checkTypeOf(true, =,   cubyte(-1), integer)
checkTypeOf(true, =,   cshort(-1), integer)
checkTypeOf(true, =,  cushort(-1), integer)
checkTypeOf(true, =,     clng(-1), integer)
checkTypeOf(true, =,    culng(-1), integer)
checkTypeOf(true, =,     cint(-1), integer)
checkTypeOf(true, =,    cuint(-1), integer)
checkTypeOf(true, =,  clngint(-1), integer)
checkTypeOf(true, =, culngint(-1), integer)
checkTypeOf(true, =,     csng(-1), integer)
checkTypeOf(true, =,     cdbl(-1), integer)

checkTypeOf(true, and, cbyte(-1), integer)
checkTypeOf(true, and, cubyte(-1), integer)
checkTypeOf(true, and, cshort(-1), integer)
checkTypeOf(true, and, cushort(-1), integer)
checkTypeOf(true, and, clng(-1), integer)
#ifdef __FB_64BIT__
	checkTypeOf(true, and, culng(-1), integer)
#else
	checkTypeOf(true, and, culng(-1), uinteger)
#endif
checkTypeOf(true, and, cint(-1), integer)
checkTypeOf(true, and, cuint(-1), uinteger)
#ifdef __FB_64BIT__
	checkTypeOf(true, and, clngint(-1), integer)
	checkTypeOf(true, and, culngint(-1), uinteger)
#else
	checkTypeOf(true, and, clngint(-1), longint)
	checkTypeOf(true, and, culngint(-1), ulongint)
#endif
checkTypeOf(true, and, csng(-1), integer)
checkTypeOf(true, and, cdbl(-1), integer)
