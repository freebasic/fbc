#include "fbcu.bi"

redim shared foo(1 to 2) as integer

namespace fbc_tests.ns.redim_

private sub test1
	CU_ASSERT_EQUAL( ubound(foo),  2 )
        
    '' global (VB quirk)
    redim foo(1 to 3)
    CU_ASSERT_EQUAL( ubound(foo),  3 )
end sub
    
private sub test2
	CU_ASSERT_EQUAL( ubound(foo),  3 )
        
    if 1 = 1 then
    	'' global (QB quirk)
    	redim foo(1 to 4) as integer
        CU_ASSERT_EQUAL( ubound(foo),  4 )
	end if
        
    CU_ASSERT_EQUAL( ubound(foo),  4 )
        
    redim foo(1 to 5)
    CU_ASSERT_EQUAL( ubound(foo),  5 )
end sub

private sub test3
	'' local
	redim foo(0) as double
    CU_ASSERT_EQUAL( ubound(foo),  0 )
end sub

private sub test cdecl
	CU_ASSERT_EQUAL( ubound(foo),  2 )

	test1
	CU_ASSERT_EQUAL( ubound(foo),  3 )

	test2
	CU_ASSERT_EQUAL( ubound(foo),  5 )

	test3
	CU_ASSERT_EQUAL( ubound(foo),  5 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.redim2")
	fbcu.add_test("1", @test)

end sub
end namespace