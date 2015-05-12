# include "fbcu.bi"

namespace fbc_tests.optimizations.nop

dim shared as integer x = 0

sub test cdecl()
	dim as integer i, j

	'' Expression should be optimized to plain "j" variable access
	if j or (i and 0) then
		'' Should not be reached
		x = 333
	end if
	CU_ASSERT( x = 0 )

	j = 1
	if j or (i and 0) then
		x = 333
	end if
	CU_ASSERT( x = 333 )
end sub

private sub ctor() constructor
	fbcu.add_suite("fbc_tests.optimizations.nop")
	fbcu.add_test("test", @test)
end sub

end namespace
