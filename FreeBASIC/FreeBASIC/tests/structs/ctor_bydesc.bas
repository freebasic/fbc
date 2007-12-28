':: ctor_byref : constructor calls when passed bydesc
 
# include "fbcu.bi"
 
namespace fbc_tests.structs.ctor_bydesc
 
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
	
	sub test_local cdecl
		dim arr1(1 To 3) As double = {1, 2, 3}
		dim arr2(1 To 4) As double = {-1, -2, -3, -4}
		dim footb(1 To 2) As foo = {arr1(), arr2()}

	    CU_ASSERT( footb(1).array = @arr1(1) )
	    CU_ASSERT( footb(1).items = 3 )
	    CU_ASSERT( footb(2).array = @arr2(1) )
	    CU_ASSERT( footb(2).items = 4 )

		do_test( footb() )
	end sub
	
	sub test_static_local cdecl
		static arr1(1 To 3) As double = {1, 2, 3}
		static arr2(1 To 4) As double = {-1, -2, -3, -4}
		static footb(1 To 2) As foo = {arr1(), arr2()}

	    CU_ASSERT( footb(1).array = @arr1(1) )
	    CU_ASSERT( footb(1).items = 3 )
	    CU_ASSERT( footb(2).array = @arr2(1) )
	    CU_ASSERT( footb(2).items = 4 )

		do_test( footb() )
	end sub
	
		dim shared g_arr1(1 To 3) As double = {1, 2, 3}
		dim shared g_arr2(1 To 4) As double = {-1, -2, -3, -4}
		dim shared g_footb(1 To 2) As foo = {g_arr1(), g_arr2()}
	
	sub test_global cdecl
	    CU_ASSERT( g_footb(1).array = @g_arr1(1) )
	    CU_ASSERT( g_footb(1).items = 3 )
	    CU_ASSERT( g_footb(2).array = @g_arr2(1) )
	    CU_ASSERT( g_footb(2).items = 4 )

		do_test( g_footb() )
	end sub
	
	private sub ctor () constructor
		fbcu.add_suite("fb-tests-structs:ctor-bydesc")
		fbcu.add_test("test_local", @test_local)
		fbcu.add_test("test_static_local", @test_static_local)
		fbcu.add_test("test_global", @test_global)
	end sub
 
end namespace