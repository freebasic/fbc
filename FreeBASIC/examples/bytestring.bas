type sometype
	abc as integer
	lpstring as byte ptr
end type


declare function func1( s as string ) as byte ptr
declare function func2( s as string ) as byte ptr
declare sub printchar( s as string )

	dim p as byte ptr
	
	dim temp as string
	temp = "HeyHoh!"
	p = func1( temp )
	
	dim s as string
	
	s = *p
	
	redim t(10) as sometype
	a = 0
	t(a).lpstring = p
	
	'' 1
	print s

	'' 2
	printchar *p
	
	'' 3
	printchar *t(a).lpstring

	'' 4
	printchar *func2( "HeyHoh!" )			'' returned pointer will leak, just for testing..
	
	sleep
	
	
'':::::
function func1( s as string ) as byte ptr
	func1 = sadd( s )
end function

'':::::
function func2( s as string ) as byte ptr
	dim p as byte ptr
	p = callocate( len( s ) + 1 )
	*p = s
	func2 = p
end function

'':::::
sub printchar( s as string )
	'' only way of printing a byte ptr as a string of chars -- while there's no pointer type casting
	print s
end sub

