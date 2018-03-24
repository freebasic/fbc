# include "fbcunit.bi"

SUITE( fbc_tests.dim_.array_init )

	TEST( constDims )
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
			
	END_TEST

	TEST( constExprDims )
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
			
	END_TEST

	private sub constDimsStatic_proc( ) static
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

	TEST( constDimsStatic )
		constDimsStatic_proc()
	END_TEST

	private sub constExprDimsStatic_proc( ) static
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
				
	TEST( constExprDimsStatic )
		constExprDimsStatic_proc()
	END_TEST

END_SUITE
