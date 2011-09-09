''
'' function pointers test
''

type functype
	myfunc1 as function( byval x as integer, byval y as integer ) as integer
	myfunc2 as function( byval x as integer, byval y as integer ) as integer ptr
	mysub1 as sub( byval arg1 as double = 3, byval arg2 as double = 5 )
end type

declare function realfunct1( byval x as integer, byval y as integer ) as integer
declare function realfunct2( byval x as integer, byval y as integer ) as integer ptr
declare sub realsub1( byval arg1 as double = 3, byval arg2 as double = 5 )

declare function realfunct3( byval arg1 as function( byval arg1 as integer ) as integer, byval arg2 as double ) as integer

	dim st as functype
	
	st.myfunc1 = @realfunct1
	print "3 * 5 = "; st.myfunc1( 3, 5 )
	
	st.mysub1  = @realsub1
	st.mysub1( )
	
	st.myfunc2 = @realfunct2
	print "3 * 5 = "; *st.myfunc2( 3, 5 )
	

	''''''''''''''''''''''''''''''''''''
	
	dim func1 as function( byval x as integer, byval y as integer ) as integer
	
	func1 = @realfunct1
	
	print "3 * 5 = "; func1( 3, 5 )
	
	func1( 3, 5 )
	
	''''''''''''''''''''''''''''''''''''
	dim func1tb(10) as function( byval x as integer, byval y as integer ) as integer
	
	func1tb(10) = @realfunct1
		
	print "3 * 5 = "; func1tb(10)( 3, 5 )

	''''''''''''''''''''''''''''''''''''
	dim functypetb(10) as functype
	
	functypetb(10).myfunc1 = @realfunct1
	
	print "3 * 5 = "; functypetb(10).myfunc1( 3, 5 )
	
	
	sleep

''::::
function realfunct1( byval x as integer, byval y as integer ) as integer

	realfunct1 = x * y

end function'

''::::
function realfunct2( byval x as integer, byval y as integer ) as integer ptr
	static r as integer

	r = x * y
	
	realfunct2 = @r

end function'

''::::
sub realsub1( byval arg1 as double = 3, byval arg2 as double = 5 )

	print "3 * 5 = "; arg1 * arg2

end sub

function realfunct3( byval arg1 as function( byval arg1 as integer ) as integer, byval arg2 as double ) as integer

	realfunct3 = arg1( 1234 )

end function
