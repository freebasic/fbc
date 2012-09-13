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
		'' Switches the function to "FUNCTION= mode" - i.e. the result
		'' will be constructed at its top in preparation for FUNCTION=,
		'' and RETURNs cannot be allowed anymore (they use the copyctor,
		'' which would result in a double-construction).
		exit function
	end if

	if( i = 1 ) then
		'' Accordingly, this cannot be allowed anymore, because it
		'' would construct the result a second time.
		return x
	end if
end function
