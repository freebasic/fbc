# include "fbcu.bi"

namespace fbc_tests.structs.ctor_union

const TEST_F0 = 1234
const TEST_F5 = 5678

type foo
    f0 as integer = TEST_F0
    union
    	f1 as byte
    	f2 as short
    	f3 as integer
    	f4 as double
    end union
    f5 as integer = TEST_F5
end type

sub test_foo cdecl	
	dim f as foo
	
	CU_ASSERT_EQUAL( f.f0, TEST_F0 )
	CU_ASSERT_EQUAL( f.f5, TEST_F5 )
	CU_ASSERT_EQUAL( f.f4, 0.0 )
	
end sub

union bar
    f0 as integer
    type
    	f1 as byte
    	f2 as short
    	f3 as integer
    	f4 as double
    end type
    f5 as longint
    declare constructor
end union

constructor bar
	'' do nothing, field should be cleared automatically
end constructor

sub test_bar cdecl	
	dim b as bar
	
	CU_ASSERT_EQUAL( b.f0, 0 )
	CU_ASSERT_EQUAL( b.f4, 0.0 )
	CU_ASSERT_EQUAL( b.f5, 0 )
	
end sub


private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.ctor_union")
	fbcu.add_test( "test foo", @test_foo)
	fbcu.add_test( "test bar", @test_bar)

end sub
	
end namespace