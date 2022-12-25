':: ctor_byref : constructor calls when passed bydesc

#include "fbcunit.bi"

SUITE( fbc_tests.structs.ctor_bydesc )

	type foo
		array as double ptr
		items as integer
		declare constructor (arr() as double)
	end type

	constructor foo (arr() as double)
		array = @arr(lbound(arr))
		items = (ubound(arr) - lbound(arr)) + 1
	end constructor

	sub do_test( footb() as foo )

		CU_ASSERT_EQUAL( footb(1).items, 3 )
		CU_ASSERT_EQUAL( footb(2).items, 4 )

		for i as integer = 0 To 2
			CU_ASSERT_EQUAL( footb(1).array[i], 1 + i )
		next

		for i as integer = 0 To 3
			CU_ASSERT_EQUAL( footb(2).array[i], -(1 + i) )
		next
	end sub

	TEST( local )
		dim arr1(1 To 3) As double = {1, 2, 3}
		dim arr2(1 To 4) As double = {-1, -2, -3, -4}
		dim footb(1 To 2) As foo = {arr1(), arr2()}

		CU_ASSERT( footb(1).array = @arr1(1) )
		CU_ASSERT( footb(1).items = 3 )
		CU_ASSERT( footb(2).array = @arr2(1) )
		CU_ASSERT( footb(2).items = 4 )

		do_test( footb() )
	END_TEST

	TEST( static_local )
		static arr1(1 To 3) As double = {1, 2, 3}
		static arr2(1 To 4) As double = {-1, -2, -3, -4}
		static footb(1 To 2) As foo = {arr1(), arr2()}

		CU_ASSERT( footb(1).array = @arr1(1) )
		CU_ASSERT( footb(1).items = 3 )
		CU_ASSERT( footb(2).array = @arr2(1) )
		CU_ASSERT( footb(2).items = 4 )

		do_test( footb() )
	END_TEST

	dim shared g_arr1(1 To 3) As double = {1, 2, 3}
	dim shared g_arr2(1 To 4) As double = {-1, -2, -3, -4}
	dim shared g_arr3(1 To 5) As double = {11, 22, 33, 44, 55}
	dim shared g_footb(1 To 3) As foo = {g_arr1(), g_arr2(), g_arr3()}

	TEST( global )
		CU_ASSERT( g_footb(1).array = @g_arr1(1) )
		CU_ASSERT( g_footb(1).items = 3 )
		CU_ASSERT( g_footb(2).array = @g_arr2(1) )
		CU_ASSERT( g_footb(2).items = 4 )
		CU_ASSERT( g_footb(3).array = @g_arr3(1) )
		CU_ASSERT( g_footb(3).items = 5 )

		do_test( g_footb() )
	END_TEST

END_SUITE
