#include "fbcu.bi"

namespace fbc_tests.quirk.sizeof_typeof

    type UDT
        as integer a
        as byte b
        as string c
    end type

	sub deref cdecl( )

        '' This was the example given in the bug report
        dim p as string ptr
        CU_ASSERT_EQUAL( sizeof(typeof(*p)), sizeof(string) )

        #define derefTest(T) CU_ASSERT_EQUAL( sizeof(typeof(*cptr(T ptr, 123))), sizeof(T) )

        derefTest( integer )
        derefTest( byte )
        derefTest( string )
        derefTest( UDT )

	end sub

    sub otherOps cdecl( )

        '' Before the fix any op expression would cause typeof() to return a
        '' zero length

        CU_ASSERT_EQUAL( sizeof(typeof(cptr(UDT ptr, 123)->a)), sizeof(integer) )
        CU_ASSERT_EQUAL( sizeof(typeof(cptr(UDT ptr, 123)->b)), sizeof(byte) )
        CU_ASSERT_EQUAL( sizeof(typeof(cptr(UDT ptr, 123)->c)), sizeof(string) )

        dim as integer a
        CU_ASSERT_EQUAL( sizeof(typeof(a + 5)), sizeof(integer) )
        CU_ASSERT_EQUAL( sizeof(typeof(a and 5)), sizeof(integer) )

        dim as integer ptr p
        CU_ASSERT_EQUAL( sizeof(typeof(p[1])), sizeof(integer) )

    end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.quirk.sizeof_typeof")
		fbcu.add_test("deref", @deref)
		fbcu.add_test("otherOps", @otherOps)
	
	end sub

end namespace
