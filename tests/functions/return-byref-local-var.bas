' TEST_MODE : COMPILE_ONLY_FAIL

function f( ) byref as integer
	'' reference to local
	dim i as integer
	function = i
end function
