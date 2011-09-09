# include "fbcu.bi"

namespace fbc_tests.structs.obj_field_ini_array_nested

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

''
type foo field = 1
	pad as integer
    f1(0 to 2) as ubyte 
    f2(0 to 2) as ushort 
    f3(0 to 1) as uinteger 
end type

''
type bar field = 1
	pad as integer
	f(0 to 1) as foo
end type

''
type foobar field = 1
	pad as integer = 1234
	b( 0 to 1 ) as bar = { _
		/' b(0) '/ _
		( _
			/' pad '/ _
			111, _
			{ _
				/' f(0) '/ _
				( 222, _
					{ TEST_F1_0, TEST_F1_1, TEST_F1_2 }, _
					{ TEST_F2_0, TEST_F2_1, TEST_F2_2 }, _
					{ TEST_F3_0, TEST_F3_1 } _
				), _
				/' f(1) '/ _
				( 333, _
					{ TEST_F1_0 + 1, TEST_F1_1 + 1, TEST_F1_2 + 1 }, _
					{ TEST_F2_0 + 1, TEST_F2_1 + 1, TEST_F2_2 + 1 }, _
					{ TEST_F3_0 + 1, TEST_F3_1 + 1 } _
				) _
			} _
		), _
		/' b(1) '/ _
		( _
			/' pad '/ _
			444, _
			{ _
				/' f(0) '/ _
				( 555, _
					{ TEST_F1_0 + 2, TEST_F1_1 + 2, TEST_F1_2 + 2 }, _
					{ TEST_F2_0 + 2, TEST_F2_1 + 2, TEST_F2_2 + 2 }, _
					{ TEST_F3_0 + 2, TEST_F3_1 + 2 } _
				), _
				/' f(1) '/ _
				( 666, _
					{ TEST_F1_0 + 3, TEST_F1_1 + 3, TEST_F1_2 + 3 }, _
					{ TEST_F2_0 + 3, TEST_F2_1 + 3, TEST_F2_2 + 3 }, _
					{ TEST_F3_0 + 3, TEST_F3_1 + 3 } _
				) _
			} _
		) _
	}
end type

''
sub test cdecl 
    dim f as foobar

    CU_ASSERT_EQUAL( f.pad            , 1234 )
    
	'' --- b(0)

	CU_ASSERT_EQUAL( f.b(0).pad       , 111 )

	'' --- b(0).f(0)
    CU_ASSERT_EQUAL( f.b(0).f(0).pad  , 222 )

    '' ubyte
    CU_ASSERT_EQUAL( f.b(0).f(0).f1(0), TEST_F1_0 )
    CU_ASSERT_EQUAL( f.b(0).f(0).f1(1), TEST_F1_1 )
    CU_ASSERT_EQUAL( f.b(0).f(0).f1(2), TEST_F1_2 )
  
    '' ushort
    CU_ASSERT_EQUAL( f.b(0).f(0).f2(0), TEST_F2_0 )
    CU_ASSERT_EQUAL( f.b(0).f(0).f2(1), TEST_F2_1 )
    CU_ASSERT_EQUAL( f.b(0).f(0).f2(2), TEST_F2_2 )
  
    '' uinteger
    CU_ASSERT_EQUAL( f.b(0).f(0).f3(0), TEST_F3_0 )
    CU_ASSERT_EQUAL( f.b(0).f(0).f3(1), TEST_F3_1 )

	'' --- b(0).f(1)
    CU_ASSERT_EQUAL( f.b(0).f(1).pad  , 333 )

    '' ubyte
    CU_ASSERT_EQUAL( f.b(0).f(1).f1(0), TEST_F1_0 + 1 )
    CU_ASSERT_EQUAL( f.b(0).f(1).f1(1), TEST_F1_1 + 1 )
    CU_ASSERT_EQUAL( f.b(0).f(1).f1(2), TEST_F1_2 + 1 )
  
    '' ushort
    CU_ASSERT_EQUAL( f.b(0).f(1).f2(0), TEST_F2_0 + 1 )
    CU_ASSERT_EQUAL( f.b(0).f(1).f2(1), TEST_F2_1 + 1 )
    CU_ASSERT_EQUAL( f.b(0).f(1).f2(2), TEST_F2_2 + 1 )
  
    '' uinteger
    CU_ASSERT_EQUAL( f.b(0).f(1).f3(0), TEST_F3_0 + 1 )
    CU_ASSERT_EQUAL( f.b(0).f(1).f3(1), TEST_F3_1 + 1 )

	'' --- b(1)

	CU_ASSERT_EQUAL( f.b(1).pad       , 444 )

	'' --- b(1).f(0)
    CU_ASSERT_EQUAL( f.b(1).f(0).pad  , 555 )

    '' ubyte
    CU_ASSERT_EQUAL( f.b(1).f(0).f1(0), TEST_F1_0 + 2 )
    CU_ASSERT_EQUAL( f.b(1).f(0).f1(1), TEST_F1_1 + 2 )
    CU_ASSERT_EQUAL( f.b(1).f(0).f1(2), TEST_F1_2 + 2 )
  
    '' ushort
    CU_ASSERT_EQUAL( f.b(1).f(0).f2(0), TEST_F2_0 + 2 )
    CU_ASSERT_EQUAL( f.b(1).f(0).f2(1), TEST_F2_1 + 2 )
    CU_ASSERT_EQUAL( f.b(1).f(0).f2(2), TEST_F2_2 + 2 )
  
    '' uinteger
    CU_ASSERT_EQUAL( f.b(1).f(0).f3(0), TEST_F3_0 + 2 )
    CU_ASSERT_EQUAL( f.b(1).f(0).f3(1), TEST_F3_1 + 2 )

	'' --- b(1).f(1)
    CU_ASSERT_EQUAL( f.b(1).f(1).pad  , 666 )

    '' ubyte
    CU_ASSERT_EQUAL( f.b(1).f(1).f1(0), TEST_F1_0 + 3 )
    CU_ASSERT_EQUAL( f.b(1).f(1).f1(1), TEST_F1_1 + 3 )
    CU_ASSERT_EQUAL( f.b(1).f(1).f1(2), TEST_F1_2 + 3 )
  
    '' ushort
    CU_ASSERT_EQUAL( f.b(1).f(1).f2(0), TEST_F2_0 + 3 )
    CU_ASSERT_EQUAL( f.b(1).f(1).f2(1), TEST_F2_1 + 3 )
    CU_ASSERT_EQUAL( f.b(1).f(1).f2(2), TEST_F2_2 + 3 )
  
    '' uinteger
    CU_ASSERT_EQUAL( f.b(1).f(1).f3(0), TEST_F3_0 + 3 )
    CU_ASSERT_EQUAL( f.b(1).f(1).f3(1), TEST_F3_1 + 3 )


end sub

''
private sub ctor () constructor

    fbcu.add_suite("fb-tests-structs:obj_field_ini_array_nested")
    fbcu.add_test( "test", @test)

end sub
	
end namespace
