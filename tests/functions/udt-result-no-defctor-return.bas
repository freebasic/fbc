' TEST_MODE : COMPILE_ONLY_OK

type UDT
	as integer a, b, c, d, e, f, g
	declare constructor( byval i as integer )
end type

constructor UDT( byval i as integer )
end constructor

function f( byval i as integer ) as UDT
	'' Should work fine with RETURN though, because RETURN uses the
	'' copyctor, not a defctor
	return type( 1 )
end function
