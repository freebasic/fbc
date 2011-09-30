' TEST_MODE : COMPILE_ONLY_OK

type rational
	as integer numerator, denominator
end type

dim as rational ptr r

r->constructor( )
r->destructor( )
