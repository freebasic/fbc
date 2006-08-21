

const foo.bar.abc = 1
const foo.baz.abc = 2

namespace ns1

	type bar
		zzz as integer
		abc as integer
	end type

end namespace

namespace ns2

	using ns1
	
	type foo
		bar as bar
	end type
	
	type baz
		baz as ns2.foo
	end type

end namespace

namespace ns3

	namespace ns1

		type baz1
			zzz as double
		end type
	
	end namespace
	
	namespace ns1
		
		type baz2
			xxx as byte
		end type
	end namespace

end namespace

'' main	
	using ns2

	dim foo as foo

	CU_ASSERT( len( foo ) = len( ns2.foo ) )
	foo.bar.abc = len( ns3.ns1.baz1 )
	CU_ASSERT( foo.bar.abc = len( ns3.ns1.baz1 ) )

''
private sub func
	dim foo as ns2.foo
	CU_ASSERT( len( foo ) = len( ns2.foo ) )

	foo.bar.abc = len( ns3.ns1.baz2 )
	CU_ASSERT( foo.bar.abc = len( ns3.ns1.baz2 ) )
end sub

	func