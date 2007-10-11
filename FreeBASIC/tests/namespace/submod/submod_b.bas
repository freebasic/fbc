' TEST_MODE : MULTI_MODULE_TEST

#include "common.bi"

namespace ns

	function test_1( ) as integer
		function = 1
	end function

	function test_2( ) as integer
		function = 2
	end function
	
end namespace
	
extern "c++"

namespace ns_cpp

	function test_1( ) as integer
		function = -1
	end function

	function test_2( ) as integer
		function = -2
	end function
	
end namespace
		
end extern
