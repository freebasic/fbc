# include "fbcu.bi"

namespace fbc_tests.functions.bydesc

namespace bydescParamDeclarations
	declare sub f1( () as integer )
	declare sub f2( a2() as integer )

	sub f1( a1() as integer )
	end sub

	sub f2( a2() as integer )
	end sub

	sub f4( a4() as integer )
	end sub
end namespace

namespace test1
	const ARRAY_LB = 0
	const ARRAY_UB = 9

	sub doTest( array() as integer )
		for i as integer = ARRAY_LB to ARRAY_UB
			CU_ASSERT( array(i) = i )
		next
	end sub

	sub doTestPre( array() as integer )
		dotest( array() )
	end sub

	sub fillArray( array() as integer )
		for i as integer = ARRAY_LB to ARRAY_UB
			array(i) = i
		next
	end sub

	sub testLocal cdecl( )
		redim as integer localarray(ARRAY_LB to ARRAY_UB)
		fillArray( localarray() )
		doTest( localarray() )
	end sub

	dim shared as integer globalarray(ARRAY_LB to ARRAY_UB)

	sub testGlobal cdecl( )
		fillArray( globalarray() )
		doTest( globalarray() )
	end sub

	sub testParam cdecl( )
		fillArray( globalarray() )
		doTestPre( globalarray() )
	end sub
end namespace

namespace test2
	const ARRAY_LB1 = 1
	const ARRAY_UB1 = 3
	const ARRAY_LB2 = 2
	const ARRAY_UB2 = 5

	sub doTest( array() as double )
		CU_ASSERT_EQUAL( lbound( array, 1 ), ARRAY_LB1 )
		CU_ASSERT_EQUAL( ubound( array, 1 ), ARRAY_UB1 )
		CU_ASSERT_EQUAL( lbound( array, 2 ), ARRAY_LB2 )
		CU_ASSERT_EQUAL( ubound( array, 2 ), ARRAY_UB2 )
	end sub

	sub doTestPre( array() as double )
		CU_ASSERT_EQUAL( lbound( array, 1 ), ARRAY_LB1 )
		CU_ASSERT_EQUAL( ubound( array, 1 ), ARRAY_UB1 )
		CU_ASSERT_EQUAL( lbound( array, 2 ), ARRAY_LB2 )
		CU_ASSERT_EQUAL( ubound( array, 2 ), ARRAY_UB2 )
		doTest( array() )
	end sub

	sub testLocal cdecl( )
		dim as double localarray(ARRAY_LB1 to ARRAY_UB1, ARRAY_LB2 to ARRAY_UB2)
		doTest( localarray() )
	end sub

	dim shared as double globalarray(ARRAY_LB1 to ARRAY_UB1, ARRAY_LB2 to ARRAY_UB2)

	sub testGlobal cdecl( )
		doTest( globalarray() )
	end sub

	sub testParam cdecl( )
		doTestPre( globalarray() )
	end sub
end namespace

namespace testString
	const ARRAY_LB = 0
	const ARRAY_UB = 9

	sub doTest( array() as string )
		for i as integer = ARRAY_LB to ARRAY_UB
			CU_ASSERT( array(i) = str( i ) )
		next
	end sub

	sub doTestPre( array() as string )
		doTest( array() )
	end sub

	sub fillArray( array() as string )
		for i as integer = ARRAY_LB to ARRAY_UB
			array(i) = str( i )
		next
	end sub

	sub testLocal cdecl( )
		redim as string localarray(ARRAY_LB to ARRAY_UB)
		fillArray( localarray() )
		doTest( localarray() )
	end sub

	dim shared as string globalarray(ARRAY_LB to ARRAY_UB)

	sub testGlobal cdecl( )
		fillArray( globalarray() )
		doTest( globalarray() )
	end sub

	sub testParam cdecl( )
		fillArray( globalarray() )
		doTestPre( globalarray() )
	end sub
end namespace

namespace arrayField
	const ARRAY_LB = 0
	const ARRAY_UB = 9

	type UDT
		field1(ARRAY_LB to ARRAY_UB) as integer
		field2 as integer
	end type

	sub doTest( array() as integer )
		for i as integer = ARRAY_LB to ARRAY_UB
			CU_ASSERT( array(i) = i )
		next
	end sub

	sub fillArray( array() as integer )
		for i as integer = ARRAY_LB to ARRAY_UB
			array(i) = i
		next
	end sub

	sub testLocalUdt cdecl( )
		dim as UDT localudt
		fillArray( localudt.field1() )
		dotest( localudt.field1() )
	end sub

	sub testLocalUdtArray cdecl( )
		redim as UDT localudtarray(0 to 1)
		fillArray( localudtarray(1).field1() )
		doTest( localudtarray(1).field1() )
	end sub

	dim shared as UDT globaludt

	sub testGlobalUdt cdecl( )
		fillArray( globaludt.field1() )
		doTest( globaludt.field1() )
	end sub

	dim shared as UDT globaludtarray(0 to 1)

	sub testGlobalUdtArray cdecl( )
		fillArray( globaludtarray(1).field1() )
		doTest( globaludtarray(1).field1() )
	end sub
end namespace

namespace stringArrayField
	const ARRAY_LB = 0
	const ARRAY_UB = 9

	type UDT
		field1(ARRAY_LB to ARRAY_UB) as string
		field2 as integer
	end type

	sub doTest( array() as string )
		for i as integer = ARRAY_LB to ARRAY_UB
			CU_ASSERT( array(i) = str( i ) )
		next
	end sub

	sub fillArray( array() as string )
		for i as integer = ARRAY_LB to ARRAY_UB
			array(i) = str( i )
		next
	end sub

	sub testLocalUdt cdecl( )
		dim as UDT localudt
		fillArray( localudt.field1() )
		dotest( localudt.field1() )
	end sub

	sub testLocalUdtArray cdecl( )
		redim as UDT localudtarray(0 to 1)
		fillArray( localudtarray(1).field1() )
		doTest( localudtarray(1).field1() )
	end sub

	dim shared as UDT globaludt

	sub testGlobalUdt cdecl( )
		fillArray( globaludt.field1() )
		doTest( globaludt.field1() )
	end sub

	dim shared as UDT globaludtarray(0 to 1)

	sub testGlobalUdtArray cdecl( )
		fillArray( globaludtarray(1).field1() )
		doTest( globaludtarray(1).field1() )
	end sub
end namespace

namespace dynamicArrayOfPointers
	'' -gen gcc regression test (handling of array descriptors if it's an
	'' array of pointers)

	dim shared as integer i0, i1

	sub f( array(any) as integer ptr )
		*array(0) = 123
		*array(1) = 456
		CU_ASSERT( *array(0) = 123 )
		CU_ASSERT( *array(1) = 456 )
	end sub

	sub test cdecl( )
		dim array(any) as integer ptr
		redim array(0 to 1)
		array(0) = @i0
		array(1) = @i1
		CU_ASSERT( i0 = 0 )
		CU_ASSERT( i1 = 0 )

		f( array() )
		CU_ASSERT( i0 = 123 )
		CU_ASSERT( i1 = 456 )

		CU_ASSERT( *array(0) = 123 )
		CU_ASSERT( *array(1) = 456 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/functions/bydesc" )
	fbcu.add_test( "#1 local array" , @test1.testLocal  )
	fbcu.add_test( "#1 global array", @test1.testGlobal )
	fbcu.add_test( "#1 param array" , @test1.testParam  )
	fbcu.add_test( "#2 local array" , @test2.testLocal  )
	fbcu.add_test( "#2 global array", @test2.testGlobal )
	fbcu.add_test( "#2 param array" , @test2.testParam  )
	fbcu.add_test( "string local array" , @testString.testLocal  )
	fbcu.add_test( "string global array", @testString.testGlobal )
	fbcu.add_test( "string param array" , @testString.testParam  )
	fbcu.add_test( "array field, local"       , @arrayField.testLocalUdt       )
	fbcu.add_test( "array field, local array" , @arrayField.testLocalUdtArray  )
	fbcu.add_test( "array field, global"      , @arrayField.testGlobalUdt      )
	fbcu.add_test( "array field, global array", @arrayField.testGlobalUdtArray )
	fbcu.add_test( "string array field, local"       , @stringArrayField.testLocalUdt       )
	fbcu.add_test( "string array field, local array" , @stringArrayField.testLocalUdtArray  )
	fbcu.add_test( "string array field, global"      , @stringArrayField.testGlobalUdt      )
	fbcu.add_test( "string array field, global array", @stringArrayField.testGlobalUdtArray )
	fbcu.add_test( "dynamicArrayOfPointers", @dynamicArrayOfPointers.test )
end sub

end namespace
