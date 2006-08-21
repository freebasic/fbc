# include "fbcu.bi"

namespace fbc_tests.dim_.udt_init

type rational
   num as integer 
   den as integer 
end type 

#define radd_num(l,r) ((l.num * r.den) + (l.den * r.num))
#define radd_den(l,r) ((l.den * r.den))

'':::::
function add( lhs as rational, rhs as rational ) as rational 
	dim as rational res
	
	res.num = radd_num( lhs, rhs )
	res.den = radd_den( lhs, rhs )
	
	function = res

end function 

'':::::
sub test cdecl
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
	
	CU_ASSERT( rt(0).num = radd_num( l(0), r(0) ) )
	CU_ASSERT( rt(0).den = radd_den( l(0), r(0) ) )
	CU_ASSERT( rt(1).num = radd_num( l(1), r(1) ) )
	CU_ASSERT( rt(1).den = radd_den( l(1), r(1) ) )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.udt_init")
	fbcu.add_test("test", @test)

end sub

end namespace
	