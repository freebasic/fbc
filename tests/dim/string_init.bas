# include "fbcu.bi"

namespace fbc_tests.dim_.string_init

sub test1 cdecl
    dim as string s1 = "test"
    dim s2 as string = "test"
    CU_ASSERT( s1 = "test" )
    CU_ASSERT( s2 = "test" )
end sub

sub test2 cdecl
    dim as string * 5 s1 = "test"
    dim s2 as string * 5 = "test"
    CU_ASSERT( s1 = "test" )
    CU_ASSERT( s2 = "test" )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.string_init")
	fbcu.add_test("test 1", @test1)
	fbcu.add_test("test 2", @test2)

end sub

end namespace
