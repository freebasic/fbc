' TEST_MODE : COMPILE_ONLY_FAIL

'' https://sourceforge.net/p/fbc/bugs/952/

type foo
	declare operator cast() as single
	dummy as integer
end type

operator foo.cast() as single
end operator

dim f as foo
var x = cint( f )
