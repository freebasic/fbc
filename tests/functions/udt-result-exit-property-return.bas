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
		'' Switches the function to "FUNCTION= mode" - i.e. the result
		'' will be constructed at its top in preparation for FUNCTION=,
		'' and RETURNs cannot be allowed anymore (they use the copyctor,
		'' which would result in a double-construction).
		exit property
	end if

	if( this.a = 1 ) then
		'' Accordingly, this cannot be allowed anymore, because it
		'' would construct the result a second time.
		return x
	end if
end property
