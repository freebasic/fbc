''
'' dereference'd function test -- it looks weird and indeed, it is..
''

type sometype
	a			as integer
	b			as short
	bytefunc 	as function( ) as byte ptr
	strfunc 	as function( byval s as string ) as string
end type

type bar
	a			as integer
	b 			as short
	c			as byte
	func 		as function( ) as sometype ptr
end type

declare function foo ( ) as bar ptr

	'' string function
	print foo( )->func( )->strfunc( "abc" )

	'' change value (kids, don't do that at home!)
	*foo( )->func( )->bytefunc( ) = 8
	
	'' do nothing, skip result
	foo( )->func( )->bytefunc( ) 
	
	'' print result
	print "8 ="; *foo( )->func( )->bytefunc( )


	sleep	

'':::::
function bytefunc( ) as byte ptr
	static value as byte = 6

	function = @value

end function

'':::::
function strfunc( byval s as string ) as string

	function = ucase( s )

end function

'':::::
function func ( ) as sometype ptr
	static st as sometype = ( 4, 5, @bytefunc, @strfunc )
	
	'st.bytefunc = @bytefunc
	'st.strfunc  = @strfunc
	
	function = @st

end function

'':::::
function foo ( ) as bar ptr
	static bar as bar = ( 1, 2, 3, @func )
	
	'bar.func = @func
	
	function = @bar

end function
	
	
	