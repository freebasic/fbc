''
'' optional arguments test
''

declare sub foo( byval arg1 as double = 1, byval arg2 as integer = -2 )

declare function bar( byval arg1 as integer = -2 , byval arg2 as integer )

declare sub optstr( byval arg1 as string = "abc", arg2 as string = "def" )


	foo
	
	a = bar( , 1 )
	
	optstr
	
	
	sleep
	
	
'':::::	
sub foo( byval arg1 as double = 1, byval arg2 as integer = -2 )

	print arg1 * arg2

end sub

'':::::
function bar( byval arg1 as integer = -2, byval arg2 as integer )

	print arg1 * arg2

end function	

'':::::
sub optstr( byval arg1 as string, arg2 as string )

	print arg1 + arg2

end sub