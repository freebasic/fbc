' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a
	declare constructor( )
	declare property f( ) as UDT
end type

constructor UDT( )
end constructor

property UDT.f( ) as UDT
	dim as UDT x

	if( this.a = 0 ) then
		'' Switches the function to "RETURN mode" - i.e. the result
		'' will not be constructed at the top in preparation for
		'' FUNCTION=, but instead the RETURNs will use the copy-ctor
		'' to construct the result at every RETURN statement.
		return x
	end if

	if( this.a = 1 ) then
		'' Accordingly, this cannot be allowed anymore, because it
		'' doesn't construct the result.
		exit property
	end if

	return x
end property
