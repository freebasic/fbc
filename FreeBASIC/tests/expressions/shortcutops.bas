#Include "fbcu.bi"

Namespace fbc_tests.expressions.shortcutops

	dim shared check_count as integer

	Private function ai() as integer
		function = 0
	end function
	
	Private function bi() as integer
		function = 5
	end function
	
	Private function af() as double
		function = 0.0
	end function
	
	Private function bf() as double
		function = 5.0
	end function
	
	Private function check( byval n as integer ) as integer
		check_count += 1
		function = n
	end function

        Private Sub test1 Cdecl 
		' General consts
		CU_ASSERT( (0 andalso 0) = 0 )
		CU_ASSERT( (0 andalso 1) = 0 )
		CU_ASSERT( (1 andalso 0) = 0 )
		CU_ASSERT( (1 andalso 1) = -1 )
		
		CU_ASSERT( (0 orelse 0) = 0 )
		CU_ASSERT( (0 orelse 1) = -1 )
		CU_ASSERT( (1 orelse 0) = -1 )
		CU_ASSERT( (1 orelse 1) = -1 )
        End Sub

        Private Sub test2 Cdecl 
		' Functions
		CU_ASSERT( (ai() andalso ai()) = 0 )
		CU_ASSERT( (ai() andalso bi()) = 0 )
		CU_ASSERT( (bi() andalso ai()) = 0 )
		CU_ASSERT( (bi() andalso bi()) = -1 )
		
		CU_ASSERT( (ai() orelse ai()) = 0 )
		CU_ASSERT( (ai() orelse bi()) = -1 )
		CU_ASSERT( (bi() orelse ai()) = -1 )
		CU_ASSERT( (bi() orelse bi()) = -1 )
        End Sub

        Private Sub test3 Cdecl 
		' General consts
		CU_ASSERT( (0.0 andalso 0.0) = 0 )
		CU_ASSERT( (0.0 andalso 1.0) = 0 )
		CU_ASSERT( (1.0 andalso 0.0) = 0 )
		CU_ASSERT( (1.0 andalso 1.0) = -1 )
		
		CU_ASSERT( (0.0 orelse 0.0) = 0 )
		CU_ASSERT( (0.0 orelse 1.0) = -1 )
		CU_ASSERT( (1.0 orelse 0.0) = -1 )
		CU_ASSERT( (1.0 orelse 1.0) = -1 )
        End Sub

        Private Sub test4 Cdecl 
		' Functions
		CU_ASSERT( (af() andalso af()) = 0 )
		CU_ASSERT( (af() andalso bf()) = 0 )
		CU_ASSERT( (bf() andalso af()) = 0 )
		CU_ASSERT( (bf() andalso bf()) = -1 )
		
		CU_ASSERT( (af() orelse af()) = 0 )
		CU_ASSERT( (af() orelse bf()) = -1 )
		CU_ASSERT( (bf() orelse af()) = -1 )
		CU_ASSERT( (bf() orelse bf()) = -1 )
        End Sub

        Private Sub test5 Cdecl 
		' Try some larger ones
		CU_ASSERT( (ai() andalso ai() andalso ai()) = 0)
		CU_ASSERT( (ai() andalso bi() andalso ai()) = 0)
		CU_ASSERT( (bi() andalso ai() andalso ai()) = 0)
		CU_ASSERT( (bi() andalso bi() andalso ai()) = 0)
		
		CU_ASSERT( (ai() andalso ai() andalso bi()) = 0)
		CU_ASSERT( (ai() andalso bi() andalso bi()) = 0)
		CU_ASSERT( (bi() andalso ai() andalso bi()) = 0)
		CU_ASSERT( (bi() andalso bi() andalso bi()) = -1)
		
		CU_ASSERT( (ai() orelse ai() orelse ai()) = 0)
		CU_ASSERT( (ai() orelse bi() orelse ai()) = -1)
		CU_ASSERT( (bi() orelse ai() orelse ai()) = -1)
		CU_ASSERT( (bi() orelse bi() orelse ai()) = -1)
		
		CU_ASSERT( (ai() orelse ai() orelse bi()) = -1)
		CU_ASSERT( (ai() orelse bi() orelse bi()) = -1)
		CU_ASSERT( (bi() orelse ai() orelse bi()) = -1)
		CU_ASSERT( (bi() orelse bi() orelse bi()) = -1)
        End Sub

        Private Sub test6 Cdecl 
		' Check the rhs really isn't being exectuted
		dim as integer temp
		
		temp = check(0) andalso check(0)
		CU_ASSERT( check_count = 1 )
		
		temp = check(1) orelse check(1)
		CU_ASSERT( check_count = 2 )
        End Sub

        Private Sub test7 Cdecl 
		' Try a few self ops
		dim as integer t1, t2
		
		t1 = 0
		t2 = 0
		t1 andalso= t2
		CU_ASSERT( t1 = 0 )
		
		t1 = 0
		t2 = 1
		t1 andalso= t2
		CU_ASSERT( t1 = 0 )
		
		t1 = 1
		t2 = 0
		t1 andalso= t2
		CU_ASSERT( t1 = 0 )
		
		t1 = 1
		t2 = 1
		t1 andalso= t2
		CU_ASSERT( t1 = -1 )
		
		t1 = 0
		t2 = 0
		t1 orelse= t2
		CU_ASSERT( t1 = 0 )
		
		t1 = 0
		t2 = 1
		t1 orelse= t2
		CU_ASSERT( t1 = -1 )
		
		t1 = 1
		t2 = 0
		t1 orelse= t2
		CU_ASSERT( t1 = -1 )
		
		t1 = 1
		t2 = 1
		t1 orelse= t2
		CU_ASSERT( t1 = -1 )
        End Sub

        Private Sub ctor () Constructor
       
                fbcu.add_suite("fbc_tests.expressions.shortcutops")
                fbcu.add_test("test1", @test1)
                fbcu.add_test("test2", @test2)
                fbcu.add_test("test3", @test3)
                fbcu.add_test("test4", @test4)
                fbcu.add_test("test5", @test5)
                fbcu.add_test("test6", @test6)
                fbcu.add_test("test7", @test7)

        End Sub

End Namespace
