''
'' optional arguments test
''

declare sub foo( byval arg1 as double = 1, byval arg2 as integer = -2 )

declare function bar( byval arg1 as integer = -2 , byval arg2 as integer ) as integer

declare sub optstr( byref arg1 as string = "abc", byref arg2 as string = "def" )


	foo
	
	dim as integer a = bar( , 1 )
	
	optstr
	
	
	sleep
	
	
'':::::	
sub foo( byval arg1 as double = 1, byval arg2 as integer = -2 )

	print arg1 * arg2

end sub

'':::::
function bar( byval arg1 as integer = -2, byval arg2 as integer ) as integer

	print arg1 * arg2
	return 0

end function	

'':::::
sub optstr( byref arg1 as string, byref arg2 as string )

	print arg1 + arg2

end sub
