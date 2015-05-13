' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a, b, c, d, e, f, g
	declare constructor( byval i as integer )
end type

constructor UDT( byval i as integer )
end constructor

function f( byval i as integer ) as UDT
	'' No defctor, cannot construct result automatically
	function = type( 1 )
end function
