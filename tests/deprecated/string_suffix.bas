' TEST_MODE : COMPILE_AND_RUN_OK

sub mysub ( byval s$ )
	'' local
	s$ = "1234"
end sub

	'' global
	s$ = "5678"
	
	tmp$ = space( 4 )
	mysub( tmp$ )
	
	assert( s$ = "5678" )
