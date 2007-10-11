# include "fbcu.bi"

namespace fbc_tests.dim_.array_init

sub test1 cdecl
	dim as integer array(1 to 2, 1 to 2, 1 to 3) = _ 
	  { _
			{ _
	  			{1, 2, 3}, _
	  			{4, 5, 6} _
	  		}, _
	  		{ _
	  			{7, 8, 9}, _ 
	  			{10,11,12} _
	  		} _
	  }  

	dim as integer cnt, i, j, k
	
	cnt = 1
	for i = 1 to 2
		for j = 1 to 2
			for k = 1 to 3
				CU_ASSERT( array(i, j, k) = cnt )
				cnt += 1
			next
		next
	next
		
end sub

sub test2 cdecl
	dim as integer array(1 to 2+1, 1 to 2+1, 1 to 3+1) = _ 
	  { _
			{ _
	  			{1, 2, 3}, _
	  			{4, 5, 6} _
	  		}, _
	  		{ _
	  			{7, 8, 9}, _ 
	  			{10,11,12} _
	  		} _
	  }  

	dim as integer cnt, i, j, k
	
	cnt = 1
	for i = 1 to 2
		for j = 1 to 2
			for k = 1 to 3
				CU_ASSERT( array(i, j, k) = cnt )
				cnt += 1
			next
			CU_ASSERT( array(i, j, 4) = 0 )
		next
		
		for k = 1 to 3+1
			CU_ASSERT( array(i, 3, k) = 0 )
		next
	next

	for j = 1 to 2+1
		for k = 1 to 3+1
			CU_ASSERT( array(3, j, k) = 0 )
		next
	next
		
end sub

sub test3 cdecl static
	dim as integer array(1 to 2, 1 to 2, 1 to 3) = _ 
	  { _
			{ _
	  			{1, 2, 3}, _
	  			{4, 5, 6} _
	  		}, _
	  		{ _
	  			{7, 8, 9}, _ 
	  			{10,11,12} _
	  		} _
	  }  

	dim as integer cnt, i, j, k
	
	cnt = 1
	for i = 1 to 2
		for j = 1 to 2
			for k = 1 to 3
				CU_ASSERT( array(i, j, k) = cnt )
				cnt += 1
			next
		next
	next
		
end sub

sub test4 cdecl static
	dim as integer array(1 to 2+1, 1 to 2+1, 1 to 3+1) = _ 
	  { _
			{ _
	  			{1, 2, 3}, _
	  			{4, 5, 6} _
	  		}, _
	  		{ _
	  			{7, 8, 9}, _ 
	  			{10,11,12} _
	  		} _
	  }  

	dim as integer cnt, i, j, k
	
	cnt = 1
	for i = 1 to 2
		for j = 1 to 2
			for k = 1 to 3
				CU_ASSERT( array(i, j, k) = cnt )
				cnt += 1
			next
			CU_ASSERT( array(i, j, 4) = 0 )
		next
		
		for k = 1 to 3+1
			CU_ASSERT( array(i, 3, k) = 0 )
		next
	next

	for j = 1 to 2+1
		for k = 1 to 3+1
			CU_ASSERT( array(3, j, k) = 0 )
		next
	next
		
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.dim.array_init")
	fbcu.add_test("test 1", @test1)
	fbcu.add_test("test 2", @test2)
	fbcu.add_test("test 3", @test3)
	fbcu.add_test("test 1", @test4)

end sub

end namespace
	