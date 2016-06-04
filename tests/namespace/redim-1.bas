#include "fbcu.bi"

namespace foo
	dim as integer bar()
	
	sub test
		dim as integer i
		
		CU_ASSERT( (ubound(bar) - lbound(bar)) <> 0 )
		
		for i = lbound(bar) to ubound(bar)
			CU_ASSERT_EQUAL( bar(i), i )
		next
	end sub
end namespace

namespace fbc_tests.ns.redim_

sub test1 cdecl
	redim as integer foo.bar(0 to 2)
	
	dim as integer i
	for i = lbound(foo.bar) to ubound(foo.bar)
		foo.bar(i) = i
	next
	
	foo.test
end sub

sub test2 cdecl
	redim foo.bar(3 to 5)
	
	dim as integer i
	for i = lbound(foo.bar) to ubound(foo.bar)
		foo.bar(i) = i
	next
	
	foo.test
end sub

private sub ctor () constructor
	fbcu.add_suite( "fbc_tests.namespace.redim-1" )
	fbcu.add_test("1", @test1)
	fbcu.add_test("2", @test2)
end sub

end namespace
