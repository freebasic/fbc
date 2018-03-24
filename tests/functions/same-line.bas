#include "fbcunit.bi"

SUITE( fbc_tests.functions.same_line )

	'' Should compile fine, even under -g
	sub f1( )
	end sub : sub f2( )
	end sub

	function f3( ) as integer
		function = 3
	end function : function f4( ) as integer
		function = 4
	end function

	'' procedures closed/opened on the same line
	TEST( default )
		f1( )
		f2( )
		CU_ASSERT( f3( ) = 3 )
		CU_ASSERT( f4( ) = 4 )
	END_TEST

END_SUITE
