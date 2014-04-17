' TEST_MODE : COMPILE_ONLY_FAIL

type A
	i as integer
end type

type B
	i as integer
end type

type C
	i as integer
end type

#macro proc( T )
	function f overload( byval p as T ) as string
		function = #T
	end function
#endmacro

proc( A ptr )
proc( B ptr )

dim pc as C ptr
print f( pc )
