''
'' dynamic zstrings test
''

type sometype
	abc as integer
	lpstring as zstring ptr
end type


declare function func1( byval s as string ) as zstring ptr
declare function func2( byval s as string ) as zstring ptr

	dim p as zstring ptr
	
	dim temp as string
	temp = "HeyHoh!"
	p = func1( temp )
	
	dim s as string
	
	s = *p
	
	redim t(10) as sometype
	dim a as integer = 0
	t(a).lpstring = p
	
	'' 1
	print s

	'' 2
	print *p
	
	'' 3
	print *t(a).lpstring

	'' 4
	print *func2( "HeyHoh!" )			'' returned pointer will leak, just for testing..
	
	sleep
	
	
'':::::
function func1( byval s as string ) as zstring ptr
	func1 = strptr( s )
end function

'':::::
function func2( byval s as string ) as zstring ptr
	dim p as zstring ptr
	p = allocate( len( s ) + 1 )
	*p = s
	func2 = p
end function
