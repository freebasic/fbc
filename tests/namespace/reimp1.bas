''
'' namespace re-implementation + USING test
''

# include "fbcu.bi"

const TEST_T1 = -123
const TEST_T2 = 123

namespace fbc_tests.ns.reimp1.foo 

	type t1
		field1 as byte 
	end type 

end namespace 

namespace fbc_tests.ns.reimp1.bar 

	using foo 
	
	sub foobar overload (byval parm1 as t1)
		CU_ASSERT( parm1.field1 = TEST_T1 )
	end sub 

end namespace 

namespace fbc_tests.ns.reimp1.foo 

	type t2
		field1 as ubyte
	end type 

end namespace 

namespace fbc_tests.ns.reimp1.bar 

	using foo
	
	sub foobar overload (byval parm1 as t2)
		CU_ASSERT( parm1.field1 = TEST_T2 )
	end sub 

end namespace

private sub test_proc cdecl
	fbc_tests.ns.reimp1.bar.foobar( type<fbc_tests.ns.reimp1.foo.t1>( TEST_T1 ) )
	fbc_tests.ns.reimp1.bar.foobar( type<fbc_tests.ns.reimp1.foo.t2>( TEST_T2 ) )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.reimp1")
	fbcu.add_test("test", @test_proc)
	
end sub
