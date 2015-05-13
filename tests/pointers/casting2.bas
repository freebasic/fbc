# include "fbcu.bi"

namespace fbc_tests.pointers.casting2

sub test cdecl ()
	dim array(0 to 9) as long = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

	dim pt as long ptr

	pt = @array(1)

	cptr(short ptr, pt) += 1

	CU_ASSERT_EQUAL( *pt, (array(2) and &hffff) shl 16 or (array(1) shr 16) )
end sub

private sub ctor () constructor
	fbcu.add_suite("fbc_tests.pointers.casting2")
	fbcu.add_test("test", @test)
end sub

end namespace
