sub test1
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
				assert( array(i, j, k) = cnt )
				cnt += 1
			next
		next
	next
		
end sub

sub test2
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
				assert( array(i, j, k) = cnt )
				cnt += 1
			next
			assert( array(i, j, 4) = 0 )
		next
		
		for k = 1 to 3+1
			assert( array(i, 3, k) = 0 )
		next
	next

	for j = 1 to 2+1
		for k = 1 to 3+1
			assert( array(3, j, k) = 0 )
		next
	next
		
end sub

sub test3 static
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
				assert( array(i, j, k) = cnt )
				cnt += 1
			next
		next
	next
		
end sub

sub test4 static
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
				assert( array(i, j, k) = cnt )
				cnt += 1
			next
			assert( array(i, j, 4) = 0 )
		next
		
		for k = 1 to 3+1
			assert( array(i, 3, k) = 0 )
		next
	next

	for j = 1 to 2+1
		for k = 1 to 3+1
			assert( array(3, j, k) = 0 )
		next
	next
		
end sub

	test1
	test2
	test3
	test4