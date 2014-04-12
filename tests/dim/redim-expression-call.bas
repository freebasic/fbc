' TEST_MODE : COMPILE_ONLY_FAIL

function f( ) as integer
	function = 1
end function

redim (f( ))(0 to 0) as integer
