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
		'' Switches the function to "RETURN mode" - i.e. the result
		'' will not be constructed at the top in preparation for
		'' FUNCTION=, but instead the RETURNs will use the copy-ctor
		'' to construct the result at every RETURN statement.
		return x
	end if

	if( l.a = r.a + 1 ) then
		'' Accordingly, this cannot be allowed anymore, because it
		'' doesn't construct the result.
		exit operator
	end if

	return x
end operator
