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

sub testAnonPadding cdecl()
	type A
		union
			type
				as short s
				as byte b1
			end type
		end union
		as byte b2
	end type
	CU_ASSERT(sizeof(A) = 6)
	CU_ASSERT(offsetof(A, b2) = 4)

	type B
		union
			type
				as longint l
				as integer i1
			end type
		end union
		as integer i2
	end type
	#ifdef __FB_WIN32__
		CU_ASSERT(sizeof(B) = 24)
		CU_ASSERT(offsetof(B, i2) = 16)
	#else
		CU_ASSERT(sizeof(B) = 16)
		CU_ASSERT(offsetof(B, i2) = 12)
	#endif
end sub

private sub ctor () constructor

	fbcu.add_suite("tests/structs/anon_align")
	fbcu.add_test("size", @test_size)
	fbcu.add_test("offset", @test_ofs)

end sub

end namespace