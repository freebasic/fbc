

#define global .
	
const GLOB_VAL = &hdeadbeef
const LOCA_VAL = &hdeadc0de

function func( ) as integer
	function = GLOB_VAL
end function

namespace ns
	function func( ) as integer
		function = LOCA_VAL
	end function
end namespace

	using ns
	
	CU_ASSERT( func( ) = GLOB_VAL )
	CU_ASSERT( .func( ) = GLOB_VAL )
	CU_ASSERT( ..func( ) = GLOB_VAL )
	CU_ASSERT( global.func( ) = GLOB_VAL )
	
	CU_ASSERT( ns.func( ) = LOCA_VAL )