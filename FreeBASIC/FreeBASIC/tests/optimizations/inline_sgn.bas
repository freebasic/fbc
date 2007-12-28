# include "fbcu.bi"

#include once "crt/math.bi"

namespace fbc_tests.optimizations.inline_sgn

function hSgnF( byval v as single ) as single
	if( v = 0 ) then
		function = 0
	elseif( v > 0 ) then
		function = 1
	else
		function = -1
	end if
end function

function hSgnD( byval v as double ) as double
	if( v = 0 ) then
		function = 0
	elseif( v > 0 ) then
		function = 1
	else
		function = -1
	end if
end function

sub test_1 cdecl
	
	for v as single = -3 to 3 step .03
		CU_ASSERT( sgn( v ) = hSgnF( v ) )
	next
	
	for v as double = -3 to 3 step .03
		CU_ASSERT( sgn( v ) = hSgnD( v ) )
	next
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests-optimizations:inline sgn")
	fbcu.add_test("1", @test_1)
	
end sub

end namespace

