#include "fbcu.bi"

namespace fbc_tests.functions.sameline

'' Should compile fine, even under -g
sub f1( )
end sub : sub f2( )
end sub

function f3( ) as integer
	function = 3
end function : function f4( ) as integer
	function = 4
end function

sub test cdecl( )
	f1( )
	f2( )
	CU_ASSERT( f3( ) = 3 )
	CU_ASSERT( f4( ) = 4 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/functions/sameline" )
	fbcu.add_test( "procedures closed/opened on the same line" , @test  )
end sub

end namespace
