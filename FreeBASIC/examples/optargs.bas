

declare sub foo( byval arg1 as double = 1, byval arg2 as integer = -2 )

declare function bar( byval arg1 as integer = -2 , byval arg2 as integer )


	foo
	
	a = bar( , 1 )
	
	sleep
	
	
	
sub foo( byval arg1 as double = 1, byval arg2 as integer = -2 )

	print arg1 * arg2

end sub


function bar( byval arg1 as integer = -2, byval arg2 as integer )

	print arg1 * arg2

end function	