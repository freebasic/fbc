type rational
   num as integer 
   den as integer 
end type 

#define radd_num(l,r) ((l.num * r.den) + (l.den * r.num))
#define radd_den(l,r) ((l.den * r.den))

'':::::
function add( lhs as rational, rhs as rational ) as rational 
	dim as rational res
	
	res.num = lhs.num * rhs.den + lhs.den * rhs.num
	res.den = lhs.den * rhs.den
	
	function = res

end function 

'':::::
sub test
	dim as rational rt(0 to 1) = _
	{ _
		add( type(1,2)   , type(3,4)   ), _
		add( type(-1,-2) , type(-3,-4) ) _
	}
	
	dim as rational l(0 to 1), r(0 to 1)
	
	l(0).num = 1: l(0).den = 2
	r(0).num = 3: r(0).den = 4
	l(1).num = -1: l(1).den = -2
	r(1).num = -3: r(1).den = -4
	
	assert( rt(0).num = radd_num( l(0), r(0) ) )
	assert( rt(0).den = radd_den( l(0), r(0) ) )
	assert( rt(1).num = radd_num( l(1), r(1) ) )
	assert( rt(1).den = radd_den( l(1), r(1) ) )
	
end sub

	test