' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

function f( ) byref as UDT
	function = type<UDT>( 123 )
end function
