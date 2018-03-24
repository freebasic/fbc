# include "fbcunit.bi"

SUITE( fbc_tests.functions.bydesc )

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

	TEST_GROUP( test1 )
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

		'' #1 local array
		TEST( local1 )
			redim as integer localarray(ARRAY_LB to ARRAY_UB)
			fillArray( localarray() )
			doTest( localarray() )
		END_TEST

		dim shared as integer globalarray(ARRAY_LB to ARRAY_UB)

		'' #1 global array
		TEST( global1 )
			fillArray( globalarray() )
			doTest( globalarray() )
		END_TEST

		'' #1 param array
		TEST( param1 )
			fillArray( globalarray() )
			doTestPre( globalarray() )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( test2 )
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

		'' #2 local array
		TEST( local2 )
			dim as double localarray(ARRAY_LB1 to ARRAY_UB1, ARRAY_LB2 to ARRAY_UB2)
			doTest( localarray() )
		END_TEST

		dim shared as double globalarray(ARRAY_LB1 to ARRAY_UB1, ARRAY_LB2 to ARRAY_UB2)

		'' #2 global array
		TEST( global2 )
			doTest( globalarray() )
		END_TEST

		'' #2 param array
		TEST( param2 )
			doTestPre( globalarray() )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( string_ )
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

		'' string local array
		TEST( localStringArray )
			redim as string localarray(ARRAY_LB to ARRAY_UB)
			fillArray( localarray() )
			doTest( localarray() )
		END_TEST

		dim shared as string globalarray(ARRAY_LB to ARRAY_UB)

		'' string global array
		TEST( globalStringArray )
			fillArray( globalarray() )
			doTest( globalarray() )
		END_TEST

		'' string param array
		TEST( paramStringArray )
			fillArray( globalarray() )
			doTestPre( globalarray() )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( arrayField )
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

		'' array field, local
		TEST( localVarUdtArrayField )
			dim as UDT localudt
			fillArray( localudt.field1() )
			dotest( localudt.field1() )
		END_TEST

		'' array field, local array
		TEST( localArrayUdtArrayField )
			redim as UDT localudtarray(0 to 1)
			fillArray( localudtarray(1).field1() )
			doTest( localudtarray(1).field1() )
		END_TEST

		dim shared as UDT globaludt

		'' array field, global
		TEST( globalVarUdtArrayField )
			fillArray( globaludt.field1() )
			doTest( globaludt.field1() )
		END_TEST

		dim shared as UDT globaludtarray(0 to 1)

		'' array field, global arrray
		TEST( globalArrayUdtArrayField )
			fillArray( globaludtarray(1).field1() )
			doTest( globaludtarray(1).field1() )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( stringArrayField )
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

		'' string array field, local
		TEST( localVarUdtStringArrayField )
			dim as UDT localudt
			fillArray( localudt.field1() )
			dotest( localudt.field1() )
		END_TEST

		'' string array field, local array
		TEST( localArrayUdtStringArrayField )
			redim as UDT localudtarray(0 to 1)
			fillArray( localudtarray(1).field1() )
			doTest( localudtarray(1).field1() )
		END_TEST

		dim shared as UDT globaludt

		'' string array field, global
		TEST( globalVarUdtStringArrayField )
			fillArray( globaludt.field1() )
			doTest( globaludt.field1() )
		END_TEST

		dim shared as UDT globaludtarray(0 to 1)

		'' string array field, global array
		TEST( globalArrayUdtStringArrayField )
			fillArray( globaludtarray(1).field1() )
			doTest( globaludtarray(1).field1() )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( pointers )
		'' -gen gcc regression test (handling of array descriptors if it's an
		'' array of pointers)

		dim shared as integer i0, i1

		sub f( array(any) as integer ptr )
			*array(0) = 123
			*array(1) = 456
			CU_ASSERT( *array(0) = 123 )
			CU_ASSERT( *array(1) = 456 )
		end sub

		TEST( dynamicArrayOfPointers )
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
		END_TEST
	END_TEST_GROUP

END_SUITE

