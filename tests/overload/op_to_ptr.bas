# include "fbcu.bi"

namespace fbc_tests.overload_.op_to_ptr

type foo
    declare operator cast() as double ptr
    declare operator cast() as integer ptr
    
    i as integer = -1234
    d as double = 5678.9
end type

operator foo.cast() as double ptr
    return @d
end operator

operator foo.cast() as integer ptr
    return @i
end operator

sub test_1 cdecl
    dim bar as foo
    
    CU_ASSERT_EQUAL( *cast(integer ptr, bar), -1234 )
    CU_ASSERT_EQUAL( *cast(double ptr, bar), 5678.9 )
    
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:op-to-ptr")
	fbcu.add_test("1", @test_1)

end sub

end namespace
