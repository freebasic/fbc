' TEST_MODE : COMPILE_ONLY_FAIL

type typedef as fwdref

'' As with BYREF parameters, BYREF AS FWDREF is allowed, but only in
'' prototypes, not the function body itself
declare function f( ) byref as typedef

'' Here, the real result type isn't yet known though - an error must be shown
print f( )

type fwdref as integer

function f( ) byref as integer
	static as integer a = 123
	function = a
end function
