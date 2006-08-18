

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678

'' interface
namespace ns

	type foo_ as foo
	
	declare function bar( byval f as foo_ ptr ) as integer

end namespace

'' implementation

namespace ns

	type foo
		f as integer
	end type
	
	function bar( byval f as foo_ ptr ) as integer
		function = f->f + 1
	end function
	
end namespace

	dim f as ns.foo = ( TEST_VAL1 )
	assert( ns.bar( @f ) = TEST_VAL1 + 1 )
	
	scope
		using ns
		dim f as ns.foo = ( TEST_VAL2 )
		assert( ns.bar( @f ) = TEST_VAL2 + 1 )
	end scope
	
	assert( ns.bar( @f ) = TEST_VAL1 + 1 )
	
	
