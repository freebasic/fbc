# include "fbcu.bi"

namespace fbc_tests.structs.anon_align

type foo1
    padding as long
    union
        type
            field1 as long
        end type
    end union
end type

type foo2
    padding as long
    union
        type
            field1 as long
            field2 as long
        end type
    end union
end type

type foo3
    padding as long
    union
        type
            field1 as long
            field2 as long
            field3 as long
        end type
    end union
end type

type foo4
    padding as long
    union
        type
            field1 as long
            field2 as long
            field3 as long
            field4 as long
        end type
    end union
end type

sub test_size cdecl ()
	CU_ASSERT_EQUAL( len( foo1 ), len( long ) * (1+1) )
	CU_ASSERT_EQUAL( len( foo2 ), len( long ) * (1+2) )
	CU_ASSERT_EQUAL( len( foo3 ), len( long ) * (1+3) )
	CU_ASSERT_EQUAL( len( foo4 ), len( long ) * (1+4) )
end sub

sub test_ofs cdecl ()
	CU_ASSERT_EQUAL( offsetof( foo4, field1 ), len( long ) * (1+0) )
	CU_ASSERT_EQUAL( offsetof( foo4, field2 ), len( long ) * (1+1) )
	CU_ASSERT_EQUAL( offsetof( foo4, field3 ), len( long ) * (1+2) )
	CU_ASSERT_EQUAL( offsetof( foo4, field4 ), len( long ) * (1+3) )
end sub

private sub ctor () constructor

	fbcu.add_suite("tests/structs/anon_align")
	fbcu.add_test("size", @test_size)
	fbcu.add_test("offset", @test_ofs)

end sub

end namespace