#include "fbcu.bi"

namespace fbc_tests.functions.ignore_result

dim shared as integer cinteger
private function finteger( ) as integer
	cinteger += 1
	function = 1
end function

dim shared as integer cbyrefinteger
private function fbyrefinteger( ) byref as integer
	cbyrefinteger += 1
	static i as integer
	function = i
end function

private sub test cdecl( )
	'' Testing calls ignoring results as statement alone in a line, and
	'' in between ':' statement separators

	CU_ASSERT( cinteger    = 0 ) : finteger( )    : CU_ASSERT( cinteger    = 1 )
	finteger( )
	CU_ASSERT( cinteger    = 2 )
	cuint( finteger( ) )
	CU_ASSERT( cinteger    = 3 )

	'' Byref results
	CU_ASSERT( cbyrefinteger    = 0 ) : fbyrefinteger( )    : CU_ASSERT( cbyrefinteger    = 1 )
	fbyrefinteger( )
	CU_ASSERT( cbyrefinteger    = 2 )
	cuint( fbyrefinteger( ) )
	CU_ASSERT( cbyrefinteger    = 3 )

	'' Same with function pointers
	dim pinteger         as function( ) as integer          = @finteger
	dim pbyrefinteger    as function( ) byref as integer    = @fbyrefinteger

	CU_ASSERT( cinteger    = 3 ) : pinteger( )    : CU_ASSERT( cinteger    = 4 )
	pinteger( )
	CU_ASSERT( cinteger    = 5 )
	cuint( pinteger( ) )
	CU_ASSERT( cinteger    = 6 )

	'' Byref results
	CU_ASSERT( cbyrefinteger    = 3 ) : pbyrefinteger( )    : CU_ASSERT( cbyrefinteger    = 4 )
	pbyrefinteger( )
	CU_ASSERT( cbyrefinteger    = 5 )
	cuint( pbyrefinteger( ) )
	CU_ASSERT( cbyrefinteger    = 6 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/functions/ignore-result" )
	fbcu.add_test( "test", @test )
end sub

end namespace
