' TEST_MODE : COMPILE_ONLY_FAIL

#macro proc( T )
	function f overload( byval p as T ) as string
		function = #T
	end function
#endmacro

proc( long ptr )
proc( integer ptr )

#ifdef __FB_64BIT__
	#error "32bit-only test"
#endif

dim pll as longint ptr
print f( pll )
