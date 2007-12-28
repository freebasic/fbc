#include "fbcu.bi"

namespace fbc_tests.quirk.data_fwd

sub test_1 cdecl
	dim as integer i, v

	restore data_1
	for i = 1 to 6
		read v
		CU_ASSERT_EQUAL( v, i )
	next
	
end sub

sub test_2 cdecl
	dim as integer i
	dim as string v

	restore data_2
	for i = 1 to 6
		read v
		CU_ASSERT_EQUAL( v, str(-i) )
	next

end sub

sub test_3 cdecl
	dim as integer i
	dim as double v

	for i = 1 to 6
		read v
		CU_ASSERT_EQUAL( v, i/2 )
	next

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.quirk.data-fwd")
	fbcu.add_test("1", @test_1)
	fbcu.add_test("2", @test_2)
	fbcu.add_test("3", @test_3)

end sub

end namespace

data_1:
data 1
data 2, 3
data 4, 5, 6

data_2:
data "-1"
data "-2", "-3"
data "-4", "-5", "-6"

data_3:
data 1/2, 2/2, 3/2, 4/2, 5/2, 6/2

