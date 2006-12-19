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
sub test_1 cdecl
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

type mytype
	as integer a, b
	as short c(0 to 2)
	as byte d
end type

sub test_2 cdecl
	static arraytype(10) as mytype => { ( 1, 2, { 3, 4, 5 }, 6 ), ( 1*2, 2*2, { 3*2, 4*2, 5*2 }, 6*2 ) }
	
	CU_ASSERT_EQUAL( arraytype(0).c(1), 4 )
	CU_ASSERT_EQUAL( arraytype(0).d, 6 )
	CU_ASSERT_EQUAL( arraytype(1).c(1), 4*2 )
	CU_ASSERT_EQUAL( arraytype(1).d, 6*2 )
	
end sub

sub test_3 cdecl
	dim arraytype(10) as mytype => { ( 1, 2, { 3, 4, 5 }, 6 ), ( 1*2, 2*2, { 3*2, 4*2, 5*2 }, 6*2 ) }
	
	CU_ASSERT_EQUAL( arraytype(0).c(1), 4 )
	CU_ASSERT_EQUAL( arraytype(0).d, 6 )
	CU_ASSERT_EQUAL( arraytype(1).c(1), 4*2 )
	CU_ASSERT_EQUAL( arraytype(1).d, 6*2 )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.udt_init")
	fbcu.add_test("1", @test_1)
	fbcu.add_test("2", @test_2)
	fbcu.add_test("3", @test_3)

end sub

end namespace
	