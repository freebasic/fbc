' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a, b, c, d, e, f, g
	declare constructor( )
end type

constructor UDT( )
end constructor

operator +( byref l as UDT, byref r as UDT ) as UDT
	dim as UDT x

	if( l.a = r.a ) then
		'' Switches the function to "FUNCTION= mode" - i.e. the result
		'' will be constructed at its top in preparation for FUNCTION=,
		'' and RETURNs cannot be allowed anymore (they use the copyctor,
		'' which would result in a double-construction).
		exit operator
	end if

	if( l.a = r.a + 1 ) then
		'' Accordingly, this cannot be allowed anymore, because it
		'' would construct the result a second time.
		return x
	end if
end operator
