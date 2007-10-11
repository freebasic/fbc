# include "fbcu.bi"

#define global .
	
const GLOB_VAL = &hdeadbeef
const LOCA_VAL = &hdeadc0de

private function func( ) as integer
	function = GLOB_VAL
end function

namespace fbc_tests.ns.glob2
	function func( ) as integer
		function = LOCA_VAL
	end function
end namespace

private sub test cdecl
	using fbc_tests.ns.glob2
	
	CU_ASSERT( func( ) = GLOB_VAL )
	CU_ASSERT( .func( ) = GLOB_VAL )
	CU_ASSERT( ..func( ) = GLOB_VAL )
	CU_ASSERT( global.func( ) = GLOB_VAL )
	
	CU_ASSERT( fbc_tests.ns.glob2.func( ) = LOCA_VAL )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.global2")
	
	fbcu.add_test("test", @test)
	
end sub
