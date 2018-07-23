#include "fbcunit.bi"

#define global .
	
const GLOB_VAL = &hdeadbeef
const LOCA_VAL = &hdeadc0de

private function func( ) as integer
	function = GLOB_VAL
end function

namespace module.ns.glob2
	function func( ) as integer
		function = LOCA_VAL
	end function
end namespace

private sub test_proc( )
	using module.ns.glob2
	
	CU_ASSERT( func( ) = GLOB_VAL )
	CU_ASSERT( .func( ) = GLOB_VAL )
	CU_ASSERT( ..func( ) = GLOB_VAL )
	CU_ASSERT( global.func( ) = GLOB_VAL )
	
	CU_ASSERT( module.ns.glob2.func( ) = LOCA_VAL )
end sub

SUITE( fbc_tests.namespace_.global2 )
	TEST( all )
		test_proc
	END_TEST
END_SUITE
