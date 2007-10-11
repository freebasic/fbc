
# include "fbcu.bi"

namespace fbc_tests.overload_.op_concat

type foo
	as integer value = any
	declare operator cast() as string
end type

operator foo.cast( ) as string
	return str( value )
end operator

operator & ( byref l as foo, byref r as foo ) as string
	return str( l ) & "|" & str( r )
end operator

sub test_foo cdecl
	dim as foo l = ( 1 ) , r = ( 2 ) 
	
	CU_ASSERT_EQUAL( l & r, "1|2" )
end sub

type bar
	as string strdata
	declare constructor( byval s as zstring ptr )
	declare operator cast() as string
	declare operator &= ( byref r as bar )
end type

constructor bar( byval s as zstring ptr )
	strdata = *s
end constructor

operator bar.cast( ) as string
	return strdata
end operator

operator bar.&= ( byref r as bar )
	strdata &= "|" & r.strdata
end operator

sub test_bar cdecl
	dim as bar l = bar( "abc" ), r = bar( "def" )
	
	l &= r

	CU_ASSERT_EQUAL( l, "abc|def" )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:op_concat")
	fbcu.add_test("test_foo", @test_foo)
	fbcu.add_test("test_bar", @test_bar)

end sub

end namespace
