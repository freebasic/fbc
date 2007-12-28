# include "fbcu.bi"

const TEST_VAL = 1234

namespace fbc_tests.ns.multi.lev1.lev2.lev3.lev4.lev5

	dim shared as integer value = TEST_VAL

end namespace

	
private sub test1 cdecl
	CU_ASSERT( fbc_tests.ns.multi.lev1.lev2.lev3.lev4.lev5.value = TEST_VAL )
end sub

private sub test2 cdecl
	using fbc_tests.ns.multi.lev1
	CU_ASSERT( lev2.lev3.lev4.lev5.value = TEST_VAL )
end sub

private sub test3 cdecl
	using fbc_tests.ns.multi.lev1.lev2
	CU_ASSERT( lev3.lev4.lev5.value = TEST_VAL )
end sub

private sub test4 cdecl
	using fbc_tests.ns.multi.lev1.lev2.lev3
	CU_ASSERT( lev4.lev5.value = TEST_VAL )
end sub

private sub test5 cdecl
	using fbc_tests.ns.multi.lev1.lev2.lev3.lev4
	CU_ASSERT( lev5.value = TEST_VAL )
end sub

private sub test6 cdecl
	using fbc_tests.ns.multi.lev1.lev2.lev3.lev4.lev5
	CU_ASSERT( value = TEST_VAL )
end sub


private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.multi_nested")
	fbcu.add_test("test 1", @test1)
	fbcu.add_test("test 2", @test2)
	fbcu.add_test("test 3", @test3)
	fbcu.add_test("test 4", @test4)
	fbcu.add_test("test 5", @test5)
	fbcu.add_test("test 6", @test6)
	
end sub
