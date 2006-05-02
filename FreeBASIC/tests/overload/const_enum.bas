option explicit

enum 
	RES_FOO
	RES_INT
	RES_DBL
end enum

enum foo 
   a, b, c 
end enum 

const as foo bar_a = a, bar_b = b, bar_c = c
const bar_i as integer = a
const bar_d# = b
                 
function foo overload( byval x as foo )
	function = RES_FOO
end function

function foo overload( byval x as integer )
	function = RES_INT
end function

function foo overload( byval x as double )
	function = RES_DBL
end function

	assert( foo( bar_a ) = RES_FOO )
	assert( foo( bar_i ) = RES_INT )
	assert( foo( bar_d ) = RES_DBL )
