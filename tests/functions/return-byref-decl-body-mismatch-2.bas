' TEST_MODE : COMPILE_ONLY_FAIL

declare function f( ) as integer

function f( ) byref as integer
	static i as integer
	function = i
end function
