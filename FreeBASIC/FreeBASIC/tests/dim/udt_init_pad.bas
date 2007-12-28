# include "fbcu.bi"

namespace fbc_tests.dim_.udt_init_pad

sub test1 cdecl

	dim as integer array(0 to 9) = { 0, 1, 2, 3, 4 }
	
	dim as integer i
	for i = 0 to 4
		CU_ASSERT( array(i) = i )
	next

	for i = 5 to 9
		CU_ASSERT( array(i) = 0 )
	next

end sub

type tudt
	as integer f0, f1, f2, f3, f4, f5
end type

sub test2 cdecl

	dim as tudt udt = ( 0, 1, 2 )
	
	with udt
		CU_ASSERT( .f0 = 0 )
		CU_ASSERT( .f1 = 1 )
		CU_ASSERT( .f2 = 2 )
		CU_ASSERT( .f3 = 0 )
		CU_ASSERT( .f4 = 0 )
		CU_ASSERT( .f5 = 0 )
	end with


end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.udt_init_pad")
	fbcu.add_test("test 1", @test1)
	fbcu.add_test("test 2", @test2)

end sub

end namespace
	