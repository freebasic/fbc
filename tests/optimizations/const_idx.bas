#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.const_idx )

	TEST( index1 )
		dim as integer x = 0, brd(8, 8, 9)
		cu_assert_equal( @brd(1, 0, 0), @brd(1, x, 0) )
		cu_assert_equal( @brd(1, 0, 0), @brd(1, 0, x) )
		cu_assert_equal( @brd(1, 0, 0), @brd(1, x, x) )
	END_TEST

	TEST( index2 )
		dim as integer array(0 to 0)
		dim as integer i = -2

		'' Standalone this expression works fine
		CU_ASSERT( (i+2)*(-1) = 0 )

		'' but when inside an IDX, it caused the IDX to be misoptimized
		CU_ASSERT( @array((i+2)*(-1)) = @array(0) )
	END_TEST

	TEST( heap )
		static array_heap_1(0 to 1, 0 to 1) as zstring * 1
		static array_heap_2(0 to 1, 0 to 1) as zstring * 2
		static array_heap_3(0 to 1, 0 to 1) as zstring * 3
		static array_heap_4(0 to 1, 0 to 1) as zstring * 4
		static array_heap_5(0 to 1, 0 to 1) as zstring * 5
		static array_heap_6(0 to 1, 0 to 1) as zstring * 6
		static array_heap_7(0 to 1, 0 to 1) as zstring * 7
		static array_heap_8(0 to 1, 0 to 1) as zstring * 8
		static array_heap_9(0 to 1, 0 to 1) as zstring * 9
		static array_heap_10(0 to 1, 0 to 1) as zstring * 10

		for i as integer = 0 to 1
			for j as integer = 0 to 1
				array_heap_1(i,j) = str(i) + "," + str(j)
				array_heap_2(i,j) = str(i) + "," + str(j)
				array_heap_3(i,j) = str(i) + "," + str(j)
				array_heap_4(i,j) = str(i) + "," + str(j)
				array_heap_5(i,j) = str(i) + "," + str(j)
				array_heap_6(i,j) = str(i) + "," + str(j)
				array_heap_7(i,j) = str(i) + "," + str(j)
				array_heap_8(i,j) = str(i) + "," + str(j)
				array_heap_9(i,j) = str(i) + "," + str(j)
				array_heap_10(i,j) = str(i) + "," + str(j)
			next
		next

		var i0 = 0, i1 = 1

		''--------------------------------------------------------------------

		CU_ASSERT( array_heap_1(0,0) = "" )
		CU_ASSERT( array_heap_1(0,1) = "" )
		CU_ASSERT( array_heap_1(1,0) = "" )
		CU_ASSERT( array_heap_1(1,1) = "" )

		CU_ASSERT( array_heap_2(0,0) = "0" )
		CU_ASSERT( array_heap_2(0,1) = "0" )
		CU_ASSERT( array_heap_2(1,0) = "1" )
		CU_ASSERT( array_heap_2(1,1) = "1" )

		CU_ASSERT( array_heap_3(0,0) = "0," )
		CU_ASSERT( array_heap_3(0,1) = "0," )
		CU_ASSERT( array_heap_3(1,0) = "1," )
		CU_ASSERT( array_heap_3(1,1) = "1," )

		CU_ASSERT( array_heap_4(0,0) = "0,0" )
		CU_ASSERT( array_heap_4(0,1) = "0,1" )
		CU_ASSERT( array_heap_4(1,0) = "1,0" )
		CU_ASSERT( array_heap_4(1,1) = "1,1" )

		CU_ASSERT( array_heap_5(0,0) = "0,0" )
		CU_ASSERT( array_heap_5(0,1) = "0,1" )
		CU_ASSERT( array_heap_5(1,0) = "1,0" )
		CU_ASSERT( array_heap_5(1,1) = "1,1" )

		CU_ASSERT( array_heap_6(0,0) = "0,0" )
		CU_ASSERT( array_heap_6(0,1) = "0,1" )
		CU_ASSERT( array_heap_6(1,0) = "1,0" )
		CU_ASSERT( array_heap_6(1,1) = "1,1" )

		CU_ASSERT( array_heap_7(0,0) = "0,0" )
		CU_ASSERT( array_heap_7(0,1) = "0,1" )
		CU_ASSERT( array_heap_7(1,0) = "1,0" )
		CU_ASSERT( array_heap_7(1,1) = "1,1" )

		CU_ASSERT( array_heap_8(0,0) = "0,0" )
		CU_ASSERT( array_heap_8(0,1) = "0,1" )
		CU_ASSERT( array_heap_8(1,0) = "1,0" )
		CU_ASSERT( array_heap_8(1,1) = "1,1" )

		CU_ASSERT( array_heap_9(0,0) = "0,0" )
		CU_ASSERT( array_heap_9(0,1) = "0,1" )
		CU_ASSERT( array_heap_9(1,0) = "1,0" )
		CU_ASSERT( array_heap_9(1,1) = "1,1" )

		CU_ASSERT( array_heap_10(0,0) = "0,0" )
		CU_ASSERT( array_heap_10(0,1) = "0,1" )
		CU_ASSERT( array_heap_10(1,0) = "1,0" )
		CU_ASSERT( array_heap_10(1,1) = "1,1" )

		''--------------------------------------------------------------------

		CU_ASSERT( array_heap_1(i0,0) = "" )
		CU_ASSERT( array_heap_1(i0,1) = "" )
		CU_ASSERT( array_heap_1(i1,0) = "" )
		CU_ASSERT( array_heap_1(i1,1) = "" )

		CU_ASSERT( array_heap_2(i0,0) = "0" )
		CU_ASSERT( array_heap_2(i0,1) = "0" )
		CU_ASSERT( array_heap_2(i1,0) = "1" )
		CU_ASSERT( array_heap_2(i1,1) = "1" )

		CU_ASSERT( array_heap_3(i0,0) = "0," )
		CU_ASSERT( array_heap_3(i0,1) = "0," )
		CU_ASSERT( array_heap_3(i1,0) = "1," )
		CU_ASSERT( array_heap_3(i1,1) = "1," )

		CU_ASSERT( array_heap_4(i0,0) = "0,0" )
		CU_ASSERT( array_heap_4(i0,1) = "0,1" )
		CU_ASSERT( array_heap_4(i1,0) = "1,0" )
		CU_ASSERT( array_heap_4(i1,1) = "1,1" )

		CU_ASSERT( array_heap_5(i0,0) = "0,0" )
		CU_ASSERT( array_heap_5(i0,1) = "0,1" )
		CU_ASSERT( array_heap_5(i1,0) = "1,0" )
		CU_ASSERT( array_heap_5(i1,1) = "1,1" )

		CU_ASSERT( array_heap_6(i0,0) = "0,0" )
		CU_ASSERT( array_heap_6(i0,1) = "0,1" )
		CU_ASSERT( array_heap_6(i1,0) = "1,0" )
		CU_ASSERT( array_heap_6(i1,1) = "1,1" )

		CU_ASSERT( array_heap_7(i0,0) = "0,0" )
		CU_ASSERT( array_heap_7(i0,1) = "0,1" )
		CU_ASSERT( array_heap_7(i1,0) = "1,0" )
		CU_ASSERT( array_heap_7(i1,1) = "1,1" )

		CU_ASSERT( array_heap_8(i0,0) = "0,0" )
		CU_ASSERT( array_heap_8(i0,1) = "0,1" )
		CU_ASSERT( array_heap_8(i1,0) = "1,0" )
		CU_ASSERT( array_heap_8(i1,1) = "1,1" )

		CU_ASSERT( array_heap_9(i0,0) = "0,0" )
		CU_ASSERT( array_heap_9(i0,1) = "0,1" )
		CU_ASSERT( array_heap_9(i1,0) = "1,0" )
		CU_ASSERT( array_heap_9(i1,1) = "1,1" )

		CU_ASSERT( array_heap_10(i0,0) = "0,0" )
		CU_ASSERT( array_heap_10(i0,1) = "0,1" )
		CU_ASSERT( array_heap_10(i1,0) = "1,0" )
		CU_ASSERT( array_heap_10(i1,1) = "1,1" )

		''--------------------------------------------------------------------

		CU_ASSERT( array_heap_1(0,i0) = "" )
		CU_ASSERT( array_heap_1(0,i1) = "" )
		CU_ASSERT( array_heap_1(1,i0) = "" )
		CU_ASSERT( array_heap_1(1,i1) = "" )

		CU_ASSERT( array_heap_2(0,i0) = "0" )
		CU_ASSERT( array_heap_2(0,i1) = "0" )
		CU_ASSERT( array_heap_2(1,i0) = "1" )
		CU_ASSERT( array_heap_2(1,i1) = "1" )

		CU_ASSERT( array_heap_3(0,i0) = "0," )
		CU_ASSERT( array_heap_3(0,i1) = "0," )
		CU_ASSERT( array_heap_3(1,i0) = "1," )
		CU_ASSERT( array_heap_3(1,i1) = "1," )

		CU_ASSERT( array_heap_4(0,i0) = "0,0" )
		CU_ASSERT( array_heap_4(0,i1) = "0,1" )
		CU_ASSERT( array_heap_4(1,i0) = "1,0" )
		CU_ASSERT( array_heap_4(1,i1) = "1,1" )

		CU_ASSERT( array_heap_5(0,i0) = "0,0" )
		CU_ASSERT( array_heap_5(0,i1) = "0,1" )
		CU_ASSERT( array_heap_5(1,i0) = "1,0" )
		CU_ASSERT( array_heap_5(1,i1) = "1,1" )

		CU_ASSERT( array_heap_6(0,i0) = "0,0" )
		CU_ASSERT( array_heap_6(0,i1) = "0,1" )
		CU_ASSERT( array_heap_6(1,i0) = "1,0" )
		CU_ASSERT( array_heap_6(1,i1) = "1,1" )

		CU_ASSERT( array_heap_7(0,i0) = "0,0" )
		CU_ASSERT( array_heap_7(0,i1) = "0,1" )
		CU_ASSERT( array_heap_7(1,i0) = "1,0" )
		CU_ASSERT( array_heap_7(1,i1) = "1,1" )

		CU_ASSERT( array_heap_8(0,i0) = "0,0" )
		CU_ASSERT( array_heap_8(0,i1) = "0,1" )
		CU_ASSERT( array_heap_8(1,i0) = "1,0" )
		CU_ASSERT( array_heap_8(1,i1) = "1,1" )

		CU_ASSERT( array_heap_9(0,i0) = "0,0" )
		CU_ASSERT( array_heap_9(0,i1) = "0,1" )
		CU_ASSERT( array_heap_9(1,i0) = "1,0" )
		CU_ASSERT( array_heap_9(1,i1) = "1,1" )

		CU_ASSERT( array_heap_10(0,i0) = "0,0" )
		CU_ASSERT( array_heap_10(0,i1) = "0,1" )
		CU_ASSERT( array_heap_10(1,i0) = "1,0" )
		CU_ASSERT( array_heap_10(1,i1) = "1,1" )

		''--------------------------------------------------------------------

		CU_ASSERT( array_heap_1(i0,i0) = "" )
		CU_ASSERT( array_heap_1(i0,i1) = "" )
		CU_ASSERT( array_heap_1(i1,i0) = "" )
		CU_ASSERT( array_heap_1(i1,i1) = "" )

		CU_ASSERT( array_heap_2(i0,i0) = "0" )
		CU_ASSERT( array_heap_2(i0,i1) = "0" )
		CU_ASSERT( array_heap_2(i1,i0) = "1" )
		CU_ASSERT( array_heap_2(i1,i1) = "1" )

		CU_ASSERT( array_heap_3(i0,i0) = "0," )
		CU_ASSERT( array_heap_3(i0,i1) = "0," )
		CU_ASSERT( array_heap_3(i1,i0) = "1," )
		CU_ASSERT( array_heap_3(i1,i1) = "1," )

		CU_ASSERT( array_heap_4(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_4(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_4(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_4(i1,i1) = "1,1" )

		CU_ASSERT( array_heap_5(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_5(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_5(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_5(i1,i1) = "1,1" )

		CU_ASSERT( array_heap_6(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_6(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_6(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_6(i1,i1) = "1,1" )

		CU_ASSERT( array_heap_7(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_7(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_7(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_7(i1,i1) = "1,1" )

		CU_ASSERT( array_heap_8(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_8(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_8(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_8(i1,i1) = "1,1" )

		CU_ASSERT( array_heap_9(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_9(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_9(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_9(i1,i1) = "1,1" )

		CU_ASSERT( array_heap_10(i0,i0) = "0,0" )
		CU_ASSERT( array_heap_10(i0,i1) = "0,1" )
		CU_ASSERT( array_heap_10(i1,i0) = "1,0" )
		CU_ASSERT( array_heap_10(i1,i1) = "1,1" )
	END_TEST

	TEST( stack )
		dim array_stack_1(0 to 1, 0 to 1) as zstring * 1
		dim array_stack_2(0 to 1, 0 to 1) as zstring * 2
		dim array_stack_3(0 to 1, 0 to 1) as zstring * 3
		dim array_stack_4(0 to 1, 0 to 1) as zstring * 4
		dim array_stack_5(0 to 1, 0 to 1) as zstring * 5
		dim array_stack_6(0 to 1, 0 to 1) as zstring * 6
		dim array_stack_7(0 to 1, 0 to 1) as zstring * 7
		dim array_stack_8(0 to 1, 0 to 1) as zstring * 8
		dim array_stack_9(0 to 1, 0 to 1) as zstring * 9
		dim array_stack_10(0 to 1, 0 to 1) as zstring * 10

		for i as integer = 0 to 1
			for j as integer = 0 to 1
				array_stack_1(i,j) = str(i) + "," + str(j)
				array_stack_2(i,j) = str(i) + "," + str(j)
				array_stack_3(i,j) = str(i) + "," + str(j)
				array_stack_4(i,j) = str(i) + "," + str(j)
				array_stack_5(i,j) = str(i) + "," + str(j)
				array_stack_6(i,j) = str(i) + "," + str(j)
				array_stack_7(i,j) = str(i) + "," + str(j)
				array_stack_8(i,j) = str(i) + "," + str(j)
				array_stack_9(i,j) = str(i) + "," + str(j)
				array_stack_10(i,j) = str(i) + "," + str(j)
			next
		next

		var i0 = 0, i1 = 1

		''--------------------------------------------------------------------

		CU_ASSERT( array_stack_1(0,0) = "" )
		CU_ASSERT( array_stack_1(0,1) = "" )
		CU_ASSERT( array_stack_1(1,0) = "" )
		CU_ASSERT( array_stack_1(1,1) = "" )

		CU_ASSERT( array_stack_2(0,0) = "0" )
		CU_ASSERT( array_stack_2(0,1) = "0" )
		CU_ASSERT( array_stack_2(1,0) = "1" )
		CU_ASSERT( array_stack_2(1,1) = "1" )

		CU_ASSERT( array_stack_3(0,0) = "0," )
		CU_ASSERT( array_stack_3(0,1) = "0," )
		CU_ASSERT( array_stack_3(1,0) = "1," )
		CU_ASSERT( array_stack_3(1,1) = "1," )

		CU_ASSERT( array_stack_4(0,0) = "0,0" )
		CU_ASSERT( array_stack_4(0,1) = "0,1" )
		CU_ASSERT( array_stack_4(1,0) = "1,0" )
		CU_ASSERT( array_stack_4(1,1) = "1,1" )

		CU_ASSERT( array_stack_5(0,0) = "0,0" )
		CU_ASSERT( array_stack_5(0,1) = "0,1" )
		CU_ASSERT( array_stack_5(1,0) = "1,0" )
		CU_ASSERT( array_stack_5(1,1) = "1,1" )

		CU_ASSERT( array_stack_6(0,0) = "0,0" )
		CU_ASSERT( array_stack_6(0,1) = "0,1" )
		CU_ASSERT( array_stack_6(1,0) = "1,0" )
		CU_ASSERT( array_stack_6(1,1) = "1,1" )

		CU_ASSERT( array_stack_7(0,0) = "0,0" )
		CU_ASSERT( array_stack_7(0,1) = "0,1" )
		CU_ASSERT( array_stack_7(1,0) = "1,0" )
		CU_ASSERT( array_stack_7(1,1) = "1,1" )

		CU_ASSERT( array_stack_8(0,0) = "0,0" )
		CU_ASSERT( array_stack_8(0,1) = "0,1" )
		CU_ASSERT( array_stack_8(1,0) = "1,0" )
		CU_ASSERT( array_stack_8(1,1) = "1,1" )

		CU_ASSERT( array_stack_9(0,0) = "0,0" )
		CU_ASSERT( array_stack_9(0,1) = "0,1" )
		CU_ASSERT( array_stack_9(1,0) = "1,0" )
		CU_ASSERT( array_stack_9(1,1) = "1,1" )

		CU_ASSERT( array_stack_10(0,0) = "0,0" )
		CU_ASSERT( array_stack_10(0,1) = "0,1" )
		CU_ASSERT( array_stack_10(1,0) = "1,0" )
		CU_ASSERT( array_stack_10(1,1) = "1,1" )

		''--------------------------------------------------------------------

		CU_ASSERT( array_stack_1(i0,0) = "" )
		CU_ASSERT( array_stack_1(i0,1) = "" )
		CU_ASSERT( array_stack_1(i1,0) = "" )
		CU_ASSERT( array_stack_1(i1,1) = "" )

		CU_ASSERT( array_stack_2(i0,0) = "0" )
		CU_ASSERT( array_stack_2(i0,1) = "0" )
		CU_ASSERT( array_stack_2(i1,0) = "1" )
		CU_ASSERT( array_stack_2(i1,1) = "1" )

		CU_ASSERT( array_stack_3(i0,0) = "0," )
		CU_ASSERT( array_stack_3(i0,1) = "0," )
		CU_ASSERT( array_stack_3(i1,0) = "1," )
		CU_ASSERT( array_stack_3(i1,1) = "1," )

		CU_ASSERT( array_stack_4(i0,0) = "0,0" )
		CU_ASSERT( array_stack_4(i0,1) = "0,1" )
		CU_ASSERT( array_stack_4(i1,0) = "1,0" )
		CU_ASSERT( array_stack_4(i1,1) = "1,1" )

		CU_ASSERT( array_stack_5(i0,0) = "0,0" )
		CU_ASSERT( array_stack_5(i0,1) = "0,1" )
		CU_ASSERT( array_stack_5(i1,0) = "1,0" )
		CU_ASSERT( array_stack_5(i1,1) = "1,1" )

		CU_ASSERT( array_stack_6(i0,0) = "0,0" )
		CU_ASSERT( array_stack_6(i0,1) = "0,1" )
		CU_ASSERT( array_stack_6(i1,0) = "1,0" )
		CU_ASSERT( array_stack_6(i1,1) = "1,1" )

		CU_ASSERT( array_stack_7(i0,0) = "0,0" )
		CU_ASSERT( array_stack_7(i0,1) = "0,1" )
		CU_ASSERT( array_stack_7(i1,0) = "1,0" )
		CU_ASSERT( array_stack_7(i1,1) = "1,1" )

		CU_ASSERT( array_stack_8(i0,0) = "0,0" )
		CU_ASSERT( array_stack_8(i0,1) = "0,1" )
		CU_ASSERT( array_stack_8(i1,0) = "1,0" )
		CU_ASSERT( array_stack_8(i1,1) = "1,1" )

		CU_ASSERT( array_stack_9(i0,0) = "0,0" )
		CU_ASSERT( array_stack_9(i0,1) = "0,1" )
		CU_ASSERT( array_stack_9(i1,0) = "1,0" )
		CU_ASSERT( array_stack_9(i1,1) = "1,1" )

		CU_ASSERT( array_stack_10(i0,0) = "0,0" )
		CU_ASSERT( array_stack_10(i0,1) = "0,1" )
		CU_ASSERT( array_stack_10(i1,0) = "1,0" )
		CU_ASSERT( array_stack_10(i1,1) = "1,1" )

		''--------------------------------------------------------------------

		CU_ASSERT( array_stack_1(0,i0) = "" )
		CU_ASSERT( array_stack_1(0,i1) = "" )
		CU_ASSERT( array_stack_1(1,i0) = "" )
		CU_ASSERT( array_stack_1(1,i1) = "" )

		CU_ASSERT( array_stack_2(0,i0) = "0" )
		CU_ASSERT( array_stack_2(0,i1) = "0" )
		CU_ASSERT( array_stack_2(1,i0) = "1" )
		CU_ASSERT( array_stack_2(1,i1) = "1" )

		CU_ASSERT( array_stack_3(0,i0) = "0," )
		CU_ASSERT( array_stack_3(0,i1) = "0," )
		CU_ASSERT( array_stack_3(1,i0) = "1," )
		CU_ASSERT( array_stack_3(1,i1) = "1," )

		CU_ASSERT( array_stack_4(0,i0) = "0,0" )
		CU_ASSERT( array_stack_4(0,i1) = "0,1" )
		CU_ASSERT( array_stack_4(1,i0) = "1,0" )
		CU_ASSERT( array_stack_4(1,i1) = "1,1" )

		CU_ASSERT( array_stack_5(0,i0) = "0,0" )
		CU_ASSERT( array_stack_5(0,i1) = "0,1" )
		CU_ASSERT( array_stack_5(1,i0) = "1,0" )
		CU_ASSERT( array_stack_5(1,i1) = "1,1" )

		CU_ASSERT( array_stack_6(0,i0) = "0,0" )
		CU_ASSERT( array_stack_6(0,i1) = "0,1" )
		CU_ASSERT( array_stack_6(1,i0) = "1,0" )
		CU_ASSERT( array_stack_6(1,i1) = "1,1" )

		CU_ASSERT( array_stack_7(0,i0) = "0,0" )
		CU_ASSERT( array_stack_7(0,i1) = "0,1" )
		CU_ASSERT( array_stack_7(1,i0) = "1,0" )
		CU_ASSERT( array_stack_7(1,i1) = "1,1" )

		CU_ASSERT( array_stack_8(0,i0) = "0,0" )
		CU_ASSERT( array_stack_8(0,i1) = "0,1" )
		CU_ASSERT( array_stack_8(1,i0) = "1,0" )
		CU_ASSERT( array_stack_8(1,i1) = "1,1" )

		CU_ASSERT( array_stack_9(0,i0) = "0,0" )
		CU_ASSERT( array_stack_9(0,i1) = "0,1" )
		CU_ASSERT( array_stack_9(1,i0) = "1,0" )
		CU_ASSERT( array_stack_9(1,i1) = "1,1" )

		CU_ASSERT( array_stack_10(0,i0) = "0,0" )
		CU_ASSERT( array_stack_10(0,i1) = "0,1" )
		CU_ASSERT( array_stack_10(1,i0) = "1,0" )
		CU_ASSERT( array_stack_10(1,i1) = "1,1" )

		''--------------------------------------------------------------------

		CU_ASSERT( array_stack_1(i0,i0) = "" )
		CU_ASSERT( array_stack_1(i0,i1) = "" )
		CU_ASSERT( array_stack_1(i1,i0) = "" )
		CU_ASSERT( array_stack_1(i1,i1) = "" )

		CU_ASSERT( array_stack_2(i0,i0) = "0" )
		CU_ASSERT( array_stack_2(i0,i1) = "0" )
		CU_ASSERT( array_stack_2(i1,i0) = "1" )
		CU_ASSERT( array_stack_2(i1,i1) = "1" )

		CU_ASSERT( array_stack_3(i0,i0) = "0," )
		CU_ASSERT( array_stack_3(i0,i1) = "0," )
		CU_ASSERT( array_stack_3(i1,i0) = "1," )
		CU_ASSERT( array_stack_3(i1,i1) = "1," )

		CU_ASSERT( array_stack_4(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_4(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_4(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_4(i1,i1) = "1,1" )

		CU_ASSERT( array_stack_5(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_5(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_5(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_5(i1,i1) = "1,1" )

		CU_ASSERT( array_stack_6(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_6(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_6(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_6(i1,i1) = "1,1" )

		CU_ASSERT( array_stack_7(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_7(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_7(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_7(i1,i1) = "1,1" )

		CU_ASSERT( array_stack_8(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_8(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_8(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_8(i1,i1) = "1,1" )

		CU_ASSERT( array_stack_9(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_9(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_9(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_9(i1,i1) = "1,1" )

		CU_ASSERT( array_stack_10(i0,i0) = "0,0" )
		CU_ASSERT( array_stack_10(i0,i1) = "0,1" )
		CU_ASSERT( array_stack_10(i1,i0) = "1,0" )
		CU_ASSERT( array_stack_10(i1,i1) = "1,1" )
	END_TEST

END_SUITE
