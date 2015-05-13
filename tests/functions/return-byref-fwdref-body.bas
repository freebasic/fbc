' TEST_MODE : COMPILE_ONLY_FAIL

type typedef as fwdref

function f( ) byref as typedef
	static as integer a
	function = a
end function

type fwdref as integer
