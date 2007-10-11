' TEST_MODE : COMPILE_AND_RUN_OK

	if open( __FILE__ for input as #1 ) <> 0 then
		assert( 0 )
	end if
	
	close #1
	