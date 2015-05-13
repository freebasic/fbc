' TEST_MODE : COMPILE_ONLY_FAIL

function f1( ) as integer
	function = 123
end function

function f2( ) byref as integer
	'' Cannot take addrof function result in regs
	function = f1( )
end function
