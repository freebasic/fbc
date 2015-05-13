' TEST_MODE : COMPILE_ONLY_FAIL

function f( ) byref as integer
	'' reference to local
	dim array(0 to 1) as integer
	dim i as integer
	function = array(i)
end function
