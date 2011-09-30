''
'' simple inkey test
''

	dim as string k

	do
		k = inkey
		if( len( k ) > 0 ) then
			print len( k ), k, asc( k ),
			if( len( k ) > 1 ) then
				print asc( right( k, 1 ) )
			else
				print
			end if
		end if
		
		sleep 25
	loop until k = chr( 27 )
