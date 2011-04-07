#include "fbcu.bi"

namespace fbc_tests.quirk.data_fwd2

sub test_1 cdecl
	
	'' blank restore, no DATA's parsed yet
	restore 
        
	for i as integer = 1 to 6
		dim as integer value
		read value
		CU_ASSERT_EQUAL( i, value )
    next

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.quirk.data-fwd2")
	fbcu.add_test("#1", @test_1)

end sub

end namespace

data 1
data 2, 3
data 4, 5, 6


