' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare constructor( as integer )
end type

constructor UDT( i as integer )
end constructor

dim as integer c
dim as UDT x1 = UDT( 0 ), x2 = UDT( 0 )

'' The temp var cannot be constructed because there is no matching to construct
'' it from the true/false expressions, and there is no default ctor either,
'' but there is another ctor, so it must cause an error.
x1 = iif( c, x1, x2 )
