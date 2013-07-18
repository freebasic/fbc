# include "fbcu.bi"

namespace fbc_tests.dim_.static_

sub test1 cdecl
	static as integer array(0 to 3) = { 0, 1, 2, 3 }
	
	dim as integer i
	for i = 0 to 3
		CU_ASSERT( array(i) = i )
	next
	
end sub

sub test2 cdecl static
	dim as integer array(0 to 3) = { 0, 1, 2, 3 }
	
	dim as integer i
	for i = 0 to 3
		CU_ASSERT( array(i) = i )
	next
	
end sub

sub test3 cdecl
	static as integer array()
	
	redim array(0 to 3)

	dim as integer i
	for i = 0 to 3
		array(i) = i
	next
	
	for i = 0 to 3
		CU_ASSERT( array(i) = i )
	next
	
end sub

sub test4 cdecl static
	dim as integer array()
	
	redim array(0 to 3)

	dim as integer i
	for i = 0 to 3
		array(i) = i
	next
	
	for i = 0 to 3
		CU_ASSERT( array(i) = i )
	next
	
end sub

private sub ctor () constructor
	fbcu.add_suite("fbc_tests.dim.static")
	fbcu.add_test("test 1", @test1)
	fbcu.add_test("test 2", @test2)
	fbcu.add_test("test 3", @test3)
	fbcu.add_test("test 4", @test4)
end sub

end namespace
