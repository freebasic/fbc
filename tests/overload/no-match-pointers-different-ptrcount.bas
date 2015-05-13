' TEST_MODE : COMPILE_ONLY_FAIL

#macro proc( T )
	function f overload( byval p as T ) as string
		function = #T
	end function
#endmacro

proc( integer ptr ptr )
proc( integer ptr )

dim pppi as integer ptr ptr ptr
print f( pppi )
