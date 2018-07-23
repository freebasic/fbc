''
'' namespace re-implementation + USING test
''

#include "fbcunit.bi"

const TEST_T1 = -123
const TEST_T2 = 123

namespace reimp1.foo 

	type t1
		field1 as byte 
	end type 

end namespace 

namespace reimp1.bar 

	using foo 
	
	sub foobar overload (byval parm1 as t1)
		CU_ASSERT( parm1.field1 = TEST_T1 )
	end sub 

end namespace 

namespace reimp1.foo 

	type t2
		field1 as ubyte
	end type 

end namespace 

namespace reimp1.bar 

	using foo
	
	sub foobar overload (byval parm1 as t2)
		CU_ASSERT( parm1.field1 = TEST_T2 )
	end sub 

end namespace

SUITE( fbc_tests.namespace_.reimp1 )
	TEST( all )
		..reimp1.bar.foobar( type<..reimp1.foo.t1>( TEST_T1 ) )
		..reimp1.bar.foobar( type<..reimp1.foo.t2>( TEST_T2 ) )
	END_TEST
END_SUITE
