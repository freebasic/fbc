

type foo as foo_

declare function fun ( byval cnt as integer, _
					   byval a as integer, byval b as integer, byval c as integer ) as foo ptr

type foo_
	a as byte
	b as short
	c as integer
end type


function fun ( byval cnt as integer, _
			   byval a as integer, byval b as integer, byval c as integer ) as foo ptr

	static as foo res
	
	if( cnt = 0 ) then
		with res
			.a = a: .b = b: .c = c
		end with
		function = @res
	else
		function = fun( cnt - 1, a, b, c )
	end if

end function

sub changestack( byval a as integer = 1, byval b as integer = 2, byval c as integer = 3 )
	dim as integer i, array(1 to 100)
	for i = 1 to 100
		array(i) = -i
	next
end sub

	dim as foo ptr res = fun( 10, 1, 2, 3 )
	
	changestack( )
	
	assert( res->a = 1 ) : assert( res->b = 2 ): assert( res->c = 3 )
	
