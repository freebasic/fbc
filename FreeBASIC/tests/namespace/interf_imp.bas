# include "fbcu.bi"

const TEST_VAL1 = 1234
const TEST_VAL2 = 5678

'' interface
namespace fbc_tests.ns.interf_imp

	type foo_ as foo
	
	declare function bar( byval f as foo_ ptr ) as integer

end namespace

'' implementation

namespace fbc_tests.ns.interf_imp

	type foo
		f as integer
	end type
	
	function bar( byval f as foo_ ptr ) as integer
		function = f->f + 1
	end function
	
end namespace

private sub test cdecl	
	dim f as fbc_tests.ns.interf_imp.foo = ( TEST_VAL1 )
	CU_ASSERT( fbc_tests.ns.interf_imp.bar( @f ) = TEST_VAL1 + 1 )
	
	scope
		using fbc_tests.ns.interf_imp
		dim f as fbc_tests.ns.interf_imp.foo = ( TEST_VAL2 )
		CU_ASSERT( fbc_tests.ns.interf_imp.bar( @f ) = TEST_VAL2 + 1 )
	end scope
	
	CU_ASSERT( fbc_tests.ns.interf_imp.bar( @f ) = TEST_VAL1 + 1 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.interf_imp")
	fbcu.add_test("test", @test)
	
end sub
