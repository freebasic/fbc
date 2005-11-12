
	dim i as integer, dp as integer pointer
	dim array(0 to 4) as integer 

	for i = 0 to 4 
  		array(i) = i 
	next 

	dp = @array(0)

	for i = 0 to 4 
  		assert( dp[i] = i )
	next 
