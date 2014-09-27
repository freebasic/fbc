' TEST_MODE : COMPILE_ONLY_FAIL

dim array(0 to 1) as integer

function f() as integer
	function = 1
end function

array(f()) &= 1
