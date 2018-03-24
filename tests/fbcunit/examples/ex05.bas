/'
	fbcunit example

		- disable the helper macros
		- add the suite and tests directly using
		  fbcu interface
		- !!! currently, fbcunit does not check
		  return value of init/cleanup procs
'/

#define FBCU_ENABLE_MACROS 0

#include once "fbcunit.bi"

namespace ex05

	function init cdecl () as long 
		function = true
	end function

	function cleanup cdecl () as long 
		function = true
	end function

	sub test1 cdecl ()
		CU_ASSERT( true )
	end sub

	sub test2 cdecl ()
		CU_ASSERT( true )
	end sub

	sub ctor cdecl () constructor
		#define SUITE_NAME "ex05"
		fbcu.add_suite( SUITE_NAME, @init, @cleanup )
		fbcu.add_test( SUITE_NAME, "test1", @test1 )
		fbcu.add_test( SUITE_NAME, "test2", @test2 )
	end sub

end namespace

fbcu.run_tests
