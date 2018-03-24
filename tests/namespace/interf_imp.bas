#include "fbcunit.bi"

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678

'' interface
namespace module.ns.interf_imp

	type foo_ as foo
	
	declare function bar( byval f as foo_ ptr ) as integer

end namespace

'' implementation

namespace module.ns.interf_imp

	type foo
		f as integer
	end type
	
	function bar( byval f as foo_ ptr ) as integer
		function = f->f + 1
	end function
	
end namespace

private sub test_proc
	dim f as module.ns.interf_imp.foo = ( TEST_VAL1 )
	CU_ASSERT( module.ns.interf_imp.bar( @f ) = TEST_VAL1 + 1 )
	
	scope
		using module.ns.interf_imp
		dim f as module.ns.interf_imp.foo = ( TEST_VAL2 )
		CU_ASSERT( module.ns.interf_imp.bar( @f ) = TEST_VAL2 + 1 )
	end scope
	
	CU_ASSERT( module.ns.interf_imp.bar( @f ) = TEST_VAL1 + 1 )
end sub

SUITE( fbc_tests.namespace_.interf_imp )
	TEST( all )
		test_proc
	END_TEST
END_SUITE
