' TEST_MODE : COMPILE_AND_RUN_OK

	if open( "scrn:" for output as #1 ) <> 0 then
		end 1
	end if
	
	close #1
	