' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a, b, c, d, e, f, g
	declare constructor( )
end type

constructor UDT( )
end constructor

function f( byval i as integer ) as UDT
	dim as UDT x

	if( i = 0 ) then
		'' Switches the function to "RETURN mode" - i.e. the result
		'' will not be constructed at the top in preparation for
		'' FUNCTION=, but instead the RETURNs will use the copy-ctor
		'' to construct the result at every RETURN statement.
		return x
	end if

	if( i = 1 ) then
		'' Accordingly, this cannot be allowed anymore, because it
		'' doesn't construct the result.
		exit function
	end if

	return x
end function
