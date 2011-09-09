''
'' namespace re-implementation + USING test
''

# include "fbcu.bi"

const TEST_T1 = -123
const TEST_T2 = 123

namespace fbc_tests.ns.reimp2.foo 

	type t1
		field1 as byte 
	end type 

end namespace 

namespace fbc_tests.ns.reimp2.bar 

	using foo 
	
	sub foobar overload (byval parm1 as t1)
		CU_ASSERT( parm1.field1 = TEST_T1 )
	end sub 

end namespace 

namespace fbc_tests.ns.reimp2.foo 

	type t2
		field1 as ubyte
	end type 

end namespace 

	'' imported before the re-implementation
	using fbc_tests.ns.reimp2.bar

namespace fbc_tests.ns.reimp2.bar 

	using foo
	
	sub foobar overload (byval parm1 as t2)
		CU_ASSERT( parm1.field1 = TEST_T2 )
	end sub 

end namespace

private sub test cdecl
	'' t1 and t2 imported indirectly from the "using foo" inside the bar namespace
	foobar( type<t1>( TEST_T1 ) )
	foobar( type<t2>( TEST_T2 ) )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.reimp2")
	fbcu.add_test("test", @test)
	
end sub

