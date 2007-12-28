#include "fbcu.bi"

namespace fbc_tests.dim_.redim_

	dim shared foo() as integer
	
	dim shared as integer globcnt

Type T
       
        As Integer a, b, c, d
        Declare Constructor()
       
End Type

Constructor T()
		globcnt += 1
End Constructor

sub test1
	redim foo(1 to 2)
end sub

sub test2
	redim foo(3 to 4) as integer
end sub

sub test3
	redim foo(-1 to 1) as double
end sub

sub test4 cdecl
	scope
		dim bar() as T ptr
		redim bar(1) as T ptr
		CU_ASSERT_EQUAL( globcnt, 0 )
	end scope

	scope
		dim bar () as T
		redim bar(0 to 1) as T
		CU_ASSERT_EQUAL( globcnt, 2 )
	end scope
end sub

sub test cdecl
	test1
	CU_ASSERT_EQUAL( lbound(foo), 1 )
	CU_ASSERT_EQUAL( ubound(foo), 2 )
	
	test2
	CU_ASSERT_EQUAL( lbound(foo), 3 )
	CU_ASSERT_EQUAL( ubound(foo), 4 )
	
	test3
	CU_ASSERT_EQUAL( lbound(foo), 3 )
	CU_ASSERT_EQUAL( ubound(foo), 4 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.redim")
	fbcu.add_test("test", @test)
	fbcu.add_test("test4", @test4)

end sub
end namespace