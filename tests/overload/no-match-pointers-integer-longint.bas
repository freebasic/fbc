' TEST_MODE : COMPILE_ONLY_FAIL

#macro proc( T )
	function f overload( byval p as T ) as string
		function = #T
	end function
#endmacro

proc( integer ptr )
proc( longint ptr )

#ifndef __FB_64BIT__
	#error "64bit-only test"
#endif

dim pl as long ptr
print f( pl )
