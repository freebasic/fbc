# include "fbcu.bi"

namespace fbc_tests.structs.obj_field_ini_array

'' ubyte
const TEST_F1_0 = &h11
const TEST_F1_1 = &h12
const TEST_F1_2 = &h13

'' ushort
const TEST_F2_0 = &h2122
const TEST_F2_1 = &h2324
const TEST_F2_2 = &h2526

'' uinteger
const TEST_F3_0 = &h31323334
const TEST_F3_1 = &h35363738

'' uinteger
const TEST_F4_1 = &h41424344
const TEST_F4_2 = &h45464748

'' string
const TEST_F5_0 = "First"
const TEST_F5_1 = "Second"

''
type foo field = 1
	pad as integer = 1234
    f1(0 to 2) as ubyte = { TEST_F1_0, TEST_F1_1, TEST_F1_2 }
    f2(0 to 2) as ushort = { TEST_F2_0, TEST_F2_1, TEST_F2_2 }
    f3(0 to 1) as uinteger = { TEST_F3_0, TEST_F3_1 }
    f4(1 to 2) as uinteger = { TEST_F4_1, TEST_F4_2 }
    f5(0 to 1) as string = { TEST_F5_0, TEST_F5_1 }
end type

''
type bar field = 1
	f1 as ubyte
	f2 as ushort
	f3 as uinteger
end type

''
type baz field = 1
	pad as integer = 5678
	b1( 0 to 1 ) as bar = { _
		(TEST_F1_0, TEST_F2_0, TEST_F3_0), _
		(TEST_F1_1, TEST_F2_1, TEST_F3_1) _
	}
	b2( 0 to 1 ) as bar = { _
		(TEST_F1_1, TEST_F2_1, TEST_F3_1),_
		(TEST_F1_0, TEST_F2_0, TEST_F3_0) _
	}
end type

''
sub test1 cdecl 
    dim f as foo

    CU_ASSERT_EQUAL( f.pad, 1234 )
  
    '' ubyte
    CU_ASSERT_EQUAL( f.f1(0), TEST_F1_0 )
    CU_ASSERT_EQUAL( f.f1(1), TEST_F1_1 )
    CU_ASSERT_EQUAL( f.f1(2), TEST_F1_2 )
  
    '' ushort
    CU_ASSERT_EQUAL( f.f2(0), TEST_F2_0 )
    CU_ASSERT_EQUAL( f.f2(1), TEST_F2_1 )
    CU_ASSERT_EQUAL( f.f2(2), TEST_F2_2 )
  
    '' uinteger
    CU_ASSERT_EQUAL( f.f3(0), TEST_F3_0 )
    CU_ASSERT_EQUAL( f.f3(1), TEST_F3_1 )

    '' uinteger
    CU_ASSERT_EQUAL( f.f4(1), TEST_F4_1 )
    CU_ASSERT_EQUAL( f.f4(2), TEST_F4_2 )

    ''string
    CU_ASSERT_EQUAL( f.f5(0), TEST_F5_0 )
    CU_ASSERT_EQUAL( f.f5(1), TEST_F5_1 )
	
end sub

''
sub test2 cdecl 
    dim f as baz

    CU_ASSERT_EQUAL( f.pad, 5678 )
  
    CU_ASSERT_EQUAL( f.b1(0).f1, TEST_F1_0 )
    CU_ASSERT_EQUAL( f.b1(0).f2, TEST_F2_0 )
    CU_ASSERT_EQUAL( f.b1(0).f3, TEST_F3_0 )

    CU_ASSERT_EQUAL( f.b1(1).f1, TEST_F1_1 )
    CU_ASSERT_EQUAL( f.b1(1).f2, TEST_F2_1 )
    CU_ASSERT_EQUAL( f.b1(1).f3, TEST_F3_1 )

    CU_ASSERT_EQUAL( f.b2(0).f1, TEST_F1_1 )
    CU_ASSERT_EQUAL( f.b2(0).f2, TEST_F2_1 )
    CU_ASSERT_EQUAL( f.b2(0).f3, TEST_F3_1 )

    CU_ASSERT_EQUAL( f.b2(1).f1, TEST_F1_0 )
    CU_ASSERT_EQUAL( f.b2(1).f2, TEST_F2_0 )
    CU_ASSERT_EQUAL( f.b2(1).f3, TEST_F3_0 )

end sub

''
private sub ctor () constructor

    fbcu.add_suite("fb-tests-structs:obj_field_ini_array")
    fbcu.add_test( "test1", @test1)
    fbcu.add_test( "test2", @test2)

end sub
	
end namespace
