option explicit

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
	
	assert( func( ) = GLOB_VAL )
	assert( .func( ) = GLOB_VAL )
	assert( ..func( ) = GLOB_VAL )
	assert( global.func( ) = GLOB_VAL )
	
	assert( ns.func( ) = LOCA_VAL )