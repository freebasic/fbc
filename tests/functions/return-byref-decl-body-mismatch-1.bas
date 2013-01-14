' TEST_MODE : COMPILE_ONLY_FAIL

declare function f( ) byref as integer

function f( ) as integer
	static i as integer
	function = i
end function
