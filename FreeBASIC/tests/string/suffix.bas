
	dim shared s$

sub mysub ( byval s$ )
	'' local
	s$ = "1234"
end sub

	'' global
	s$ = "5678"
	
	tmp$ = space( 4 )
	mysub( tmp$ )
	
	assert( s$ = "5678" )
