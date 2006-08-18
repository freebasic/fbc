''
'' namespace re-implementation + USING test
''



const TEST_T1 = -123
const TEST_T2 = 123

namespace foo 

	type t1
		field1 as byte 
	end type 

end namespace 

namespace bar 

	using foo 
	
	sub foobar overload (byval parm1 as t1)
		assert( parm1.field1 = TEST_T1 )
	end sub 

end namespace 

namespace foo 

	type t2
		field1 as ubyte
	end type 

end namespace 

namespace bar 

	using foo
	
	sub foobar overload (byval parm1 as t2)
		assert( parm1.field1 = TEST_T2 )
	end sub 

end namespace

	
	bar.foobar( type<foo.t1>( TEST_T1 ) )
	bar.foobar( type<foo.t2>( TEST_T2 ) )

